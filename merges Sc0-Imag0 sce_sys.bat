@echo off
REM Merge Sc0 into Image0\sce_sys, flatten Image0 into Title ID root
REM Works whether run inside or outside the Title ID folder

REM If run inside Title ID folder, %cd% is the Title ID folder
REM If run outside, user must pass the Title ID folder as argument

setlocal

if "%~1"=="" (
    REM No argument: assume we are inside the Title ID folder
    for %%I in ("%cd%") do set TITLEID=%%~nxI
    set TARGET=%cd%
) else (
    REM Argument provided: use that as Title ID folder
    set TITLEID=%~1
    set TARGET=%~1
)

echo Detected Title ID: %TITLEID%
echo Target folder: %TARGET%

REM Ensure sce_sys exists
if not exist "%TARGET%\Image0\sce_sys" (
    mkdir "%TARGET%\Image0\sce_sys"
)

REM Merge Sc0 into Image0\sce_sys
xcopy "%TARGET%\Sc0\*" "%TARGET%\Image0\sce_sys\" /E /H /C /I /Y /R

REM Delete Sc0
rmdir /S /Q "%TARGET%\Sc0"

REM Copy contents of Image0 into Title ID root
xcopy "%TARGET%\Image0\*" "%TARGET%\" /E /H /C /I /Y /R

REM Delete Image0
rmdir /S /Q "%TARGET%\Image0"

echo Merge complete. All files are now directly under "%TITLEID%".
pause
