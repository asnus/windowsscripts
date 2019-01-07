pushd %~dp0
start /wait %~dp0wrar32.exe /S
start /wait %~dp07zip.exe /S
start /wait %~dp0sougoupinyin.exe /S
start /wait %~dp0flashplayer.exe /install
start /wait %~dp0reader.exe /sAll
start /wait %~dp0potplayer32.exe /S
pushd %~dp0CAJ\
msiexec.exe /i "cajviewer 7.2.msi" /quiet /norestart
popd
pushd %~dp0office2007\
start /wait setup.exe /adminfile office2007en.MSP
popd
pushd %~dp0visio2007\
start /wait setup.exe /adminfile visio2007.MSP
popd
start /wait %~dp0saveaspdfxps.exe /quiet
start /wait %~dp0chromexp.exe
start /wait %~dp0dotnetfx35.exe /q
popd
PAUSE