pushd %~dp0
start /wait BingDict_Setup.exe /quiet /norestart
start /wait YoudaoDict.exe /S
popd
PAUSE