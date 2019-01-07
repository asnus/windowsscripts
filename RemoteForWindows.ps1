#�������ļ���������windows�ͻ��ˣ�������ansible �Զ�������
#powershell�汾������ڵ���3
#lzh 2018-8-8
#
#����������ʹ�ñ��ű����뽫���� �����滻���Լ������ľ������
#ControlHostName ansible���ƶ˵ļ������


#��ñ��ű���Ŀ¼λ��
$scriptPath = split-path -parent $MyInvocation.MyCommand.Definition
pushd $scriptPath


if ( $PSVersionTable.PSVersion.Major -lt 3 )
{
Write-Host "��������powershell��"
exit
}


#���������������
$ControlHostName = "bls.ytjszx.com"



#����winrm����Ȩ�ޣ���ʹ���������ܹ���½Windowsϵͳ���й���
#������kerberosЭ�飬�ر�basicЭ��
#����������ǽ
#

#����Զ�����ӷ���
Function Enable-PSRemoteConnect
{

    If (!(Get-Service "WinRM"))
    {
     Write-Host "Unable to find the WinRM service."
     exit 
     }
     ElseIf ((Get-Service "WinRM").Status -ne "Running")
    {
        Write-Host "Setting WinRM service to start automatically on boot."
        Set-Service -Name "WinRM" -StartupType Automatic
        Start-Service -Name "WinRM" -ErrorAction Stop
        Write-Host "Started WinRM service."

    }

    # WinRM should be running; check that we have a PS session config.
    If (!(Get-PSSessionConfiguration ) -or (!(Get-ChildItem WSMan:\localhost\Listener)))
    {
     Write-Host "Enabling PS Remoting without checking Network profile."
     Enable-PSRemoting -SkipNetworkProfileCheck -Force -ErrorAction Stop
     Write-Host "Enabled PS Remoting without checking Network profile."
     
    }
    Else
    {
        Write-Host "PS Remoting is already enabled."
    }
}
#��������ǽ
Function Enable-GlobalHttpFirewallAccess
{
    $fw = New-Object -ComObject HNetCfg.FWPolicy2

    # try to find/enable the default rule first
    $add_rule = $false
    $matching_rules = $fw.Rules | ? { $_.Name -eq "Windows Remote Management (HTTP-In)" }
    $rule = $null
    If ($matching_rules) {
        If ($matching_rules -isnot [Array]) {
            $rule = $matching_rules
        }
        Else {
            $rule = $matching_rules | % { $_.Profiles -band 4 }[0]

            If (-not $rule -or $rule -is [Array]) {
                Write-Host "Editing an arbitrary single HTTP firewall rule (multiple existed)"
                # oh well, just pick the first one
                $rule = $matching_rules[0]
            }
        }
    }

    If (-not $rule) {
        Write-Host "Creating a new HTTP firewall rule"
        $rule = New-Object -ComObject HNetCfg.FWRule
        $rule.Name = "Windows Remote Management (HTTP-In)"
        $rule.Description = "Inbound rule for Windows Remote Management via WS-Management. [TCP 5985]"
        $add_rule = $true
    }

    $rule.Profiles = 0x7FFFFFFF
    $rule.Protocol = 6
    $rule.LocalPorts = 5985
    $rule.RemotePorts = "*"
    $rule.LocalAddresses = "*"
    $rule.RemoteAddresses = "*"
    $rule.Enabled = $true
    $rule.Direction = 1
    $rule.Action = 1
    $rule.Grouping = "Windows Remote Management"

    If ($add_rule) {
        $fw.Rules.Add($rule)
    }

    Write-Host "HTTP firewall rule $($rule.Name) updated"
}


#����Ȩ�ޣ�����kerberos��֤���ر�basic��֤���������ε�ansible��������
Function Set-Authentication
{
    $basicAuthSetting = Get-ChildItem WSMan:\localhost\Service\Auth | Where-Object {$_.Name -eq "Basic"}
    if (($basicAuthSetting.Value) -eq $true)
    {
    Set-Item -Path "WSMan:\localhost\Service\Auth\Basic" -Value $false
    }
    $kerberosAuthSetting = Get-ChildItem WSMan:\localhost\Service\Auth | Where-Object {$_.Name -eq "Kerberos"}
    if ( ($kerberosAuthSetting.Value)  -eq $false)
    {
     Set-Item -Path "WSMan:\localhost\Service\Auth\Kerberos" -Value $true
    }

    Set-Item WSMan:\localhost\Client\TrustedHosts  $ControlHostName  -Force
     Write-Host "Ȩ���������!"
}


Enable-PSRemoteConnect
Enable-GlobalHttpFirewallAccess
Set-Authentication
Start-Sleep 60

popd
