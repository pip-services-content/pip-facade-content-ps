########################################################
##
## pip-facade-content-ps.ps1
## Client facade to content management Pip.Services
## Powershell module entry
##
#######################################################

$path = $PSScriptRoot
if ($path -eq "") { $path = "." }

. "$($path)/src/clients/Tags.ps1"
. "$($path)/src/clients/Files.ps1"
. "$($path)/src/clients/Quotes.ps1"
. "$($path)/src/clients/Tips.ps1"
. "$($path)/src/clients/ImageSets.ps1"
. "$($path)/src/clients/EmailTemplates.ps1"
