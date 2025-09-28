# Blog-X GitHub Pages Deployment Guide

## 🚀 Quick Setup

### **Step 1: Create GitHub Repository**

1. Go to [GitHub](https://github.com) and create a new repository
2. Name it `blog-x` (or any name you prefer)
3. Make it **public** (required for free GitHub Pages)
4. Initialize with README (optional)

### **Step 2: Upload Your Code**

```bash
# Initialize git in your project folder
git init

# Add all files
git add .

# Commit your code
git commit -m "Initial commit: Blog-X blogging platform"

# Add your GitHub repository as origin
git remote add origin https://github.com/hpx07/blogging-platform.git

# Push to GitHub
git push -u origin main
```

### **Step 3: Enable GitHub Pages**

1. Go to your repository on GitHub
2. Click **Settings** tab
3. Scroll down to **Pages** section
4. Under **Source**, select **GitHub Actions**
5. The workflow will automatically run when you push to main

### **Step 4: Troubleshoot if Needed**

If the GitHub Actions fail with deprecated version errors:

**Option A: Use Simple Workflow**
1. Delete `.github/workflows/deploy.yml`
2. Rename `.github/workflows/deploy-simple.yml` to `deploy.yml`
3. Push changes

**Option B: Manual Deployment**
```powershell
.\deploy-manual.ps1
```

**Option C: Check Issues**
```powershell
.\troubleshoot-deployment.ps1
```

Your site will be available at `https://yourusername.github.io`

### **Step 4: Update Configuration**

Edit these files with your GitHub username:

**frontend/.env.production**

```
NEXT_PUBLIC_APP_URL=https://hpx07.github.io/bloggong-platform
```

## 🔧 Manual Deployment (Alternative)

If you prefer manual deployment:

```bash
# Run the deployment script
.\deploy-to-github.ps1

# Or manually:
cd frontend
npm install
npm run build
npm run deploy
```

## 🌐 Access Your Site

After deployment, your Blog-X will be available at:
**https://yourusername.github.io**

Replace `yourusername` with your actual GitHub username.

## ⚙️ Configuration Details

### **Next.js Configuration**

- ✅ **Static Export**: Configured for GitHub Pages
- ✅ **Image Optimization**: Disabled for static hosting
- ✅ **Base Path**: Set to repository name
- ✅ **Asset Prefix**: Configured for proper loading

### **GitHub Actions Workflow**

- ✅ **Automatic Deployment**: Triggers on push to main branch
- ✅ **Node.js 18**: Latest LTS version
- ✅ **Build Optimization**: Production build with caching
- ✅ **GitHub Pages**: Automatic deployment to gh-pages branch

### **Features Working on GitHub Pages**

- ✅ **Static Site**: All pages render correctly
- ✅ **Mock Data**: Sample blog posts and content
- ✅ **Responsive Design**: Mobile and desktop layouts
- ✅ **Dark/Light Mode**: Theme switching
- ✅ **Animations**: Framer Motion effects
- ✅ **SEO**: Meta tags and OpenGraph

### **Limitations on GitHub Pages**

- ❌ **Backend API**: No server-side functionality
- ❌ **Database**: No persistent data storage
- ❌ **User Authentication**: No login/register
- ❌ **Comments**: No real-time comments
- ❌ **Newsletter**: No email functionality

## 🔄 Updating Your Site

### **Automatic Updates**

Every time you push to the `main` branch, GitHub Actions will:

1. Build your Next.js app
2. Deploy to GitHub Pages
3. Update your live site

### **Manual Updates**

```bash
# Make your changes
git add .
git commit -m "Update: your changes"
git push origin main
```

## 🎯 Custom Domain (Optional)

To use a custom domain like `blog-x.com`:

1. **Buy a domain** from any registrar
2. **Add CNAME file** in `frontend/public/CNAME`:
   ```
   blog-x.com
   ```
3. **Configure DNS** at your registrar:
   ```
   CNAME: yourusername.github.io
   ```
4. **Update GitHub Pages settings** to use custom domain

## 🛠️ Troubleshooting

### **Build Fails**

- Check Node.js version (should be 18+)
- Ensure all dependencies are installed
- Check for TypeScript errors

### **Images Not Loading**

- Verify image URLs are absolute
- Check `next.config.js` image settings
- Ensure images are in `public` folder

### **404 Errors**

- Verify `basePath` in `next.config.js`
- Check GitHub Pages source settings
- Ensure `.nojekyll` file exists

### **Styling Issues**

- Check Tailwind CSS build
- Verify CSS imports
- Check for missing dependencies

## 📋 Checklist

Before deploying:

- [ ] Repository is public
- [ ] GitHub Pages is enabled
- [ ] Environment variables updated
- [ ] Images are optimized
- [ ] Build completes successfully
- [ ] All links work correctly

## 🎉 Success!

Once deployed, you'll have a beautiful, professional Blog-X running on GitHub Pages with:

- Modern, responsive design
- Sample blog posts
- Dark/light mode toggle
- Professional layout
- SEO optimization
- Fast loading times

Perfect for showcasing your blogging platform or using as a portfolio piece!
