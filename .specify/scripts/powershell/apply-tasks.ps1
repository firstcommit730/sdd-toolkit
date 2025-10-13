param(
    [Parameter(Position=0)]
    [string]$TargetDir
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($TargetDir)) {
    Write-Error "Usage: npm run spec:tasks <spec-folder>"
    exit 1
}

if (-not (Test-Path $TargetDir -PathType Container)) {
    Write-Error "Spec folder not found: $TargetDir"
    exit 1
}

if (Test-Path "$TargetDir/tasks.md") {
    Write-Error "tasks.md already exists in $TargetDir"
    exit 1
}

Copy-Item -Path ".specify/templates/tasks-template.md" -Destination "$TargetDir/tasks.md"
Write-Output "Added tasks.md to $TargetDir"
