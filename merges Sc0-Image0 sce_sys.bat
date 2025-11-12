@echo off
REM Merge Sc0 contents into Image0\sce_sys, then flatten Image0 into Title ID root
REM Deletes only the wrapper folders (Image0, Sc0), not their contents

setlocal

if "%~1"=="" (
    for %%I in ("%cd%") do set "TITLEID=%%~nxI"
    set "TARGET=%cd%"
) else (
    set "TITLEID=%~1"
    set "TARGET=%~1"
)

echo Detected Title ID: %TITLEID%
echo Target folder: %TARGET%

REM Ensure sce_sys exists in Image0
if not exist "%TARGET%\Image0\sce_sys" (
    mkdir "%TARGET%\Image0\sce_sys"
)

REM Merge Sc0 contents into Image0\sce_sys
echo Merging Sc0 -> Image0\sce_sys ...
xcopy "%TARGET%\Sc0\*" "%TARGET%\Image0\sce_sys\" /E /H /C /I /Y /R >nul
echo Done.

REM Delete Sc0 folder (force delete wrapper after merge)
rmdir /S /Q "%TARGET%\Sc0"

REM Flatten Image0 into Title ID root
echo Flattening Image0 into "%TITLEID%" root ...
move "%TARGET%\Image0\*" "%TARGET%\" >nul
for /d %%D in ("%TARGET%\Image0\*") do move "%%~fD" "%TARGET%\" >nul

REM Delete Image0 folder (wrapper only)
rmdir /S /Q "%TARGET%\Image0"

echo Merge complete. All files are now directly under "%TITLEID%".
pause
