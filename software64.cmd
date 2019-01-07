pushd %~dp0
start /wait %~dp0wrar.exe /S
start /wait %~dp07zip.exe /S
start /wait %~dp0sougoupinyin.exe /S
start /wait %~dp0flashplayer.exe /install
start /wait %~dp0reader.exe /sAll
start /wait %~dp0potplayer.exe /S
msiexec.exe /i "python-3.4.4.msi" /quiet /norestart
pushd %~dp0CAJ\
msiexec.exe /i "cajviewer 7.2.msi" /quiet /norestart
popd
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