
$AdminUser = Get-Credential -Credential Administrator
$DomainUser = Get-Credential -Credential "ytjszx\"

Add-Computer -DomainName ytjszx.com  -Server ytjszx.com\ps16 -Credential




Restart-Computer -Force


$keyFile = "D:\aes.key"
$key = New-Object Byte[] 192
[Security.Cryptography.RNGCryptoServiceProvider]::Create().GetBytes($key)
$key | out-file $keyFile