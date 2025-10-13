# Common functions and variables for all PowerShell scripts

function Get-RepoRoot {
    return (git rev-parse --show-toplevel)
}

function Get-CurrentBranch {
    return (git rev-parse --abbrev-ref HEAD)
}

function Test-FeatureBranch {
    param([string]$Branch)
    
    if ($Branch -eq "main" -or $Branch -eq "master") {
        Write-Error "ERROR: Not on a feature branch. Current branch: $Branch"
        Write-Error "Feature branches should be named like: feature-name"
        return $false
    }
    return $true
}

function Get-FeatureDir {
    param(
        [string]$RepoRoot,
        [string]$FeatureName
    )
    return "$RepoRoot/specs/$FeatureName"
}

# Determine which feature to use (by name or auto-detect)
# Args: $FeatureName = optional feature name
# Returns: feature name to use
# Exits with error if multiple features exist and none specified
function Get-DeterminedFeature {
    param([string]$FeatureName = "")
    
    $repoRoot = Get-RepoRoot
    $specsDir = "$repoRoot/.specify/specs"
    
    # If feature name provided, validate it exists
    if ($FeatureName) {
        if (-not (Test-Path "$specsDir/$FeatureName" -PathType Container)) {
            Write-Error "ERROR: Feature '$FeatureName' not found in $specsDir"
            Write-Error "Available features:"
            Get-ChildItem -Path $specsDir -Directory -ErrorAction SilentlyContinue | ForEach-Object {
                Write-Error "  - $($_.Name)"
            }
            throw "Feature not found"
        }
        return $FeatureName
    }
    
    # No feature name provided - check what's available
    if (-not (Test-Path $specsDir -PathType Container)) {
        Write-Error "ERROR: Specs directory not found: $specsDir"
        throw "Specs directory not found"
    }
    
    $features = Get-ChildItem -Path $specsDir -Directory -ErrorAction SilentlyContinue
    $featureCount = ($features | Measure-Object).Count
    
    if ($featureCount -eq 0) {
        Write-Error "ERROR: No features found in $specsDir"
        Write-Error "Run @specify first to create a feature specification."
        throw "No features found"
    }
    elseif ($featureCount -eq 1) {
        # Auto-select single feature
        return $features[0].Name
    }
    else {
        # Multiple features - need user to specify
        Write-Error "ERROR: Multiple specs found. Please specify which feature to use:"
        Write-Error ""
        Write-Error "Available features:"
        $features | ForEach-Object {
            Write-Error "  - $($_.Name)"
        }
        Write-Error ""
        Write-Error "Usage: @plan <feature-name>, @tasks <feature-name>, or @implement <feature-name>"
        throw "Multiple features found"
    }
}

function Get-FeaturePaths {
    param([string]$FeatureName = "")
    
    $repoRoot = Get-RepoRoot
    $currentBranch = Get-CurrentBranch
    
    # Use provided name or fallback to branch
    if (-not $FeatureName) {
        $FeatureName = $currentBranch
    }
    
    $featureDir = Get-FeatureDir -RepoRoot $repoRoot -FeatureName $FeatureName
    
    return @{
        REPO_ROOT = $repoRoot
        CURRENT_BRANCH = $currentBranch
        FEATURE_NAME = $FeatureName
        FEATURE_DIR = $featureDir
        FEATURE_SPEC = "$featureDir/spec.md"
        IMPL_PLAN = "$featureDir/plan.md"
        TASKS = "$featureDir/tasks.md"
        RESEARCH = "$featureDir/research.md"
        DATA_MODEL = "$featureDir/data-model.md"
        QUICKSTART = "$featureDir/quickstart.md"
        CONTRACTS_DIR = "$featureDir/contracts"
    }
}

function Test-FileExists {
    param(
        [string]$Path,
        [string]$Label
    )
    
    if (Test-Path $Path -PathType Leaf) {
        return "  ✓ $Label"
    } else {
        return "  ✗ $Label"
    }
}

function Test-DirExists {
    param(
        [string]$Path,
        [string]$Label
    )
    
    if ((Test-Path $Path -PathType Container) -and (Get-ChildItem $Path -ErrorAction SilentlyContinue)) {
        return "  ✓ $Label"
    } else {
        return "  ✗ $Label"
    }
}
