/** @type {import('next').NextConfig} */
const nextConfig = {
  output: 'export',
  trailingSlash: true,
  images: {
    unoptimized: true,
    domains: ['localhost', 'images.unsplash.com', 'via.placeholder.com'],
    formats: ['image/webp', 'image/avif'],
  },
  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL || 'https://your-backend-api.com/api',
  },
  // Remove basePath and assetPrefix for now to avoid routing issues
  // basePath: process.env.NODE_ENV === 'production' ? '/blog-x' : '',
  // assetPrefix: process.env.NODE_ENV === 'production' ? '/blog-x/' : '',
}

module.exports = nextConfig