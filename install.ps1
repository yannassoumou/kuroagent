<#
.SYNOPSIS
    Installe KuroAgent Excel Add-in via registry sideloading (HKCU).
    Charge automatiquement le manifest au demarrage d'Excel.

.DESCRIPTION
    Telecharge le manifest depuis le repo GitHub kuroagent, le sauvegarde en local,
    et cree les cles de registry pour sideloading automatique.
    Aucune interaction utilisateur requise.

.EXAMPLE
    # Installation complete (download + registry)
    .\install.ps1

    # Desinstallation (rollback)
    .\install.ps1 -Uninstall

    # URL personnalisee du manifest (mode registry uniquement)
    .\install.ps1 -ManifestUrl "https://custom-domain.com/manifest.xml"

.NOTES
    - Requires PowerShell 5.1+ (Windows)
    - Modifies HKCU only (no admin rights required)
    - Works on Excel 2016, 2019, Microsoft 365
    - Works on any PC (uses $env:USERPROFILE)
#>

param(
    [switch]$Uninstall,
    [string]$ManifestUrl,
    [switch]$DownloadFromGitHub
)

# --- Configuration -----------------------------------------------------------
$AddInName        = "KuroAgent"
$Guid             = "{14254940-5dfe-46ec-b860-a8291f526990}"
$RegPath          = "HKCU:\Software\Microsoft\Office\Excel\Addins\$Guid"
$Desc             = "KuroAgent - AI in Excel"
$GitHubRepo       = "https://raw.githubusercontent.com/yannassoumou/kuroagent/main/manifest.xml"
$LocalManifestDir = Join-Path $env:USERPROFILE "Documents\KuroAgent"
$LocalManifest    = Join-Path $LocalManifestDir "manifest.xml"

# --- Functions ---------------------------------------------------------------

function Write-Step {
    param([string]$Message)
    Write-Host "`n>>> $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "    [OK] $Message" -ForegroundColor Green
}

function Write-Warning-Custom {
    param([string]$Message)
    Write-Host "    [!!] $Message" -ForegroundColor Yellow
}

function Test-Registry {
    if (Test-Path $RegPath) {
        $existing = Get-ItemProperty -Path $RegPath -ErrorAction SilentlyContinue
        Write-Warning-Custom "KuroAgent is already installed (registry exists)."
        Write-Warning-Custom "  Run with -Uninstall first if you want to reinstall."
        return $false
    }
    return $true
}

function Download-Manifest {
    Write-Step "Downloading manifest from GitHub"

    # Create local storage directory
    if (-not (Test-Path $LocalManifestDir)) {
        New-Item -Path $LocalManifestDir -ItemType Directory -Force | Out-Null
        Write-Success "Directory created: $LocalManifestDir"
    }

    # Download manifest
    try {
        Invoke-WebRequest -Uri $GitHubRepo -OutFile $LocalManifest -ErrorAction Stop -UseBasicParsing
        Write-Success "Manifest downloaded: $LocalManifest"
    } catch {
        Write-Warning-Custom "Download failed: $_"
        Write-Warning-Custom "Use -ManifestUrl to point to a local existing file."
        return $false
    }
    return $true
}

function Install-KuroAgent {
    # Download from GitHub mode (default)
    if ($DownloadFromGitHub -or (-not $ManifestUrl)) {
        if (-not (Download-Manifest)) {
            exit 1
        }
        $ManifestUrl = "file:///$($LocalManifest -replace '\\', '/')".TrimEnd('/')
    }

    Write-Step "Creating registry key: $RegPath"

    # Main key
    New-Item -Path $RegPath -Force -ErrorAction Stop | Out-Null
    Write-Success "Main key created"

    # Key properties
    New-ItemProperty -Path $RegPath -Name "Description" -Value $Desc -PropertyType String -Force | Out-Null
    Write-Success "Description: $Desc"

    New-ItemProperty -Path $RegPath -Name "FriendlyName" -Value $AddInName -PropertyType String -Force | Out-Null
    Write-Success "FriendlyName: $AddInName"

    # LoadBehavior = 3 (load on Excel startup)
    New-ItemProperty -Path $RegPath -Name "LoadBehavior" -Value 3 -PropertyType DWord -Force | Out-Null
    Write-Success "LoadBehavior: 3 (auto-load on startup)"

    # Manifests subkey
    $manifestPath = "$RegPath\Manifests"
    New-Item -Path $manifestPath -Force -ErrorAction Stop | Out-Null
    Write-Success "Manifests subkey created"

    # Manifest path
    New-ItemProperty -Path $manifestPath -Name "Path" -Value $ManifestUrl -PropertyType String -Force | Out-Null
    Write-Success "Manifest path: $ManifestUrl"

    # AlwaysLoadCurrentVersion
    New-ItemProperty -Path $manifestPath -Name "AlwaysLoadCurrentVersion" -Value 1 -PropertyType DWord -Force | Out-Null
    Write-Success "AlwaysLoadCurrentVersion: 1"

    Write-Step "Verification"
    $verify = Get-ItemProperty -Path $RegPath -ErrorAction SilentlyContinue
    if ($verify) {
        Write-Success "Registry verified - all set"
    } else {
        Write-Warning-Custom "Cannot verify registry"
    }

    Write-Step "Installation complete!"
    Write-Host @"

    Next steps:
    1. Open Excel
    2. Click the Add-ins tab
    3. KuroAgent should appear in the list
    4. Click it to open the panel

    To update (new commit on kuroagent):
    .\install.ps1 -DownloadFromGitHub

    Note: The panel does NOT open automatically (Microsoft limitation).
"@ -ForegroundColor White
}

function Uninstall-KuroAgent {
    Write-Step "Removing registry: $RegPath"

    if (Test-Path $RegPath) {
        Remove-Item -Path $RegPath -Recurse -Force -ErrorAction Stop
        Write-Success "Registry removed"
        Write-Host "`n    KuroAgent will be uninstalled on next Excel startup." -ForegroundColor White
    } else {
        Write-Warning-Custom "No registry found for KuroAgent"
    }
}

# --- Main logic ---------------------------------------------------------------

if ($Uninstall) {
    Uninstall-KuroAgent
} else {
    if (-not (Test-Registry)) {
        exit 1
    }
    # Default: download from GitHub + registry
    Install-KuroAgent -DownloadFromGitHub
}
