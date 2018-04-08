########################################################
##
## Tips.ps1
## Client facade to content management Pip.Services
## Tips commands
##
#######################################################


function Get-PipTips
{
<#
.SYNOPSIS

Gets page with tips by specified criteria

.DESCRIPTION

Gets a page with tips that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/tips)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-PipTips -Filter @{ tags="goals,success" } -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/tips",
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


function Get-PipTip
{
<#
.SYNOPSIS

Gets tip by id

.DESCRIPTION

Gets tip by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/tips/{0})

.PARAMETER Id

A tip id

.EXAMPLE

Get-PipTip -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/tips/{0}",
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


function Get-PipRandomTip
{
<#
.SYNOPSIS

Gets a random tip

.DESCRIPTION

Gets a random tip

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/tips/random)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Get-PipRandomTip

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/tips/random",
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


function New-PipTip
{
<#
.SYNOPSIS

Creates a new tip

.DESCRIPTION

Creates a new tip

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Post')

.PARAMETER Uri

An operation uri (default: /api/1.0/tips)

.PARAMETER Tip

A tip with the following structure:
- id: string
- topics: string[]
- title: MultiString
- content: MultiString
- more_url: string
- pics: AttachmentV1[]
  - id: string
  - uri: string
- docs: AttachmentV1[]
  - id: string
  - uri: string
  - name: string
- tags: string[]
- status: string
- custom_hdr: any
- custom_dat: any

.EXAMPLE

New-PipTip -Tip @{ topics=@("myapp", "useful"); title=@{ en="Do you know how to?" }; content=@{ en="Just press the button..." }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Post",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/tips",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Tip
    )
    begin {}
    process 
    {
        $route = $Uri

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Request $Tip
        
        Write-Output $result
    }
    end {}
}


function Update-PipTip
{
<#
.SYNOPSIS

Updates a tip

.DESCRIPTION

Updates a tip

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Put')

.PARAMETER Uri

An operation uri (default: /api/1.0/tips/{0})

.PARAMETER Tip

A tip with the following structure:
- id: string
- topics: string[]
- title: MultiString
- content: MultiString
- more_url: string
- pics: AttachmentV1[]
  - id: string
  - uri: string
- docs: AttachmentV1[]
  - id: string
  - uri: string
  - name: string
- tags: string[]
- status: string
- custom_hdr: any
- custom_dat: any

.EXAMPLE

Update-PipTip -Tip @{ id="123"; topics=@("myapp", "useful"); title=@{ en="Do you know how to?" }; content=@{ en="Just press the button..." }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Put",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/tips/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Tip
    )
    begin {}
    process 
    {
        $route = $Uri -f $Tip.id

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Request $Tip
        
        Write-Output $result
    }
    end {}
}


function Remove-PipTip
{
<#
.SYNOPSIS

Removes tip by id

.DESCRIPTION

Removes tip by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/1.0/tips/{0})

.PARAMETER Id

A tip id

.EXAMPLE

Remove-PipTip -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Delete",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/tips/{0}",
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