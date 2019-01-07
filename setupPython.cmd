pushd %~dp0
msiexec.exe /i "python-3.4.4.msi" /quiet /norestart
popd
PAUSE