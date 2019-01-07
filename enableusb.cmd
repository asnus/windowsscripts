pushd %~dp0
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\USBSTOR /v Start /t REG_DWORD /d 0x00000003 /f
takeown /F C:\Windows\inf\usbstor*

icacls C:\Windows\inf\usbstor.inf /grant Administrator:F
icacls C:\Windows\inf\usbstor.inf /grant Administrators:F
icacls C:\Windows\inf\usbstor.inf /grant SYSTEM:F
icacls C:\Windows\inf\usbstor.inf /grant Users:F
icacls C:\Windows\inf\usbstor.inf /grant TrustedInstaller:F
icacls C:\Windows\inf\usbstor.inf /grant "Authenticated Users":F


icacls C:\Windows\inf\usbstor.PNF /grant Administrator:F
icacls C:\Windows\inf\usbstor.PNF /grant Administrators:F
icacls C:\Windows\inf\usbstor.PNF /grant SYSTEM:F
icacls C:\Windows\inf\usbstor.PNF /grant Users:F
icacls C:\Windows\inf\usbstor.PNF /grant TrustedInstaller:F
icacls C:\Windows\inf\usbstor.PNF /grant "Authenticated Users":F

del C:\Windows\inf\usbstor.inf /F /Q
del C:\Windows\inf\usbstor.PNF /F /Q

pushd %~dp0safe\%PROCESSOR_ARCHITECTURE%\inf
xcopy /C /G /H /R /Y /Z usbstor.inf C:\Windows\inf\usbstor.inf
xcopy /C /G /H /R /Y /Z usbstor.PNF C:\Windows\inf\usbstor.PNF
popd
takeown /F C:\Windows\System32\drivers\usbstor.sys

icacls C:\Windows\System32\drivers\usbstor.sys /grant Administrator:F
icacls C:\Windows\System32\drivers\usbstor.sys /grant Administrators:F
icacls C:\Windows\System32\drivers\usbstor.sys /grant SYSTEM:F
icacls C:\Windows\System32\drivers\usbstor.sys /grant Users:F
icacls C:\Windows\System32\drivers\usbstor.sys /grant TrustedInstaller:F
icacls C:\Windows\System32\drivers\usbstor.sys /grant "Authenticated Users":F

del C:\Windows\System32\drivers\usbstor.sys /F /Q

pushd %~dp0safe\%PROCESSOR_ARCHITECTURE%
xcopy /C /G /H /R /Y /Z USBSTOR.SYS C:\Windows\System32\drivers\usbstor.sys
popd

popd
PAUSE