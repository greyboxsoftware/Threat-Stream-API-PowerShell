[CmdletBinding()]
Param(
   [Parameter(Mandatory=$True)]
   [string]$AnamoliUser,
   [Parameter(Mandatory=$True)]
   [string]$AnamoliAPIkey,
   [Parameter(Mandatory=$True)]
   [string]$FilePath,
   [Parameter(Mandatory=$True)]
   [string]$OutputFile
)

Try {

$ipaddr = Get-Content $FilePath -ErrorAction Stop

Foreach ($IP in $ipaddr) {

$request = ""
$request = Invoke-RestMethod -Method Get -Uri "https://api.threatstream.com/api/v2/intelligence/?username=$AnamoliUser&api_key=$AnamoliAPIkey&ip=$IP" -ErrorAction Stop
Write-Host "Getting data for : " $IP -ForegroundColor Green
Foreach ($object in $request.objects) {
    Write-Host "Organization : " $object.org
    Write-Host "IP : " $object.ip
    if ($object.status -eq "falsepos") {Write-Host "Status : " $object.status -ForegroundColor Cyan}
    if ($object.status -eq "active") {Write-Host "Status : " $object.status -ForegroundColor Red }
    if ($object.status -eq "inactive") {Write-Host "Status : "$object.status -ForegroundColor Yellow}
    Write-Host "Confidence : " $object.confidence
    Write-Host "Threat Score : " $object.threatscore
    Write-Host "Organization : " $object.org
    Write-Host "Severity : " $object.meta.severity `n`n
    
    $object | Export-Csv c:\temp\TS$outputFile.csv -Append -ErrorAction Stop
}
    
}
$request = ""
Write-Host "output saved to c:\temp\TS$outputFile.csv" -BackgroundColor Black -ForegroundColor Cyan
} catch {Write-Host "$_.ExceptionMessage" -ForegroundColor Red }
