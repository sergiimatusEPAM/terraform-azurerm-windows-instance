$winrm_cmd = 'winrm quickconfig -q & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}'
& $winrm_cmd
New-SelfSignedCertificate -DnsName $(Invoke-RestMethod -uri http://169.254.169.254/latest/meta-data/local-hostname) -CertStoreLocation Cert:\LocalMachine\My
New-Item WSMan:\localhost\Listener -Address * -Transport HTTPS -HostName $(Invoke-RestMethod -uri http://169.254.169.254/latest/meta-data/local-hostname) -CertificateThumbPrint $(ls Cert:\LocalMachine\My).Thumbprint -Force
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Set-MpPreference -DisableRealtimeMonitoring $true
