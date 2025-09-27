@echo off
echo ========================================
echo 🚀 Starting Polling System Full Project
echo ========================================

echo.
echo 📊 Starting Backend Server (MongoDB Atlas + API)...
start "Backend Server" powershell -NoExit -Command "cd 'C:\Users\shivu\OneDrive\Desktop\HACKATHON_PROJECT\polling-system\backend'; Write-Host '🚀 Starting Backend Server...'; npm run dev"

echo.
echo ⏳ Waiting for backend to initialize...
timeout /t 3 /nobreak > nul

echo.
echo 🎨 Starting Frontend Server (React + Vite)...
start "Frontend Server" powershell -NoExit -Command "cd 'C:\Users\shivu\OneDrive\Desktop\HACKATHON_PROJECT\polling-system\frontend'; Write-Host '🎨 Starting Frontend Server...'; npm run dev"

echo.
echo ⏳ Waiting for frontend to initialize...
timeout /t 5 /nobreak > nul

echo.
echo ========================================
echo ✅ Polling System is Starting Up!
echo ========================================
echo.
echo 🌐 Frontend URLs (check these in order):
echo    - http://localhost:5173
echo    - http://localhost:5174  
echo    - http://localhost:5175
echo.
echo 🔧 Backend API: http://localhost:3001
echo    - Health Check: http://localhost:3001/health
echo    - API Base: http://localhost:3001/api
echo.
echo 🎯 Features Available:
echo    ✅ User Registration & Login
echo    ✅ Student Portal with Voting
echo    ✅ Admin Portal with Poll Management
echo    ✅ Real-time Results & Analytics
echo    ✅ Beautiful Day/Night Theme Toggle
echo    ✅ MongoDB Atlas Database
echo.
echo 📝 Test Accounts Created:
echo    Student: student1@example.com / Student123
echo    Admin:   admin1@example.com / Admin123
echo.
echo 🔄 Both servers will open in separate windows
echo 💡 Press Ctrl+C in each window to stop servers
echo ========================================

pause