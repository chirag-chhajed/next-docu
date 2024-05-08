# Install dependencies
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
RUN corepack enable
RUN pnpm install --frozen-lockfile

# Build docu-app
FROM deps AS docu-app-build
COPY . .
COPY --from=deps /app/node_modules /app/
RUN pnpm deploy --filter=docu-app /prod/app/docu-app
WORKDIR /prod/app/docu-app
RUN pnpm build

# Deploy next-app and copy docu-app build
FROM deps AS next-app-build
COPY . .
COPY --from=deps /app/node_modules /app/
RUN pnpm deploy --filter=next-app /prod/app/next-app
WORKDIR /prod/app/next-app
COPY --from=docu-app-build /prod/app/docu-app/build /prod/app/next-app/public/docs
RUN pnpm build

FROM deps AS runner
WORKDIR /prod/app/next-app

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

COPY --from=next-app-build /prod/app/next-app/public ./public

RUN mkdir .next
RUN chown nextjs:nodejs .next

COPY --from=next-app-build --chown=nextjs:nodejs /prod/app/next-app/.next/standalone ./
COPY --from=next-app-build --chown=nextjs:nodejs /prod/app/next-app/.next/static ./.next/static

USER nextjs

EXPOSE 3000

ENV PORT 3000

CMD HOSTNAME="0.0.0.0" node server.js