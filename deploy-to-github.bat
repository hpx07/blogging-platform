@echo off
echo 🚀 Deploying Blog-X to GitHub Pages
echo ===================================

echo 📦 Installing dependencies...
cd frontend
call npm install

echo 🔧 Installing gh-pages...
call npm install --save-dev gh-pages

echo 🏗️  Building for production...
set NODE_ENV=production
call npm run build

echo 📤 Deploying to GitHub Pages...
call npm run deploy

echo ✅ Deployment complete!
echo 🌐 Your site will be available at: https://yourusername.github.io/blog-x
echo.
echo 📝 Note: Replace 'yourusername' with your actual GitHub username
echo.

cd ..
pause