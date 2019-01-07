pushd %~dp0
pushd %~dp0office2007\
start /wait setup.exe /adminfile office2007en.MSP
popd
pushd %~dp0visio2007\
start /wait setup.exe /adminfile visio2007.MSP
popd
pushd %~dp0project2007\
start /wait setup.exe /adminfile project2007.MSP
popd

start /wait %~dp0saveaspdfxps.exe /quiet
popd
PAUSE