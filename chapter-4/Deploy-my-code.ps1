function InstallApplication()
{
	Write-Host "Installing Application  ..."
	Install-WindowsFeature -Name Web-Server 
	
}
InstallApplication
