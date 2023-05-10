@echo off
set SCRIPT_PATH=%~dp0
set functionsFolder=...arma3-files\src\functions - change it to the path of your functions folder downloaded from github
set soundsFolder=...arma3-files\src\sounds - change it to the path of your sounds folder downloaded from github
set descriptionFile=...arma3-files\src\description.ext - change it to the path of your description.ext downloaded from github

mklink /D "%SCRIPT_PATH%functions" "%functionsFolder%"
mklink /D "%SCRIPT_PATH%sounds" "%soundsFolder%"
COPY "%descriptionFile%" "%SCRIPT_PATH%"