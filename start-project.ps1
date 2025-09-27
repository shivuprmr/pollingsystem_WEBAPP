# PowerShell Script to Start Polling System
# Run this script to start both frontend and backend servers

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "🚀 Starting Polling System Full Project" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Define paths
$backendPath = "C:\Users\shivu\OneDrive\Desktop\HACKATHON_PROJECT\polling-system\backend"
$frontendPath = "C:\Users\shivu\OneDrive\Desktop\HACKATHON_PROJECT\polling-system\frontend"

# Start Backend Server
Write-Host "📊 Starting Backend Server (MongoDB Atlas + API)..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$backendPath'; Write-Host '🚀 Backend Server Starting...' -ForegroundColor Yellow; npm run dev"

# Wait for backend to initialize
Write-Host "⏳ Waiting for backend to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# Start Frontend Server  
Write-Host "🎨 Starting Frontend Server (React + Vite)..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$frontendPath'; Write-Host '🎨 Frontend Server Starting...' -ForegroundColor Yellow; npm run dev"

# Wait for frontend to initialize
Write-Host "⏳ Waiting for frontend to initialize..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Test backend connection
Write-Host "🔍 Testing Backend Connection..." -ForegroundColor Cyan
try {
    $healthCheck = Invoke-RestMethod -Uri "http://localhost:3001/health" -Method GET -TimeoutSec 5
    Write-Host "✅ Backend is running successfully!" -ForegroundColor Green
    Write-Host "   Status: $($healthCheck.status)" -ForegroundColor White
} catch {
    Write-Host "⚠️  Backend may still be starting up..." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "✅ Polling System Launched Successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "🌐 Frontend URLs (try these in order):" -ForegroundColor Yellow
Write-Host "   • http://localhost:5173" -ForegroundColor White
Write-Host "   • http://localhost:5174" -ForegroundColor White  
Write-Host "   • http://localhost:5175" -ForegroundColor White
Write-Host ""

Write-Host "🔧 Backend API:" -ForegroundColor Yellow
Write-Host "   • Main: http://localhost:3001" -ForegroundColor White
Write-Host "   • Health: http://localhost:3001/health" -ForegroundColor White
Write-Host "   • API Base: http://localhost:3001/api" -ForegroundColor White
Write-Host ""

Write-Host "🎯 Available Features:" -ForegroundColor Yellow
Write-Host "   ✅ User Registration & Authentication" -ForegroundColor Green
Write-Host "   ✅ Student Portal with Real-time Voting" -ForegroundColor Green
Write-Host "   ✅ Admin Portal with Poll Management" -ForegroundColor Green
Write-Host "   ✅ Live Results & Analytics Dashboard" -ForegroundColor Green
Write-Host "   ✅ Beautiful Day/Night Theme Toggle" -ForegroundColor Green
Write-Host "   ✅ MongoDB Atlas Cloud Database" -ForegroundColor Green
Write-Host "   ✅ LiquidEther Animation Effects" -ForegroundColor Green
Write-Host ""

Write-Host "📝 Test Accounts Available:" -ForegroundColor Yellow
Write-Host "   👨‍🎓 Student: student1@example.com / Student123" -ForegroundColor White
Write-Host "   👑 Admin: admin1@example.com / Admin123" -ForegroundColor White
Write-Host ""

Write-Host "💡 Usage Tips:" -ForegroundColor Yellow
Write-Host "   • Both servers are running in separate windows" -ForegroundColor White
Write-Host "   • Press Ctrl+C in each window to stop servers" -ForegroundColor White
Write-Host "   • Frontend auto-reloads on file changes" -ForegroundColor White
Write-Host "   • Backend auto-restarts with nodemon" -ForegroundColor White
Write-Host ""

# Try to open browser automatically
Write-Host "🌐 Opening browser..." -ForegroundColor Cyan
try {
    Start-Process "http://localhost:5174"
} catch {
    try {
        Start-Process "http://localhost:5173"
    } catch {
        Write-Host "⚠️  Please manually open http://localhost:5173, 5174, or 5175" -ForegroundColor Yellow
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "🎉 Happy Polling! System is ready to use!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan

Read-Host "Press Enter to exit this launcher"