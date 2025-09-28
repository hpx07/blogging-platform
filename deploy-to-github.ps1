Write-Host "Deploying Blog-X to GitHub Pages" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green

Write-Host "Installing dependencies..." -ForegroundColor Cyan
Set-Location frontend
npm install

Write-Host "Installing gh-pages..." -ForegroundColor Cyan
npm install --save-dev gh-pages

Write-Host "Building for production..." -ForegroundColor Cyan
npm run build

Write-Host "Deploying to GitHub Pages..." -ForegroundColor Cyan
npm run deploy

Write-Host ""
Write-Host "Deployment complete!" -ForegroundColor Green
Write-Host "Your site will be available at: https://yourusername.github.io/blog-x" -ForegroundColor Yellow
Write-Host ""
Write-Host "Note: Replace 'yourusername' with your actual GitHub username" -ForegroundColor Yellow
Write-Host ""

Set-Location ..
Read-Host "Press Enter to continue"