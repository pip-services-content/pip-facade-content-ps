########################################################
##
## HelpArticles.ps1
## Client facade to content management Pip.Services
## Help articles commands
##
#######################################################


function Get-PipHelpArticles
{
<#
.SYNOPSIS

Gets page with help articles by specified criteria

.DESCRIPTION

Gets a page with help articles that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/articles)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-PipHelpArticles -Filter @{ tags="goals,success" } -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/articles",
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


function Get-PipHelpArticle
{
<#
.SYNOPSIS

Gets help article by id

.DESCRIPTION

Gets help article by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/articles/{0})

.PARAMETER Id

A article id

.EXAMPLE

# Gets help article with id 1232
Get-PipHelpArticle -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/articles/{0}",
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


function Get-PipRandomHelpArticle
{
<#
.SYNOPSIS

Gets a random help article

.DESCRIPTION

Gets a random help article

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/articles/random)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Get-PipRandomHelpArticle

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Get",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/articles/random",
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


function New-PipHelpArticle
{
<#
.SYNOPSIS

Creates a new help article

.DESCRIPTION

Creates a new help article

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Post')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/articles)

.PARAMETER Article

An article with the following structure:
- id: string
- topic_id: string
- app: string
- min_ver: number
- max_ver: number
- content: HelpArticleContentV1[]
  - language: string
  - title: string
  - content: ContentBlockV1[]
    - type: string - text, checklist, pictures, documents, location, time, custom
    - text: string
    - checklist: ChecklistItemV1[]
      - text: string
      - checked: boolean
    - loc_name: string
    - loc_pos: object - GeoJSON
    - start: Date
    - end: Date
    - all_day: boolean
    - pic_ids: string[]
    - docs: DocumentV1[]
      - file_id: string
      - file_name: string
    - custom: object
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- custom_hdr: any
- custom_dat: any

.EXAMPLE

New-PipHelpArticle -Article @{ topic_id="1"; app="MyApp"; min_ver=0; max_ver=9999; content=@(@{ language="en"; title="About MyApp" }); status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Post",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/articles",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Article
    )
    begin {}
    process 
    {
        $route = $Uri

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Request $Article
        
        Write-Output $result
    }
    end {}
}


function Update-PipHelpArticle
{
<#
.SYNOPSIS

Updates a help article

.DESCRIPTION

Updates a help article by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Put')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/articles/{0})

.PARAMETER Article

An article with the following structure:
- id: string
- topic_id: string
- app: string
- min_ver: number
- max_ver: number
- content: HelpArticleContentV1[]
  - language: string
  - title: string
  - content: ContentBlockV1[]
    - type: string - text, checklist, pictures, documents, location, time, custom
    - text: string
    - checklist: ChecklistItemV1[]
      - text: string
      - checked: boolean
    - loc_name: string
    - loc_pos: object - GeoJSON
    - start: Date
    - end: Date
    - all_day: boolean
    - pic_ids: string[]
    - docs: DocumentV1[]
      - file_id: string
      - file_name: string
    - custom: object
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- custom_hdr: any
- custom_dat: any

.EXAMPLE

Update-PipHelpArticle -Article @{ id="123"; topic_id="1"; app="MyApp"; min_ver=0; max_ver=9999; content=@(@{ language="en"; title="About MyApp" }); status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Put",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/articles/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Article
    )
    begin {}
    process 
    {
        $route = $Uri -f $Article.id

        $result = Invoke-PipFacade -Connection $Connection -Method $Method -Route $route -Request $Article
        
        Write-Output $result
    }
    end {}
}


function Remove-PipHelpArticle
{
<#
.SYNOPSIS

Removes help article by id

.DESCRIPTION

Removes help article by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/1.0/help/articles/{0})

.PARAMETER Id

A article id

.EXAMPLE

Remove-PipHelpArticle -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Method = "Delete",
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Uri = "/api/1.0/help/articles/{0}",
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