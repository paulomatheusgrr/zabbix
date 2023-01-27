<#
 
.Author: Paulo Matheus
.Date: 25/01/2023

#>

# User defined variables.

$SourceFolder = "\\sharedfolder"
$TargetFolder = "C:\zabbix"
$TargetProxyServer = "IpServer_or_IpProxyServer"
$ZabbixVersion = "6.2.6"

# Check if Zabbix Agent is installed and running, if not start the service.
If (get-service -Name "Zabbix Agent 2" -ErrorAction SilentlyContinue | Where-Object -Property Status -eq "Running")
{
    Exit
}
Elseif (get-service -Name "Zabbix Agent 2" -ErrorAction SilentlyContinue | Where-Object -Property Status -eq "Stopped") 
{
    # Starts service if it exists in a Stopped state.
    Start-Service "Zabbix Agent 2"
    Exit    
}

# Copy Zabbix Agent folder, Create new service, then start service.
msiexec /l*v zabbixlog2.txt /i $SourceFolder\zabbix_agent2-$ZabbixVersion-windows-amd64-openssl.msi /qn SERVER=$TargetproxyServer