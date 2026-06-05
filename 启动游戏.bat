@echo off
set ROOT=%~dp0
set ROOT=%ROOT:~0,-1%
cd /d "%ROOT%"
start "" "http://127.0.0.1:8777"
powershell -ExecutionPolicy Bypass -File "%ROOT%\启动游戏.ps1"
pause
