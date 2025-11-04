@echo off
echo ========================================
echo    Story Universe Platform
echo ========================================
echo.

REM Check Node.js
echo Checking Node.js...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Node.js not found
    echo Please install Node.js from https://nodejs.org/
    pause
    exit
)
echo OK: Node.js found

REM Check Python
echo Checking Python...
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ERROR: Python not found
    echo Please install Python from https://www.python.org/
    pause
    exit
)
echo OK: Python found

echo.
echo ========================================
echo         Choose option:
echo ========================================
echo 1. Start frontend only
echo 2. Start backend only
echo 3. Start both (recommended)
echo 4. Exit
echo.
set /p choice="Enter choice (1-4): "

if "%choice%"=="1" (
    echo.
    echo Starting frontend...
    cd frontend
    echo URL: http://localhost:3000
    npm run dev
)

if "%choice%"=="2" (
    echo.
    echo Starting backend...
    cd backend

    if not exist "venv" (
        echo Creating virtual environment...
        python -m venv venv
    )

    echo Activating virtual environment...
    venv\Scripts\activate

    pip show fastapi >nul 2>&1
    if %errorlevel% neq 0 (
        echo Installing dependencies...
        pip install -r requirements.txt
    )

    echo Backend URL: http://localhost:8000
    echo API Docs: http://localhost:8000/docs
    uvicorn main:app --reload --host 0.0.0.0 --port 8000
)

if "%choice%"=="3" (
    echo.
    echo Starting both services...

    REM Start backend in new window
    start "Backend" cmd /k "cd backend && if not exist venv python -m venv venv && venv\Scripts\activate && pip show fastapi >nul 2>&1 || pip install -r requirements.txt && uvicorn main:app --reload --host 0.0.0.0 --port 8000"

    REM Wait a moment
    timeout /t 3 >nul

    REM Start frontend
    cd frontend
    echo.
    echo ========================================
    echo     Services ready!
    echo ========================================
    echo Frontend: http://localhost:3000
    echo Backend:  http://localhost:8000
    echo ========================================
    npm run dev
)

if "%choice%"=="4" exit

echo.
echo Done!
pause