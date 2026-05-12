param (
    [Parameter(Mandatory=$true)]
    [string]$SqlEndpoint,

    [Parameter(Mandatory=$true)]
    [string]$Database,

    [Parameter(Mandatory=$true)]
    [string]$SqlUser,

    [Parameter(Mandatory=$true)]
    [string]$SqlPassword
)

Write-Host "Deploying Synapse SQL scripts..."

$scriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$sqlFolder = Join-Path $scriptRoot "..\sql"

$scripts = @(
    "01_create_external_data_source.sql",
    "02_create_gold_external_views.sql",
    "03_create_analytics_views.sql"
)

foreach ($script in $scripts) {
    $scriptPath = Join-Path $sqlFolder $script

    Write-Host "Running $scriptPath"

    sqlcmd `
        -S $SqlEndpoint `
        -d $Database `
        -U $SqlUser `
        -P $SqlPassword `
        -i $scriptPath

    if ($LASTEXITCODE -ne 0) {
        Write-Error "Failed to run $script"
        exit 1
    }
}

Write-Host "Synapse SQL deployment completed successfully."