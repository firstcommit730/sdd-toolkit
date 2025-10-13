# Load Constitution Sections
# Supports preset loading (backend, frontend, infra, core, testing) or explicit section lists

param(
    [Parameter(Position=0)]
    [string]$Input = "core"
)

$ErrorActionPreference = "Stop"

$constitutionDir = ".specify/templates/constitution"
$memoryDir = ".specify/memory"

# Function to load a section
function Load-Section {
    param([string]$Section)
    
    $file = ""
    
    if ($Section -eq "branching") {
        $file = "$memoryDir/git-workflow.md"
    } else {
        $file = "$constitutionDir/$Section.md"
    }
    
    if (Test-Path $file) {
        Write-Output ""
        Write-Output "<!-- Constitution Section: $Section -->"
        Write-Output ""
        Get-Content $file | Write-Output
        Write-Output ""
        Write-Output "---"
        Write-Output ""
    } else {
        Write-Warning "Warning: Missing section '$Section' (expected at $file)"
    }
}

# Determine which sections to load
$sections = @()

if ($Input -match ',') {
    # Explicit section list (comma-separated)
    $sections = $Input -split ','
} else {
    # Project type preset
    switch ($Input) {
        "backend" {
            $sections = @("core", "testing", "security", "observability", "architecture", "branching")
        }
        "frontend" {
            $sections = @("core", "testing", "architecture", "optional", "branching")
        }
        "infra" {
            $sections = @("core", "operations", "security", "observability", "branching")
        }
        "core" {
            $sections = @("core", "branching")
        }
        "testing" {
            $sections = @("testing", "branching")
        }
        "full" {
            $sections = @("core", "testing", "security", "observability", "architecture", "operations", "optional", "branching")
        }
        default {
            Write-Error "Error: Unknown preset '$Input'"
            Write-Error "Available presets: backend, frontend, infra, core, testing, full"
            Write-Error "Or use comma-separated section list: core,testing,security"
            exit 1
        }
    }
}

# Print header
Write-Output "# Constitutional Standards"
Write-Output ""
Write-Output "**Loading Type**: $Input"
Write-Output "**Sections**: $($sections -join ', ')"
Write-Output ""
Write-Output "---"
Write-Output ""

# Load each section
foreach ($section in $sections) {
    Load-Section -Section $section
}

# Print footer with metadata
Write-Output ""
Write-Output "<!-- End of Constitution Loading -->"
Write-Output "<!-- Loaded $($sections.Count) sections: $($sections -join ', ') -->"
