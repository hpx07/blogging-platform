Write-Host "Fixing GitHub Pages Configuration" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green

Write-Host "Step 1: Building the frontend..." -ForegroundColor Cyan
Set-Location frontend

# Clean previous builds
if (Test-Path "out") { Remove-Item -Recurse -Force "out" }
if (Test-Path ".next") { Remove-Item -Recurse -Force ".next" }

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Cyan
npm install

# Build for production
Write-Host "Building for production..." -ForegroundColor Cyan
$env:NODE_ENV = "production"
npm run build

Write-Host "Step 2: Checking build output..." -ForegroundColor Cyan
if (Test-Path "out/index.html") {
    Write-Host "Build successful! index.html found in out directory" -ForegroundColor Green
} else {
    Write-Host "Build failed! No index.html found" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Step 3: Deploying to GitHub Pages..." -ForegroundColor Cyan
npm run deploy

Write-Host ""
Write-Host "Deployment complete!" -ForegroundColor Green
Write-Host "Your site should be available at: https://yourusername.github.io" -ForegroundColor Yellow
Write-Host ""
Write-Host "If you still see the README, wait a few minutes for GitHub Pages to update." -ForegroundColor Yellow
Write-Host ""

Set-Location ..
Read-Host "Press Enter to continue"