pushd %~dp0
pushd %~dp0project2007\
start /wait setup.exe /adminfile project2007.MSP
popd
start /wait %~dp0saveaspdfxps.exe /quiet
popd
PAUSE