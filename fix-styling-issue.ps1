Write-Host "Fixing Blog-X Styling Issues for GitHub Pages" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green

Write-Host "Step 1: Testing local build..." -ForegroundColor Cyan
Set-Location frontend

# Clean and rebuild
if (Test-Path ".next") { Remove-Item -Recurse -Force ".next" }
if (Test-Path "out") { Remove-Item -Recurse -Force "out" }

# Install dependencies
npm install

# Build and check
$env:NODE_ENV = "production"
npm run build

if (-not (Test-Path "out/index.html")) {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if CSS is properly included
$indexContent = Get-Content "out/index.html" -Raw
$hasCSSLinks = $indexContent -match '_next.*\.css'
$hasJSLinks = $indexContent -match '_next.*\.js'

Write-Host "Build Analysis:" -ForegroundColor Yellow
Write-Host "- CSS links found: $hasCSSLinks" -ForegroundColor $(if($hasCSSLinks){"Green"}else{"Red"})
Write-Host "- JS links found: $hasJSLinks" -ForegroundColor $(if($hasJSLinks){"Green"}else{"Red"})

if ($hasCSSLinks -and $hasJSLinks) {
    Write-Host "✅ Build looks good!" -ForegroundColor Green
} else {
    Write-Host "❌ Build has issues - CSS/JS not properly linked" -ForegroundColor Red
    Write-Host "Index.html preview:" -ForegroundColor Gray
    Write-Host $indexContent.Substring(0, [Math]::Min(1000, $indexContent.Length)) -ForegroundColor Gray
}

Write-Host ""
Write-Host "Step 2: Deploying fixed version..." -ForegroundColor Cyan

# Deploy
npm run deploy

Write-Host ""
Write-Host "✅ Deployment complete!" -ForegroundColor Green
Write-Host "Check your GitHub Pages site in a few minutes." -ForegroundColor Yellow
Write-Host "If styling is still missing, try hard refresh (Ctrl+F5)" -ForegroundColor Yellow
Write-Host ""

Set-Location ..
Read-Host "Press Enter to continue"