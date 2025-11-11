@echo off
REM Merge Sc0 contents into Image0\Sce_sys, then flatten Image0 into Title ID root
REM Deletes only the empty wrapper folders (Image0, Sc0), not their contents

setlocal

REM Detect Title ID folder automatically if run inside, or accept argument if run outside
if "%~1"=="" (
    for %%I in ("%cd%") do set "TITLEID=%%~nxI"
    set "TARGET=%cd%"
) else (
    set "TITLEID=%~1"
    set "TARGET=%~1"
)

echo Detected Title ID: %TITLEID%
echo Target folder: %TARGET%
echo.

REM Validate required folders
if not exist "%TARGET%\Image0" (
    echo ERROR: Image0 folder not found at "%TARGET%\Image0"
    goto :end
)
if not exist "%TARGET%\Sc0" (
    echo ERROR: Sc0 folder not found at "%TARGET%\Sc0"
    goto :end
)

REM Ensure Sce_sys exists (capital S as requested)
if not exist "%TARGET%\Image0\Sce_sys" (
    mkdir "%TARGET%\Image0\Sce_sys"
)

REM Merge Sc0 contents into Image0\Sce_sys (overwrite allowed)
echo Merging Sc0 -> Image0\Sce_sys ...
xcopy "%TARGET%\Sc0\*" "%TARGET%\Image0\Sce_sys\" /E /H /C /I /Y /R >nul
if errorlevel 1 (
    echo WARNING: xcopy reported an issue; verify files in Image0\Sce_sys.
)
echo Done.
echo.

REM Flatten Image0: move its contents into Title ID root (no duplication)
echo Flattening Image0 into "%TITLEID%" root ...
move "%TARGET%\Image0\*" "%TARGET%\" >nul
for /d %%D in ("%TARGET%\Image0\*") do move "%%~fD" "%TARGET%\" >nul
echo Done.
echo.

REM Delete only the wrapper folders (they should be empty now)
echo Cleaning up wrapper folders ...
rmdir "%TARGET%\Sc0" 2>nul
rmdir "%TARGET%\Image0" 2>nul
echo Cleanup complete.
echo.

echo Merge complete. All files are now directly under "%TITLEID%".
:end
pause
