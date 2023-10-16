@echo off
setlocal enabledelayedexpansion
mode con: cols=100 lines=7
goto start

:start
cls
set /p mp34=Do you want to download an MP3 or MP4? (Enter 3, 4): 
if "%mp34%"=="3" goto mp3
if "%mp34%"=="4" goto mp4
if /i "%mp34%"=="mp3" goto mp3
if /i "%mp34%"=="mp4" goto mp4
if /i "%mp34%"=="MP3" goto mp3
if /i "%mp34%"=="MP4" goto mp4

:mp4
set /p "input=Paste Downloadable URL for MP4: "
call "%cd%\yt-dlp.exe" -f mp4 "%input%"
echo done downloading mp4
echo.
goto exit

:mp3
set /p input=Paste Downloadable URL for MP3: 
call "%cd%\yt-dlp.exe" -x --audio-format mp3 --audio-quality 0 "%input%"
echo done downloading mp3
echo.
goto exit

:exit
pause
goto start

timeout /t 5 >nul
exit