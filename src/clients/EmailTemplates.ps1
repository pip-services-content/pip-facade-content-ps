########################################################
##
## EmailTemplates.ps1
## Client facade to content management Pip.Services
## Email templates commands
##
#######################################################


function Get-PipEmailTemplates
{
<#
.SYNOPSIS

Gets page with email templates by specified criteria

.DESCRIPTION

Gets a page with email templates that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/email_templates)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

# Read top 10 email templates from test cluster that contain 'abc' string
PS> Get-PipEmailTemplates -Name "test" -Filter @{ name="Welcome Message" } -Take 10

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
        [string] $Uri = "/api/1.0/email_templates",
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


function Get-PipEmailTemplate
{
<#
.SYNOPSIS

Gets email template by id

.DESCRIPTION

Gets email template by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/1.0/email_templates/{0})

.PARAMETER Id

A email template id

.EXAMPLE

# Gets email_template with id 1232
PS> Get-PipEmailTemplate -Name "test" -Id 123

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
        [string] $Uri = "/api/1.0/email_templates/{0}",
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


function New-PipEmailTemplate
{
<#
.SYNOPSIS

Creates a new email template

.DESCRIPTION

Creates a new email template

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Post')

.PARAMETER Uri

An operation uri (default: /api/1.0/email_templates)

.PARAMETER EmailTemplate

A email template with the following structure:
- id: string
- name: string
- from: string
- reply_to: string
- subject: MultiString
- text: MultiString
- html: MultiString
- status: string - new, writing, translating, verifying, completed


.EXAMPLE

# Creates a new email template
PS> New-PipEmailTemplate -Name "test" -EmailTemplate @{ text=@{ en="Hurry slowly" }; author=@{ en="Russian proverb" }; status="completed" }

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
        [string] $Uri = "/api/1.0/email_templates",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $EmailTemplate
    )
    begin {}
    process 
    {
        $route = $Uri

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Request $EmailTemplate
        
        Write-Output $result
    }
    end {}
}


function Update-PipEmailTemplate
{
<#
.SYNOPSIS

Creates a new email template

.DESCRIPTION

Creates a new email template

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Put')

.PARAMETER Uri

An operation uri (default: /api/1.0/email_templates/{0})

.PARAMETER EmailTemplate

A email template with the following structure:
- id: string
- name: string
- from: string
- reply_to: string
- subject: MultiString
- text: MultiString
- html: MultiString
- status: string - new, writing, translating, verifying, completed


.EXAMPLE

# Update existing email template
PS> Update-PipEmailTemplate -Name "test" -EmailTemplate @{ text=@{ en="Hurry slowly" }; author=@{ en="Russian proverb" }; status="completed" }

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
        [string] $Uri = "/api/1.0/email_templates/{0}",
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $EmailTemplate
    )
    begin {}
    process 
    {
        $route = $Uri -f $EmailTemplate.id

        $result = Invoke-PipFacade -Connection $Connection -Name $Name -Method $Method -Route $route -Request $EmailTemplate
        
        Write-Output $result
    }
    end {}
}


function Remove-PipEmailTemplate
{
<#
.SYNOPSIS

Removes email template by id

.DESCRIPTION

Removes email template by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/1.0/email_templates/{0})

.PARAMETER Id

A email template id

.EXAMPLE

# Delete email template with id 1232
PS> Remove-PipEmailTemplate -Name "test" -Id 123

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
        [string] $Uri = "/api/1.0/email_templates/{0}",
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