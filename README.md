Bastion
========

Get Bastion Self-SignedCert to Local Machine.


```PoSh
Invoke-WebRequest 'https://raw.githubusercontent.com/horacio3/Bastion/master/Pull_RDPGW_SSL.ps1' -OutFile Pull_RDPGW_SSL.ps1
.\Pull_RDPGW_SSL.ps1 -BastionDNS 'ec2-52-33-137-128.us-west-2.compute.amazonaws.com'
```