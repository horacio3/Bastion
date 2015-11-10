param( [Parameter(Mandatory=$true)][string] $BastionDNS )
$VerbosePreference = 'Continue'
$uri = "https://$BastionDNS"
do {
    $rerun = $true
    try {
        Invoke-WebRequest -Uri $uri -ErrorAction SilentlyContinue -UseBasicParsing
    }
    catch {
        Write-Verbose "Error retrieving configuration: $($_.Exception.message)"
        if($($_.Exception.message) -like '*SSL/TLS*') { $rerun = $false }
        else { Start-Sleep -Seconds 10 }
    }
}
while($rerun)
$webRequest = [Net.WebRequest]::Create($uri)
try { $webRequest.GetResponse() } catch {}
$cert = $webRequest.ServicePoint.Certificate
Write-Verbose "Adding PullServer Root Certificate to Cert:\LocalMachine\Root"
$store = Get-Item Cert:\LocalMachine\Root
$store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]'ReadWrite')
$store.Add($cert.Export([Security.Cryptography.X509Certificates.X509ContentType]::Cert))
$store.Close()
