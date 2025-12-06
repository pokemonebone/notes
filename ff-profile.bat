cd /d %~dp0%
start "" .\core\firefox.exe  -no-remote -profile "%~n0" -new-tab %1