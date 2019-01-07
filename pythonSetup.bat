pushd %~dp0
start /wait %~dp0python-3.6.6-amd64.exe /quiet InstallAllUsers=1 TargetDir="C:\python36"
popd