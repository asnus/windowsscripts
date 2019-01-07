pushd %~dp0
pushd %~dp0office2007\
start /wait setup.exe /adminfile office2007en.MSP
popd
start /wait %~dp0saveaspdfxps.exe /quiet
popd
PAUSE