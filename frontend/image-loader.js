export default function imageLoader({ src, width, quality }) {
  // For external images, return as-is
  if (src.startsWith('http')) {
    return src;
  }
  
  // For local images, ensure they work with static export
  return src;
}