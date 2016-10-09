#Scirpt designed and created by Kevin Johnson
#Questions in regards to this script can be emailed to kjohnsonthecoder@outlook.com 

#The following code will accept a list of parameters into the script
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

#This will start a Try loop for basic error handling 
Try {

    #$ipaddr will grab the contents of the file path you specified providing that the path exists. 
    $ipaddr = Get-Content $FilePath -ErrorAction Stop

    #This will start a ForEach loop that will cycle through all those IP addresses in the text file
    Foreach ($IP in $ipaddr) {

        #This $request = "" clears out the request variable to prevent issues from multiple interations of the script 
        $request = ""

        #The $request variable performs the REST request taking in the other vaiables specifed above. 
        $request = Invoke-RestMethod -Method Get -Uri "https://api.threatstream.com/api/v2/intelligence/?username=$AnamoliUser&api_key=$AnamoliAPIkey&ip=$IP" -ErrorAction Stop

        #This is an embedded ForEach loop that will cycle through each API return to ensure we get everything from the API key
        Foreach ($object in $request.objects) {
            #The following will output status updates on the progress of the script
            Write-Host "Organization : " $object.org
            Write-Host "IP : " $object.ip
            if ($object.status -eq "falsepos") {Write-Host "Status : " $object.status -ForegroundColor Cyan}
            if ($object.status -eq "active") {Write-Host "Status : " $object.status -ForegroundColor Red }
            if ($object.status -eq "inactive") {Write-Host "Status : "$object.status -ForegroundColor Yellow}
            Write-Host "Confidence : " $object.confidence
            Write-Host "Threat Score : " $object.threatscore
            Write-Host "Organization : " $object.org
            Write-Host "Severity : " $object.meta.severity `n`n
            
            #This will output the results into a running csv file that you specified earlier
            $object | Export-Csv c:\temp\TS$outputFile.csv -Append -ErrorAction Stop
        }
    }

    #THis $request = "" clears our the request variable to prevent issues from multiple interations of the script 
    $request = ""

    #Tells you the user when the file is done and where the output file is located 
    Write-Host "output saved to c:\temp\TS$outputFile.csv" -BackgroundColor Black -ForegroundColor Cyan

#Final catch statement that will catch any errors that occur
} catch {Write-Host "$_.ExceptionMessage" -ForegroundColor Red }
