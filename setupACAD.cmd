pushd %~dp0
pushd %~dp0ACAD2010_X64\AdminImage
start /wait setupACAD.ini /language zh-cn
popd
pushd %~dp0ACAD2010_X64\
if exist "C:\Program Files (x86)\7-Zip\7z.exe" goto YTCAD
start /wait %~dp07zip.exe /S
:YTCAD
"C:\Program Files (x86)\7-Zip\7z.exe" x YTCAD9.EXE -y -o"D:\Program Files\AutoCAD 2010\"
popd
popd
PAUSE