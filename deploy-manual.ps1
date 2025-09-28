Write-Host "Manual GitHub Pages Deployment" -ForegroundColor Green
Write-Host "=================================" -ForegroundColor Green

# Check if we're in a git repository
if (-not (Test-Path ".git")) {
    Write-Host "Error: Not in a git repository. Please run 'git init' first." -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Step 1: Building the application..." -ForegroundColor Cyan
Set-Location frontend

# Clean previous builds
if (Test-Path "out") { Remove-Item -Recurse -Force "out" }
if (Test-Path ".next") { Remove-Item -Recurse -Force ".next" }

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Cyan
npm install
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to install dependencies" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}

# Build
Write-Host "Building for production..." -ForegroundColor Cyan
$env:NODE_ENV = "production"
npm run build
if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if build was successful
if (-not (Test-Path "out/index.html")) {
    Write-Host "Build failed: No index.html found in out directory" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Build successful!" -ForegroundColor Green

Write-Host "Step 2: Deploying to GitHub Pages..." -ForegroundColor Cyan

# Clean up lock files and install fresh
Write-Host "Cleaning lock files..." -ForegroundColor Cyan
if (Test-Path "package-lock.json") { Remove-Item "package-lock.json" }

# Install gh-pages
Write-Host "Installing gh-pages..." -ForegroundColor Cyan
npm install --save-dev gh-pages@6.1.0

# Deploy
npm run deploy
if ($LASTEXITCODE -ne 0) {
    Write-Host "Deployment failed" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Deployment successful!" -ForegroundColor Green
Write-Host "Your site should be available at: https://yourusername.github.io" -ForegroundColor Yellow
Write-Host ""
Write-Host "Note: It may take a few minutes for GitHub Pages to update." -ForegroundColor Yellow
Write-Host ""

Set-Location ..
Read-Host "Press Enter to continue"