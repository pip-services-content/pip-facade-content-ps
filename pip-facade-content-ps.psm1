########################################################
##
## pip-facade-content-ps.ps1
## Client facade to content management Pip.Services
## Powershell module entry
##
#######################################################

$path = $PSScriptRoot
if ($path -eq "") { $path = "." }

. "$($path)/src/clients/Files.ps1"
