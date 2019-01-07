#�������ļ���������powershell��������ansible �Զ�������
#�������ļ�������windows 7 SP1 �� Windows server 2008 r2 SP1�汾���ϵĲ���ϵͳ���á�����Windows server 2008 �� windows server 2003 �Ѳ����ã����ļ�δ�漰��
#lzh 2018-8-8
#
#����������ʹ�ñ��ű����뽫���� �����滻���Լ������ľ������
#$NetFileName.net framework ��װ���ļ�
#$PsPachX64FileNmae 64δ����
#$PsPachX86FileNmae 32λ����
#$PsX64FileNmae powershell 3.0 64 �����ļ�
#$PsX86FileNmae powershell 3.0 32 �����ļ�


#��ñ��ű���Ŀ¼λ��
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
pushd $scriptPath



#���powershell�汾�����Ƿ�������3
$NetFileName = "NDP451.exe"
$PsPachX64FileNmae = "Windows6.1-KB2842230-x64.msu"
$PsPachX86FileNmae = "Windows6.1-KB2842230-x86.msu"
$PsX64FileNmae = "Windows6.1-KB2506143-x64.msu"
$PsX86FileNmae = "Windows6.1-KB2506143-x86.msu"


#��ò���ϵͳ�İ汾
if ([Environment]::OSVersion.Version.Major -gt 6)
{
write-host "����ϵͳ�汾�ǳ��ߣ������޸�"
Exit
}
if ([Environment]::OSVersion.Version.Major -le 5 -or [Environment]::OSVersion.Version.Minor -eq 0  )
{
write-host "����ϵͳ�汾̫�ͣ��벻Ҫ���� ansible �Զ�����"
exit
}

#���.net framework �汾�����Ƿ�������4
if ($PSVersionTable.CLRVersion.Major -lt 4 )
{
Write-Host "������.net framework �� 4"
Start-Process  $NetFileName -Wait  -ArgumentList "/quiet","/norestart"
}

if ( $PSVersionTable.PSVersion.Major -lt 3 )
{
    if ( $env:PROCESSOR_ARCHITECTURE -eq "AMD64" )
    {
    Write-Host "����װx64����"
    Start-Process  $PsX64FileNmae -Wait  -ArgumentList "/quiet","/norestart"
    Start-Process  $PsPachX64FileNmae -Wait  -ArgumentList "/quiet","/norestart"
    }
    else
    {
    Write-Host "����װx86����"
   Start-Process  $PsX86FileNmae -Wait  -ArgumentList "/quiet","/norestart"
   Start-Process  $PsPachX86FileNmae -Wait  -ArgumentList "/quiet","/norestart"
    }
}

popd

