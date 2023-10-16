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
