#本配置文件用于升级powershell，以用于ansible 自动化管理。
#本配置文件仅用于windows 7 SP1 或 Windows server 2008 r2 SP1版本以上的操作系统配置。由于Windows server 2008 、 windows server 2003 已不常用，本文件未涉及。
#lzh 2018-8-8
#
#其他人如若使用本脚本，请将以下 内容替换成自己环境的具体参数
#$NetFileName.net framework 安装包文件
#$PsPachX64FileNmae 64未补丁
#$PsPachX86FileNmae 32位补丁
#$PsX64FileNmae powershell 3.0 64 升级文件
#$PsX86FileNmae powershell 3.0 32 升级文件


#获得本脚本的目录位置
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
pushd $scriptPath



#获得powershell版本决定是否升级到3
$NetFileName = "NDP451.exe"
$PsPachX64FileNmae = "Windows6.1-KB2842230-x64.msu"
$PsPachX86FileNmae = "Windows6.1-KB2842230-x86.msu"
$PsX64FileNmae = "Windows6.1-KB2506143-x64.msu"
$PsX86FileNmae = "Windows6.1-KB2506143-x86.msu"


#获得操作系统的版本
if ([Environment]::OSVersion.Version.Major -gt 6)
{
write-host "操作系统版本非常高，无需修改"
Exit
}
if ([Environment]::OSVersion.Version.Major -le 5 -or [Environment]::OSVersion.Version.Minor -eq 0  )
{
write-host "操作系统版本太低，请不要配置 ansible 自动化！"
exit
}

#获得.net framework 版本决定是否升级到4
if ($PSVersionTable.CLRVersion.Major -lt 4 )
{
Write-Host "将升级.net framework 到 4"
Start-Process  $NetFileName -Wait  -ArgumentList "/quiet","/norestart"
}

if ( $PSVersionTable.PSVersion.Major -lt 3 )
{
    if ( $env:PROCESSOR_ARCHITECTURE -eq "AMD64" )
    {
    Write-Host "将安装x64补丁"
    Start-Process  $PsX64FileNmae -Wait  -ArgumentList "/quiet","/norestart"
    Start-Process  $PsPachX64FileNmae -Wait  -ArgumentList "/quiet","/norestart"
    }
    else
    {
    Write-Host "将安装x86补丁"
   Start-Process  $PsX86FileNmae -Wait  -ArgumentList "/quiet","/norestart"
   Start-Process  $PsPachX86FileNmae -Wait  -ArgumentList "/quiet","/norestart"
    }
}

popd

