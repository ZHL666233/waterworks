@echo off
setlocal
set "d=%~dp0"
set "d=%d:~0,-1%"
cd /d "%d%"
start http://127.0.0.1:8777
powershell -ExecutionPolicy Bypass -File "%d%\启动游戏.ps1"
pause
