@echo off
REM Merge Sc0 into Image0\sce_sys, then flatten Image0 into Title ID root

setlocal

REM Detect Title ID folder automatically if run inside, or accept argument if run outside
if "%~1"=="" (
    for %%I in ("%cd%") do set TITLEID=%%~nxI
    set TARGET=%cd%
) else (
    set TITLEID=%~1
    set TARGET=%~1
)

echo Detected Title ID: %TITLEID%
echo Target folder: %TARGET%

REM Ensure sce_sys exists in Image0
if not exist "%TARGET%\Image0\sce_sys" (
    mkdir "%TARGET%\Image0\sce_sys"
)

REM Merge Sc0 contents into Image0\sce_sys
xcopy "%TARGET%\Sc0\*" "%TARGET%\Image0\sce_sys\" /E /H /C /I /Y /R

REM Delete Sc0
rmdir /S /Q "%TARGET%\Sc0"

REM Copy all contents of Image0 into Title ID root
xcopy "%TARGET%\Image0\*" "%TARGET%\" /E /H /C /I /Y /R

REM Delete Image0
rmdir /S /Q "%TARGET%\Image0"

echo Merge complete. All game files are now directly under "%TITLEID%".
pause
