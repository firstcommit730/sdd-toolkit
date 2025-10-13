param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

$ErrorActionPreference = "Stop"

if ($Arguments.Count -lt 1) {
    Write-Error "Usage: npm run spec:new `"Feature Name`""
    exit 1
}

$featureNameRaw = $Arguments -join " "
$featureSlug = $featureNameRaw.ToLower() -replace '[^a-z0-9]+', '-' -replace '^-|-$', ''

try {
    $rootDir = git rev-parse --show-toplevel 2>$null
} catch {
    $rootDir = "."
}

$specsDir = "$rootDir/.specify/specs"

if (-not (Test-Path $specsDir)) {
    New-Item -ItemType Directory -Path $specsDir -Force | Out-Null
}

$targetDir = "$specsDir/$featureSlug"

if (Test-Path $targetDir) {
    Write-Error "Target directory already exists: $targetDir"
    exit 1
}

New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
Copy-Item -Path ".specify/templates/spec-template.md" -Destination "$targetDir/spec.md"

# Inject feature name
(Get-Content "$targetDir/spec.md") -replace '<REPLACE WITH HUMAN-READABLE FEATURE TITLE>', $featureNameRaw | Set-Content "$targetDir/spec.md"

@"
# $featureNameRaw

This folder contains the specification artifacts for feature: $featureNameRaw

- spec.md – Functional spec
- plan.md – (to be generated) technical implementation plan
- tasks.md – (to be generated) task breakdown
"@ | Out-File -FilePath "$targetDir/README.md" -Encoding UTF8

Write-Output "Created spec folder: $targetDir"
