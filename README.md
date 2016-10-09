The following script will allow you to query the Threat Stream (Anamoli) API with a few easy steps

1st. You need to have a Threat Stream account. 

2nd. You need to get your API Key from your Threat Stream account by clicking the little gear icon on the top right and finding it in the middle of the screen 

3rd. Copy and paste a list of IP addresses that you wish to query through Threat Stream API into a text file. For our puposes we will name that file ipaddr.txt (c:\temp\ipaddr.txt) 

4th. Download this scirpt and save it to you c:\ drive in our case we will save it to the temp drive (c:\temp\ThreatIntel.ps1)

Currently this script only supports IP addresses. 

Now that we have all the prerequsites figured out we can then open up PowerShell as an Administrator

    To run the script all you have to do is type in 
    c:\temp\ThreatIntel.ps1
    Then follow the prompts
  
The script will ask you for your username (Threat Stream email), Threat Stream API key, file path where the IP address are (i.e. c:\temp\ipaddr.txt), and what you want your output file named i.e. ThreatIntel (file will save as c:\temp\TSThreatIntel.csv)

OR 

If you want a nice oneliner you could do the following from a PowerShell Prompt 

    c:\temp\ThreatIntel.ps1 -AnamoliUser email@something.com -AnamoliAPIkey Your-API-Key -FilePath c:\temp\ipaddr.txt -OutputFile coolName
  

 
