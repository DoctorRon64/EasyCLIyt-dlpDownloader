@echo off
setlocal enabledelayedexpansion
mode con: cols=100 lines=7
goto start

:start
cls
set /p mp34=Do you want to download an MP3 or MP4? (Enter 3 for MP3 or 4 for MP4): 
if "%mp34%"=="3" goto mp3
if "%mp34%"=="4" goto mp4
if /i "%mp34%"=="mp3" goto mp3
if /i "%mp34%"=="mp4" goto mp4
if /i "%mp34%"=="MP3" goto mp3
if /i "%mp34%"=="MP4" goto mp4

:mp4
set /p "input=Paste Downloadable URL for MP4: "
set "destinationmp4=%cd%\Videos"
if not exist "%destinationmp4%" (
    mkdir "%destinationmp4%"
)
call "%cd%\yt-dlp.exe" -f mp4 -o "%destinationmp4%\tempvideo.mp4" "%input%"
for /f "delims=" %%a in ('call "%cd%\yt-dlp.exe" -f mp4 --get-filename "%input%"') do set "newName=%%~nxa"
ren "%destinationmp4%\tempvideo.mp4" "%newName%"

echo done downloading mp4
echo.
goto exit

:mp3
set /p input=Paste Downloadable URL for MP3: 
set "destinationmp3=%cd%\Music"
if not exist "%destinationmp3%" (
    mkdir "%destinationmp3%"
)
call "%cd%\yt-dlp.exe" -x --audio-format mp3 --audio-quality 0 -o "%destinationmp3%\tempmusic" "%input%"
for /f "delims=" %%a in ('call "%cd%\yt-dlp.exe" -x --audio-format mp3 --audio-quality 0 --get-filename "%input%"') do (
    set "filename=%%~na"
    setlocal enabledelayedexpansion
    ren "%destinationmp3%\tempmusic.mp3" "!filename!.mp3"
    endlocal
)

echo done downloading mp3
echo.
goto exit

:exit
timeout /t 5 >nul
exit
