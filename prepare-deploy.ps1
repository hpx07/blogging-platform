Write-Host "Preparing Blog-X for GitHub Pages Deployment" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

Write-Host "Step 1: Cleaning up lock files..." -ForegroundColor Cyan
Set-Location frontend

# Remove lock files that might cause conflicts
if (Test-Path "package-lock.json") {
    Remove-Item "package-lock.json"
    Write-Host "Removed package-lock.json" -ForegroundColor Yellow
}

if (Test-Path "yarn.lock") {
    Remove-Item "yarn.lock"
    Write-Host "Removed yarn.lock" -ForegroundColor Yellow
}

Write-Host "Step 2: Installing dependencies..." -ForegroundColor Cyan
npm install

Write-Host "Step 3: Installing gh-pages..." -ForegroundColor Cyan
npm install --save-dev gh-pages@6.1.0

Write-Host "Step 4: Testing build..." -ForegroundColor Cyan
$env:NODE_ENV = "production"
npm run build

if (Test-Path "out/index.html") {
    Write-Host "✅ Build successful!" -ForegroundColor Green
    
    # Check if the build output looks good
    $content = Get-Content "out/index.html" -Raw
    if ($content.Length -gt 1000 -and $content.Contains("Blog-X")) {
        Write-Host "✅ Build output looks good!" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Build output might have issues" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "Step 5: Committing changes..." -ForegroundColor Cyan
Set-Location ..

# Add and commit the updated package.json
git add frontend/package.json
git add frontend/package-lock.json -f 2>$null # Add lock file if it exists
git commit -m "Update dependencies for GitHub Pages deployment" 2>$null

Write-Host ""
Write-Host "✅ Preparation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Push changes: git push origin main" -ForegroundColor White
Write-Host "2. Or run manual deploy: .\deploy-manual.ps1" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to continue"