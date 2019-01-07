pushd %~dp0
pushd %~dp0visio2007\
start /wait setup.exe /adminfile visio2007.MSP
popd
start /wait %~dp0saveaspdfxps.exe /quiet
popd
PAUSE