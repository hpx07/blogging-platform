Write-Host "Building Blog-X for GitHub Pages (Fixed)" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green

Set-Location frontend

# Clean previous builds
Write-Host "Cleaning previous builds..." -ForegroundColor Cyan
if (Test-Path ".next") { Remove-Item -Recurse -Force ".next" }
if (Test-Path "out") { Remove-Item -Recurse -Force "out" }

# Install dependencies
Write-Host "Installing dependencies..." -ForegroundColor Cyan
npm install

# Build with proper environment
Write-Host "Building for production..." -ForegroundColor Cyan
$env:NODE_ENV = "production"
$env:NEXT_TELEMETRY_DISABLED = "1"
npm run build

# Check build output
if (Test-Path "out") {
    Write-Host "✅ Build directory created" -ForegroundColor Green
    
    # Check for essential files
    if (Test-Path "out/index.html") {
        Write-Host "✅ index.html found" -ForegroundColor Green
    } else {
        Write-Host "❌ index.html missing" -ForegroundColor Red
    }
    
    if (Test-Path "out/_next") {
        Write-Host "✅ _next directory found (CSS/JS assets)" -ForegroundColor Green
    } else {
        Write-Host "❌ _next directory missing (CSS/JS assets)" -ForegroundColor Red
    }
    
    # Check CSS files
    $cssFiles = Get-ChildItem -Path "out/_next" -Recurse -Filter "*.css" -ErrorAction SilentlyContinue
    if ($cssFiles.Count -gt 0) {
        Write-Host "✅ CSS files found: $($cssFiles.Count)" -ForegroundColor Green
    } else {
        Write-Host "❌ No CSS files found" -ForegroundColor Red
    }
    
    # Check JS files
    $jsFiles = Get-ChildItem -Path "out/_next" -Recurse -Filter "*.js" -ErrorAction SilentlyContinue
    if ($jsFiles.Count -gt 0) {
        Write-Host "✅ JavaScript files found: $($jsFiles.Count)" -ForegroundColor Green
    } else {
        Write-Host "❌ No JavaScript files found" -ForegroundColor Red
    }
    
    # Check index.html content
    $indexContent = Get-Content "out/index.html" -Raw
    if ($indexContent.Contains("_next") -and $indexContent.Contains("Blog-X")) {
        Write-Host "✅ index.html looks good (contains assets and content)" -ForegroundColor Green
    } else {
        Write-Host "⚠️  index.html might have issues" -ForegroundColor Yellow
        Write-Host "Content preview:" -ForegroundColor Gray
        Write-Host $indexContent.Substring(0, [Math]::Min(500, $indexContent.Length)) -ForegroundColor Gray
    }
    
} else {
    Write-Host "❌ Build failed - no output directory" -ForegroundColor Red
    Set-Location ..
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Build analysis complete!" -ForegroundColor Green
Write-Host "Ready to deploy to GitHub Pages" -ForegroundColor Yellow
Write-Host ""

Set-Location ..
Read-Host "Press Enter to continue"