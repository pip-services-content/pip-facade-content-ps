########################################################
##
## Tags.ps1
## Client facade to content management Pip.Services
## Tags commands
##
#######################################################


function Get-PipTags
{
<#
.SYNOPSIS

Gets search tags by party id

.DESCRIPTION

Gets tags by party unique id

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/tags/{0})

.PARAMETER Id

A party unique id

.EXAMPLE

# Gets tags for party 1232
PS> Get-PipTags -Name "test" -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/tags/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = $Uri -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route
        
        Write-Output $result
    }
    end {}
}


function Set-PipTags
{
<#
.SYNOPSIS

Sets search tags for a party

.DESCRIPTION

Sets search tags for a party

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Post')

.PARAMETER Uri

An operation uri (default: /api/1.0/tags/{0})

.PARAMETER Tags

A tag with the following structure:
- id: string
- text: MultiString
- author: MultiString
- status: string - new, writing, translating, verifying, completed
- tags: string[]

.EXAMPLE

# Sets tags for party 123
PS> Set-PipTags -Name "test" -Id 123 -Tags @{ text=@{ en="Hurry slowly" }; author=@{ en="Russian proverb" }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Post",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/tags/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Tags
    )
    begin {}
    process 
    {
        $route = $Uri -f $Tags.id

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Request $Tags
        
        Write-Output $result
    }
    end {}
}


function Update-PipTags
{
<#
.SYNOPSIS

Records tags for a party

.DESCRIPTION

Adds new search tags for a party specified by id

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Put')

.PARAMETER Uri

An operation uri (default: /api/1.0/tags/{0})

.PARAMETER Id

A party unique id

.PARAMETER Tags

A list of search tags

.EXAMPLE

# Records search tags for party 123
PS> Update-PipTags -Name "test" -Party -Tags @("tag1", "tag2")

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Put",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/tags/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string[]] $Tags
    )
    begin {}
    process 
    {
        $route = $Uri -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Request $Tags
        
        Write-Output $result
    }
    end {}
}
