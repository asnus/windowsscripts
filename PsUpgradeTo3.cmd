pushd %~dp0
start /wait powershell.exe -ExecutionPolicy Unrestricted -File PsUpgradeTo3.ps1
popd
PAUSE