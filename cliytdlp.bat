@echo off
title Media Download and Playback Tool
setlocal enabledelayedexpansion

:menu
cls
echo ===============================
echo Media Download and Playback Tool
echo ===============================
echo 1. Quick Download a Single File
echo 2. Add URLs to File and Download Them
echo 3. View Files in Folder and Play a File
echo 4. Show ffplay Keyboard Shortcuts
echo 5. Exit
echo ===============================
set /p choice=Choose an option (1-5): 

if "%choice%"=="1" goto quick_download
if "%choice%"=="2" goto add_urls_and_download
if "%choice%"=="3" goto view_files_and_play
if "%choice%"=="4" goto help_menu
if "%choice%"=="5" exit
goto menu

:quick_download
cls
set /p input=Enter the file format and URL ([Format]-[URL], default format is mp4): 

:: Check if the input contains a dash ("-")
echo %input% | find "-" >nul
if errorlevel 1 (
    :: No dash found, treat input as a URL and default format to mp4
    set format=mp4
    set url=%input%
) else (
    :: Dash found, parse format and URL
    for /f "tokens=1* delims=-" %%a in ("%input%") do (
        set format=%%a
        set url=%%b
    )
)

:: Validate if URL is provided
if "%url%"=="" (
    echo Error: No URL provided.
    pause
    goto menu
)

:: Perform the download based on the format
echo Downloading from %url% in format %format%...
if /i "%format%"=="mp4" (
    yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 "%url%"
) else (
    yt-dlp -x --audio-format %format% --audio-quality 0 "%url%"
)

echo Download complete.
pause
goto menu

:add_urls_and_download
cls
echo ===============================
echo Add URLs to the file (urls.txt).
echo Enter one URL per line in the format [Format]-[URL].
echo Use default format (mp4) by entering URL without format.
echo Press Ctrl+Z and Enter when done.
echo ===============================
set download_list=urls.txt
echo. > %download_list%
more >> %download_list%

cls
echo ===============================
echo Starting batch download from urls.txt...
echo ===============================

for /f "usebackq delims=" %%u in ("%download_list%") do (
    call :download_file "%%u"
)

echo ===============================
echo All downloads completed.
pause
goto menu

:download_file
set "input=%~1"

:: Check if the input contains a dash ("-")
echo %input% | find "-" >nul
if errorlevel 1 (
    :: No dash found, treat input as a URL and default format to mp4
    set format=mp4
    set url=%input%
) else (
    :: Dash found, parse format and URL
    for /f "tokens=1* delims=-" %%a in ("%input%") do (
        set format=%%a
        set url=%%b
    )
)

:: Validate if URL is provided
if "%url%"=="" (
    echo Error: No URL provided in input "%input%".
    goto :eof
)

:: Perform the download based on the format
if /i "%format%"=="mp4" (
    echo Downloading MP4 from %url%...
    yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 "%url%"
) else (
    echo Downloading %format% from %url%...
    yt-dlp -x --audio-format %format% --audio-quality 0 "%url%"
)
goto :eof

:view_files_and_play
cls
echo ==========================
echo Files in the current folder:
echo ==========================
dir /b | findstr /i /r "\.mp4$ \.mp3$"
echo ==========================
set /p filename=Enter the filename to play: 

:: Remove extra quotes from the input, if any
set "filename=%filename:"=%"

if /i "%filename%" == "e" (
    goto menu
)
:: Check if the file exists (quote the filename to handle spaces and special characters)
if not exist "%filename%" (
    echo Error: File "%filename%" not found.
    pause
    goto view_files_and_play
)

:: Play the file with ffplay (quote the filename to handle spaces and special characters)
ffplay "%filename%"
goto view_files_and_play


:help_menu
cls
echo ==========================
echo ffplay Keyboard Shortcuts
echo ==========================
echo Space or P: Pause or resume playback
echo S: Stop playback
echo Q or ESC: Exit ffplay
echo Left Arrow or Right Arrow: Seek backward or forward
echo Up Arrow or Down Arrow: Seek forward or backward
echo Shift + Left Arrow or Shift + Right Arrow: Seek backward or forward in smaller steps
echo Page Up or Page Down: Seek to the previous or next chapter
echo M: Mute or unmute audio
echo Up Arrow or Down Arrow with Ctrl pressed: Increase or decrease volume
echo + and -: Increase and decrease volume
echo F: Toggle fullscreen mode
echo I: Show media file information
echo V: Cycle through available video tracks
echo A: Cycle through available audio tracks
echo X: Toggle subtitle display
echo W: Cycle through available subtitle tracks
echo S: Take a snapshot of the current frame
echo [ and ]: Decrease and increase playback speed
echo R: Reset playback speed to normal
echo C: Previous chapter
echo N: Next chapter
echo H: Display keyboard shortcuts (Help)
echo ==========================
pause
goto menu
