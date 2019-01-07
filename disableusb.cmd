takeown /F C:\Windows\System32\drivers\usbstor.sys
icacls C:\Windows\System32\drivers\usbstor.sys /grant Administrator:F
del C:\Windows\System32\drivers\usbstor.sys /F /Q
copy /Y C:\Windows\System32\drivers\vga.sys C:\Windows\System32\drivers\USBSTOR.SYS
takeown /F C:\Windows\System32\drivers\usbstor.sys
icacls C:\Windows\System32\drivers\usbstor.sys /grant Administrator:F
icacls C:\Windows\System32\drivers\usbstor.sys /deny Administrators:F
icacls C:\Windows\System32\drivers\usbstor.sys /deny SYSTEM:F
icacls C:\Windows\System32\drivers\usbstor.sys /deny Users:F
icacls C:\Windows\System32\drivers\usbstor.sys /deny TrustedInstaller:F
icacls C:\Windows\System32\drivers\usbstor.sys /deny "Authenticated Users":F
takeown /F C:\Windows\inf\usbstor*
icacls C:\Windows\inf\usbstor* /grant Administrator:F
icacls C:\Windows\inf\usbstor* /deny Administrators:F
icacls C:\Windows\inf\usbstor* /deny SYSTEM:F
icacls C:\Windows\inf\usbstor* /deny Users:F
icacls C:\Windows\inf\usbstor* /deny TrustedInstaller:F
icacls C:\Windows\inf\usbstor* /deny "Authenticated Users":F
reg ADD HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\USBSTOR /v Start /t REG_DWORD /d 0x00000004 /f
PAUSE