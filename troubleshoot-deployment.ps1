Write-Host "Blog-X Deployment Troubleshooting" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Green

Write-Host "Checking deployment status..." -ForegroundColor Cyan

# Check if we're in the right directory
if (-not (Test-Path "frontend") -or -not (Test-Path ".git")) {
    Write-Host "Error: Please run this from the root project directory with git initialized" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "✅ Project structure looks good" -ForegroundColor Green

# Check Node.js version
$nodeVersion = node --version
Write-Host "Node.js version: $nodeVersion" -ForegroundColor Cyan

# Check if frontend dependencies are installed
if (Test-Path "frontend/node_modules") {
    Write-Host "✅ Frontend dependencies installed" -ForegroundColor Green
} else {
    Write-Host "❌ Frontend dependencies missing" -ForegroundColor Red
    Write-Host "Run: cd frontend && npm install" -ForegroundColor Yellow
}

# Check if build works
Write-Host "Testing build process..." -ForegroundColor Cyan
Set-Location frontend

if (Test-Path "out") { Remove-Item -Recurse -Force "out" }
if (Test-Path ".next") { Remove-Item -Recurse -Force ".next" }

$env:NODE_ENV = "production"
npm run build 2>&1 | Out-Null

if (Test-Path "out/index.html") {
    Write-Host "✅ Build process works correctly" -ForegroundColor Green
    
    # Check build output
    $indexSize = (Get-Item "out/index.html").Length
    Write-Host "Index.html size: $indexSize bytes" -ForegroundColor Cyan
    
    if ($indexSize -gt 1000) {
        Write-Host "✅ Build output looks good" -ForegroundColor Green
    } else {
        Write-Host "⚠️  Build output seems small, might be an issue" -ForegroundColor Yellow
    }
} else {
    Write-Host "❌ Build process failed" -ForegroundColor Red
    Write-Host "Check the build logs above for errors" -ForegroundColor Yellow
}

Set-Location ..

Write-Host ""
Write-Host "Recommendations:" -ForegroundColor Yellow
Write-Host "1. If build fails, check for TypeScript errors" -ForegroundColor White
Write-Host "2. Make sure all dependencies are installed" -ForegroundColor White
Write-Host "3. Try deleting node_modules and reinstalling" -ForegroundColor White
Write-Host "4. Use the simple workflow: deploy-simple.yml" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter to continue"