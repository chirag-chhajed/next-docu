/** @type {import('next').NextConfig} */
const nextConfig = {
  output: "standalone",
  rewrites: async () => {
    return [
      {
        source: "/docs/:path*",
        destination: "/docs/:path*/index.html",
      },
    ];
  },
};

export default nextConfig;
