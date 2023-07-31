@echo off

REM Get the current folder where init.bat is located
set "CURRENT_FOLDER=%~dp0"

REM Set the paths relative to the CURRENT_FOLDER
set "functionsFolder=%CURRENT_FOLDER%\functions"
set "soundsFolder=%CURRENT_FOLDER%\sounds"
set "descriptionFile=%CURRENT_FOLDER%\description.ext"
set "init.sqf=%CURRENT_FOLDER%\init.sqf"

REM Generate missionFileInit.bat
(
  echo @echo off
  echo set SCRIPT_PATH=%%~dp0
  echo set functionsFolder=%functionsFolder%
  echo set soundsFolder=%soundsFolder%
  echo set descriptionFile=%descriptionFile%
  echo.
  echo mklink /D "%%SCRIPT_PATH%%functions" "%%functionsFolder%%"
  echo mklink /D "%%SCRIPT_PATH%%sounds" "%%soundsFolder%%"
  echo COPY "%%descriptionFile%%" "%%SCRIPT_PATH%%"
) > missionFileInit.bat

echo missionFileInit.bat has been generated.
pause