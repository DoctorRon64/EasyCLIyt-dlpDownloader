# EasyCLIyt-dlpDownloader
A easy way to download youtube an other videos with [yt-dlp](https://github.com/yt-dlp/yt-dlp), [ffmpeg](https://www.gyan.dev/ffmpeg/builds/) and batch scripting trough a [command line interface](https://en.wikipedia.org/wiki/Command-line_interface). 

## Install
1. Double click or open the _'installer or updater.bat'_ file to download or update the current version of yt-dlp and ffmpeg.
2. Please remain patient while the download or update is in progress.
3. When promted _'Download Completed.'_, press any key to close the download window.

## How to Use
1. Double click or open the _'URL Youtube Downloader.bat'_ file.
2. When promted _'Do you wnat to download an MP3 or MP4?'_ type **_'3, mp3 or MP3'_** for a mp3 download. Type **_'4, mp4 or MP4'_** for a mp4 download, And press enter.
3. When promted _'Paste Downloadable URL for mp3:'_ or _'Paste Downloadable URL for mp4:'_ depending on your choice, Copy the desired link and paste it in the window by pressing **_Richt Click_** on the mouse button.
4. Press enter and kindly await the completion of the download. The window will close automaticly. If you downloaded a mp3 it will move to the Music folder. Else if you downloaded a mp4 it will move to Video.

## Code
Here is the code for both programs have fun reading.
### _Install or Update.bat_
```
@echo off
title yt-dlp and ffmpeg downloader
echo warning this can take a bit but do not close this .bat file
echo.

set "ffmpegmap=%cd%\ffmpegfolder"
set "ffmpegzip=ffmpeg.zip"
set "ffmpegexe=ffmpeg.exe"

if exist yt-dlp.exe (
	del yt-dlp.exe
)
if exist ffmpeg.exe (
	del ffmpeg.exe
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

echo Attempting to search for ffmpeg.exe file...
echo.

if exist "%ffmpegmap%\ffmpegfolder\bin\%ffmpegexe%" (
	echo trying to delete folder and copying ffmpeg.exe to current folder.
    copy "%ffmpegmap%\ffmpegfolder\bin\%ffmpegexe%" "%cd%"
    del /s /q "%ffmpegmap%\*"
    rd /s /q "%ffmpegmap%"
) else (
    echo Folder not found or ffmpeg.exe not found in the bin folder.
    echo Please check the folder and the bin subfolder.
    echo If ffmpeg.exe is not present, try reopening this batch file.
)
echo.
echo Download completed.

timeout /t 1 >nul
pause

exit
```
### _URL Youtube Downloader.bat_
```
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
```
