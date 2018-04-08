########################################################
##
## Guides.ps1
## Client facade to content management Pip.Services
## Guides commands
##
#######################################################


function Get-PipGuides
{
<#
.SYNOPSIS

Gets page with guides by specified criteria

.DESCRIPTION

Gets a page with guides that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/guides)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-PipGuides -Filter @{ tags="goals,success" } -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/guides",
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{},
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [int] $Skip = 0,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [int] $Take = 100,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [bool] $Total
    )
    begin {}
    process 
    {
        $route = $Uri

        $params = $Filter +
        @{ 
            skip = $Skip;
            take = $Take
            total = $Total
        }

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Params $params

        Write-Output $result.Data
    }
    end {}
}


function Get-PipGuide
{
<#
.SYNOPSIS

Gets guide by id

.DESCRIPTION

Gets guide by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/guides/{0})

.PARAMETER Id

A guide id

.EXAMPLE

# Gets guide with id 1232
Get-PipGuide -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/guides/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = $Uri -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route
        
        Write-Output $result
    }
    end {}
}


function Get-PipRandomGuide
{
<#
.SYNOPSIS

Gets a random guide

.DESCRIPTION

Gets a random guide

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/guides/random)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Get-PipRandomGuide

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/guides/random",
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{}
    )
    begin {}
    process 
    {
        $route = $Uri
        $params = $Filter

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Params $params
        
        Write-Output $result
    }
    end {}
}


function New-PipGuide
{
<#
.SYNOPSIS

Creates a new guide

.DESCRIPTION

Creates a new guide

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Post')

.PARAMETER Uri

An operation uri (default: /api/1.0/guides)

.PARAMETER Guide

A guide with the following structure:
- id: string
- type: string - "introduction", "new release"
- app: string
- version: string
- pages: GuidePageV1[]
  - title: MultiString
  - content: MultiString
  - more_url: string
  - color: string
  - pic_id: string
  - pic_uri: string
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- custom_hdr: any
- custom_dat: any

.EXAMPLE

New-PipGuide -Guide @{ type="introduction"; app="MyApp"; pages=@(@{ title=@{ en="Welcome to MyApp" } }); status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Post",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/guides",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Guide
    )
    begin {}
    process 
    {
        $route = $Uri

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Request $Guide
        
        Write-Output $result
    }
    end {}
}


function Update-PipGuide
{
<#
.SYNOPSIS

Updates a guide

.DESCRIPTION

Updates a guide by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Put')

.PARAMETER Uri

An operation uri (default: /api/1.0/guides/{0})

.PARAMETER Guide

A guide with the following structure:
- id: string
- type: string - "introduction", "new release"
- app: string
- version: string
- pages: GuidePageV1[]
  - title: MultiString
  - content: MultiString
  - more_url: string
  - color: string
  - pic_id: string
  - pic_uri: string
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- custom_hdr: any
- custom_dat: any

.EXAMPLE

Update-PipGuide -Guide @{ id="123"; type="introduction"; app="MyApp"; pages=@(@{ title=@{ en="Welcome to MyApp" } }); status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Put",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/guides/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Guide
    )
    begin {}
    process 
    {
        $route = $Uri -f $Guide.id

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Request $Guide
        
        Write-Output $result
    }
    end {}
}


function Remove-PipGuide
{
<#
.SYNOPSIS

Removes guide by id

.DESCRIPTION

Removes guide by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/1.0/guides/{0})

.PARAMETER Id

A guide id

.EXAMPLE

Remove-PipGuide -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Delete",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/guides/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = $Uri -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route
        
        Write-Output $result
    }
    end {}
}