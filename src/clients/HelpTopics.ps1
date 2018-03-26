########################################################
##
## Topics.ps1
## Client facade to content management Pip.Services
## Topics commands
##
#######################################################


function Get-PipHelpTopics
{
<#
.SYNOPSIS

Gets page with help topics by specified criteria

.DESCRIPTION

Gets a page with help topics that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/topics)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-PipHelpTopics -Filter @{ app="MyApp" } -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/topics",
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


function Get-PipHelpTopic
{
<#
.SYNOPSIS

Gets help topic by id

.DESCRIPTION

Gets help topic by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/topics/{0})

.PARAMETER Id

A topic id

.EXAMPLE

# Gets help topic with id 1232
Get-PipHelpTopic -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/topics/{0}",
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



function New-PipHelpTopic
{
<#
.SYNOPSIS

Creates a new help topic

.DESCRIPTION

Creates a new help topic

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Post')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/topics)

.PARAMETER Topic

A topic with the following structure:
- id: string
- parent_id: string
- app: string
- title: MultiString
- popular: boolean
- custom_hdr: any
- custom_dat: any

.EXAMPLE

New-PipHelpTopic -Topic @{ parent_id="1"; app="MyApp"; title=@{ en="Application Help" } }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Post",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/topics",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Topic
    )
    begin {}
    process 
    {
        $route = $Uri

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Request $Topic
        
        Write-Output $result
    }
    end {}
}


function Update-PipHelpTopic
{
<#
.SYNOPSIS

Updates a help topic

.DESCRIPTION

Updates a help topic by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Put')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/topics/{0})

.PARAMETER Topic

A topic with the following structure:
- id: string
- parent_id: string
- app: string
- title: MultiString
- popular: boolean
- custom_hdr: any
- custom_dat: any


.EXAMPLE

Update-PipHelpTopic -Topic @{ id="123"; parent_id="1"; app="MyApp"; title=@{ en="Application Help" } }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Put",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/topics/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Topic
    )
    begin {}
    process 
    {
        $route = $Uri -f $Topic.id

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Request $Topic
        
        Write-Output $result
    }
    end {}
}


function Remove-PipHelpTopic
{
<#
.SYNOPSIS

Removes help topic by id

.DESCRIPTION

Removes help topic by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/topics/{0})

.PARAMETER Id

A topic id

.EXAMPLE

Remove-PipHelpTopic -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Delete",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/topics/{0}",
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