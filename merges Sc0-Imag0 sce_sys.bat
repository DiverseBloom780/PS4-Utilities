@echo off
REM Merge Sc0 into Image0\sce_sys, then flatten Image0 into Title ID root
REM Delete only the folders themselves, not their contents

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

REM Copy all contents of Image0 into Title ID root
xcopy "%TARGET%\Image0\*" "%TARGET%\" /E /H /C /I /Y /R

REM Delete only the empty wrapper folders
rmdir "%TARGET%\Sc0"
rmdir "%TARGET%\Image0"

echo Merge complete. Only Image0 and Sc0 folders were removed — contents are preserved in "%TITLEID%".
pause
