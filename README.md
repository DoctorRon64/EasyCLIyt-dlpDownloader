# EasyCLIyt-dlpDownloader
A easy way to download youtube an other videos with [yt-dlp](https://github.com/yt-dlp/yt-dlp), [ffmpeg](https://www.gyan.dev/ffmpeg/builds/) and batch scripting trough a [command line interface](https://en.wikipedia.org/wiki/Command-line_interface). 

## Install
1. Double click or open the _'installer or updater.bat'_ file to download or update the current version of yt-dlp and ffmpeg.
2. Please remain patient while the download or update is in progress.
3. When promted _'Download Completed.'_, press any key to close the download window.

## How to Use Downloader
1. Double click or open the _'URL DOWNLOADER.bat'_ file.
2. When promted _'Do you wnat to download an MP3 or MP4?'_ type **_'3, mp3 or MP3'_** for a mp3 download. Type **_'4, mp4 or MP4'_** for a mp4 download, And press enter.
3. When promted _'Paste Downloadable URL for mp3:'_ or _'Paste Downloadable URL for mp4:'_ depending on your choice, Copy the desired link and paste it in the window by pressing **_Richt Click_** on the mouse button.
4. Press enter and kindly await the completion of the download. The window will close automaticly. If you downloaded a mp3 it will move to the Music folder. Else if you downloaded a mp4 it will move to Video.

## How to Use the Multi Media Player
1. Double click or open the _'MULTIMEDIAPLAYER.bat'_ file.
2. When prompted the _'Multimedia Menu Tool'_ make a selection:
   - **P** for the Media Player
   - **A** for analyzing media or reading the metadata
   - **H** for help on keyboard shortcuts
   Then type the selected number on your keyboard and press **Enter**.
3. For the media player and media analyzer, when prompted, enter the path to the media file by typing or pasting the file's location, then press **Enter**.
4. For keyboard shortcuts in the ffplayer you can go to the Help menu. Here you can see all the shortcuts.
5. You're all set! The multimedia player or media analyzer will now open and play or analyze the selected media file.

## Code
Here is the code for both programs have fun reading.
### _Installer.bat_
```
@echo off
title yt-dlp and ffmpeg downloader
echo warning this can take a bit but do not close this .bat file
echo.

set "ffmpegmap=%cd%\ffmpegfolder"
set "ffmpegzip=ffmpeg.zip"
set "ffmpegexe=ffmpeg.exe"
set "ffplayexe=ffplay.exe"
set "ffprobeexe=ffprobe.exe"

if exist yt-dlp.exe (
    del yt-dlp.exe
)
if exist ffmpeg.exe (
    del ffmpeg.exe
)
if exist ffplay.exe (
    del ffplay.exe
)
if exist ffprobe.exe (
    del ffprobe.exe
)
if exist %ffmpegzip% (
    del %ffmpegzip%
)
if exist %ffmpegmap% (
    rd /s /q "%ffmpegmap%"
)

curl -L -s -o yt-dlp.exe https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.exe
curl -L -s -o ffmpeg.zip https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip

echo Downloaded yt-dlp..
echo Downloaded ffmpeg.zip..
echo.

timeout /t 5 >nul

powershell -command "Expand-Archive -Path '%ffmpegzip%' -DestinationPath '%cd%\ffmpegfolder'"
set "newName=ffmpegfolder"
for /D %%G in ("%cd%\ffmpegfolder\*") do set "extractedFolder=%%G"
powershell -command "Rename-Item -Path '%extractedFolder%' -NewName '%newName%'"

echo Unzipping zip..
echo.
del %ffmpegzip%

timeout /t 10 >nul

echo Attempting to search for ffmpeg, ffplay, and ffprobe files...
echo.

if exist "%ffmpegmap%\ffmpegfolder\bin\%ffmpegexe%" (
    echo Found ffmpeg. Copying to current folder.
    copy "%ffmpegmap%\ffmpegfolder\bin\%ffmpegexe%" "%cd%"
) else (
    echo ffmpeg.exe not found in the bin folder.
    echo Please check the folder and the bin subfolder.
    echo If ffmpeg.exe is not present, try reopening this batch file.
)

if exist "%ffmpegmap%\ffmpegfolder\bin\%ffplayexe%" (
    echo Found ffplay. Copying to current folder.
    copy "%ffmpegmap%\ffmpegfolder\bin\%ffplayexe%" "%cd%"
) else (
    echo ffplay.exe not found in the bin folder.
    echo Please check the folder and the bin subfolder.
    echo If ffplay.exe is not present, try reopening this batch file.
)

if exist "%ffmpegmap%\ffmpegfolder\bin\%ffprobeexe%" (
    echo Found ffprobe. Copying to current folder.
    copy "%ffmpegmap%\ffmpegfolder\bin\%ffprobeexe%" "%cd%"
) else (
    echo ffprobe.exe not found in the bin folder.
    echo Please check the folder and the bin subfolder.
    echo If ffprobe.exe is not present, try reopening this batch file.
)

echo.

rd /s /q "%ffmpegmap%"  REM Delete the ffmpegfolder

echo Download completed.

timeout /t 1 >nul
pause
exit

```
### _URL DOWNLOADER.bat_
```
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
```
### _MULTIMEDIAPLAYER.bat_
```
@echo off
setlocal enabledelayedexpansion

:: Check if ffplay.exe and ffprobe.exe exist in the system's PATH or in the same directory as the script
where ffplay >nul 2>&1
where ffprobe >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: ffplay.exe or ffprobe.exe not found. Make sure FFmpeg is installed and in your PATH.
    pause
    exit /b 1
)

:: Define labels
:menu
:play
:analyze
:help
:invalid_action
:quit

:: Display the main menu
cls
echo Multimedia Menu Tool
echo =====================
echo Select an action:
echo - P: Play media (ffplay)
echo - A: Analyze media (ffprobe)
echo - H: Help (display keyboard shortcuts)

:: Get the user's choice
set /p "action=Enter the action (P/A/H): "

:: Check the user's choice
if /i "%action%"=="P" goto play
if /i "%action%"=="A" goto analyze
if /i "%action%"=="H" goto help
) else (
    goto invalid_action
)

:: Handle play action
:play
:: Use ffplay to play the media file
cls
set /p "selected_file=Enter the path to the media file: "
set "selected_file=!selected_file:"=!"
if not exist "%selected_file%" (
    echo The selected file does not exist.
    pause
    exit /b 1
)
ffplay "%selected_file%"
pause
goto menu

:: Handle analyze action
:analyze
:: Use ffprobe to analyze the media file
cls
set /p "selected_file=Enter the path to the media file: "
set "selected_file=!selected_file:"=!"
if not exist "%selected_file%" (
    echo The selected file does not exist.
    pause
    exit /b 1
)
ffprobe "%selected_file%"
pause
goto menu

:: Handle help action
:help
:: Display keyboard shortcuts
cls
echo Keyboard Shortcuts for ffplay:
echo   - Space or P: Pause or resume playback
echo   - S: Stop playback
echo   - Q or ESC: Exit ffplay
echo   - Left Arrow or Right Arrow: Seek backward or forward
echo   - Up Arrow or Down Arrow: Seek forward or backward
echo   - Shift + Left Arrow or Shift + Right Arrow: Seek backward or forward in smaller steps
echo   - Page Up or Page Down: Seek to the previous or next chapter
echo   - M: Mute or unmute audio
echo   - Up Arrow or Down Arrow with Ctrl pressed: Increase or decrease volume
echo   - + and -: Increase and decrease volume
echo   - F: Toggle fullscreen mode
echo   - I: Show media file information
echo   - V: Cycle through available video tracks
echo   - A: Cycle through available audio tracks
echo   - X: Toggle subtitle display
echo   - W: Cycle through available subtitle tracks
echo   - S: Take a snapshot of the current frame
echo   - [ and ]: Decrease and increase playback speed
echo   - R: Reset playback speed to normal
echo   - C: Previous chapter
echo   - N: Next chapter
echo   - H: Display keyboard shortcuts (Help)
echo.
pause
goto menu

:: Handle invalid action
:invalid_action
echo Invalid action. Please enter P to play, A to analyze or H for help
pause
goto menu

:quit 
exit /b 0
```
