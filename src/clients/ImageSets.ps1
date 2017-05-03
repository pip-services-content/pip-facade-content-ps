########################################################
##
## ImageSets.ps1
## Client facade to content management Pip.Services
## ImageSets commands
##
#######################################################


function Get-PipImageSets
{
<#
.SYNOPSIS

Gets page with imagesets by specified criteria

.DESCRIPTION

Gets a page with imagesets that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/imagesets)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

# Read top 10 imagesets from test cluster that contain 'abc' string
PS> Get-PipImageSets -Name "test" -Filter @{ tags="goals,success" } -Take 10

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
        [string] $Uri = "/api/1.0/imagesets",
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

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Params $params

        Write-Output $result.Data
    }
    end {}
}


function Get-PipImageSet
{
<#
.SYNOPSIS

Gets imageset by id

.DESCRIPTION

Gets imageset by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/imagesets/{0})

.PARAMETER Id

A imageset id

.EXAMPLE

# Gets imageset with id 1232
PS> Get-PipImageSet -Name "test" -Id 123

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
        [string] $Uri = "/api/1.0/imagesets/{0}",
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


function New-PipImageSet
{
<#
.SYNOPSIS

Creates a new imageset

.DESCRIPTION

Creates a new imageset

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Post')

.PARAMETER Uri

An operation uri (default: /api/1.0/imagesets)

.PARAMETER ImageSet

A imageset with the following structure:
- id: string;
- title: string
- pics: AttachmentV1[]
  - id: string
  - uri: string
- tags: string[];

.EXAMPLE

# Creates a new imageset
PS> New-PipImageSet -Name "test" -ImageSet @{ title="Cats"; tags=@("cats"); pics=@(@{ id=123 }, @{ id=345 }) }

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
        [string] $Uri = "/api/1.0/imagesets",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $ImageSet
    )
    begin {}
    process 
    {
        $route = $Uri

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Request $ImageSet
        
        Write-Output $result
    }
    end {}
}


function Update-PipImageSet
{
<#
.SYNOPSIS

Creates a new imageset

.DESCRIPTION

Creates a new imageset

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Put')

.PARAMETER Uri

An operation uri (default: /api/1.0/imagesets/{0})

.PARAMETER ImageSet

A imageset with the following structure:
- id: string;
- title: string
- pics: AttachmentV1[]
  - id: string
  - uri: string
- tags: string[];

.EXAMPLE

# Update existing imageset
PS> Update-PipImageSet -Name "test" -ImageSet @{ title="Cats"; tags=@("cats"); pics=@(@{ id=123 }, @{ id=345 }) }

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
        [string] $Uri = "/api/1.0/imagesets/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $ImageSet
    )
    begin {}
    process 
    {
        $route = $Uri -f $ImageSet.id

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Request $ImageSet
        
        Write-Output $result
    }
    end {}
}


function Remove-PipImageSet
{
<#
.SYNOPSIS

Removes imageset by id

.DESCRIPTION

Removes imageset by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/1.0/imagesets/{0})

.PARAMETER Id

A imageset id

.EXAMPLE

# Delete imageset with id 1232
PS> Remove-PipImageSet -Name "test" -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Delete",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/imagesets/{0}",
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