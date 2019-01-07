pushd %~dp0
start /wait powershell.exe -ExecutionPolicy Unrestricted -File RemoteForWindows.ps1
popd
PAUSE