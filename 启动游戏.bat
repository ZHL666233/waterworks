@echo off
title Waterworks! 汉化版
echo 正在启动本地服务器...
cd /d "%~dp0"

REM 尝试 Python
where python >nul 2>nul
if %errorlevel% equ 0 (
    start http://localhost:8777
    python -m http.server 8777
    goto :end
)

REM 尝试 Node.js
where npx >nul 2>nul
if %errorlevel% equ 0 (
    start http://localhost:8777
    npx serve . -l 8777
    goto :end
)

REM 都没装
echo.
echo 需要安装 Python 或 Node.js:
echo   Python: https://www.python.org/downloads/
echo   Node.js: https://nodejs.org/
echo.
echo 或者按任意键退出...
pause >nul

:end
