# How to add a Docusaurus website witnin Next js

## Prequisies to run the project

- Node.js

- pnpm 

```bash
npm install -g pnpm
```

## Steps to run the project in dev

1. Clone the project
2. Run the following commands
```bash
./setup.sh
```
3. Run your nextjs app

```bash
pnpm next-app dev
```
## Steps to run the project in prod

### Docker

1. Build the image in the root of the project
```bash
docker build -t nextjs-docusaurus .
```

2. Run the image
```bash
docker run -p 3000:3000 nextjs-docusaurus
```

### The other way

1. Remove the output: standalone from next.config.mjs
2. Run the following command in the root of the project
```bash
pnpm next-app build
```

3. Run the following command in the root of the project
```bash
pnpm next-app start
```