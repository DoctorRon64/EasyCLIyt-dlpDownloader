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
