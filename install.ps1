<#
.SYNOPSIS
    Installe KuroAgent Excel Add-in via registry sideloading (HKCU).
    Charge automatiquement le manifest au démarrage d'Excel.

.DESCRIPTION
    Télécharge le manifest depuis le repo GitHub kuroagent, le sauvegarde en local,
    et crée les clés de registry pour sideloading automatique.
    Aucune interaction utilisateur requise.

.EXAMPLE
    # Installation complète (download + registry)
    .\excel-kuroagent-registry-setup.ps1

    # Désinstallation (rollback)
    .\excel-kuroagent-registry-setup.ps1 -Uninstall

    # URL personnalisée du manifest (mode registry uniquement)
    .\excel-kuroagent-registry-setup.ps1 -ManifestUrl "https://custom-domain.com/manifest.xml"

.NOTES
    - Nécessite PowerShell 5.1+ (Windows)
    - Modifie HKCU uniquement (pas de droits admin requis)
    - Fonctionne sur Excel 2016, 2019, Microsoft 365
    - Fonctionne sur n'importe quel PC (utilise $env:USERPROFILE)
#>

param(
    [switch]$Uninstall,
    [string]$ManifestUrl,
    [switch]$DownloadFromGitHub
)

# ─── Configuration ───────────────────────────────────────────────────────────
$AddInName        = "KuroAgent"
$Guid             = "{14254940-5dfe-46ec-b860-a8291f526990}"
$RegPath          = "HKCU:\Software\Microsoft\Office\Excel\Addins\$Guid"
$Desc             = "KuroAgent — AI in Excel"
$GitHubRepo       = "https://raw.githubusercontent.com/yannassoumou/kuroagent/main/manifest.xml"
$LocalManifestDir = Join-Path $env:USERPROFILE "Documents\KuroAgent"
$LocalManifest    = Join-Path $LocalManifestDir "manifest.xml"

# ─── Fonctions ────────────────────────────────────────────────────────────────

function Write-Step {
    param([string]$Message)
    Write-Host "`n>>> $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "    ✅ $Message" -ForegroundColor Green
}

function Write-Warning-Custom {
    param([string]$Message)
    Write-Host "    ⚠️  $Message" -ForegroundColor Yellow
}

function Test-Registry {
    if (Test-Path $RegPath) {
        $existing = Get-ItemProperty -Path $RegPath -ErrorAction SilentlyContinue
        Write-Warning-Custom "KuroAgent est déjà installé (registry existe)."
        Write-Warning-Custom "  Run avec -Uninstall d'abord si tu veux réinstaller."
        return $false
    }
    return $true
}

function Download-Manifest {
    Write-Step "Téléchargement du manifest depuis GitHub"

    # Créer le dossier de stockage local
    if (-not (Test-Path $LocalManifestDir)) {
        New-Item -Path $LocalManifestDir -ItemType Directory -Force | Out-Null
        Write-Success "Dossier créé : $LocalManifestDir"
    }

    # Télécharger le manifest
    try {
        Invoke-WebRequest -Uri $GitHubRepo -OutFile $LocalManifest -ErrorAction Stop
        Write-Success "Manifest téléchargé : $LocalManifest"
    } catch {
        Write-Warning-Custom "Échec du téléchargement : $_"
        Write-Warning-Custom "Utilise -ManifestUrl pour pointer vers un fichier local existant."
        return $false
    }
    return $true
}

function Install-KuroAgent {
    # Mode download from GitHub (par défaut)
    if ($DownloadFromGitHub -or (-not $ManifestUrl)) {
        if (-not (Download-Manifest)) {
            exit 1
        }
        $ManifestUrl = "file:///$($LocalManifest -replace '\\', '/')/"
    }

    Write-Step "Création de la clé registry : $RegPath"

    # Clé principale
    New-Item -Path $RegPath -Force -ErrorAction Stop | Out-Null
    Write-Success "Clé principale créée"

    # Propriétés de la clé
    New-ItemProperty -Path $RegPath -Name "Description" -Value $Desc -PropertyType String -Force | Out-Null
    Write-Success "Description : $Desc"

    New-ItemProperty -Path $RegPath -Name "FriendlyName" -Value $AddInName -PropertyType String -Force | Out-Null
    Write-Success "FriendlyName : $AddInName"

    # LoadBehavior = 3 (charge au démarrage d'Excel)
    New-ItemProperty -Path $RegPath -Name "LoadBehavior" -Value 3 -PropertyType DWord -Force | Out-Null
    Write-Success "LoadBehavior : 3 (auto-load au démarrage)"

    # Sous-clé Manifests
    $manifestPath = "$RegPath\Manifests"
    New-Item -Path $manifestPath -Force -ErrorAction Stop | Out-Null
    Write-Success "Sous-clé Manifests créée"

    # URL du manifest
    New-ItemProperty -Path $manifestPath -Name "Path" -Value $ManifestUrl -PropertyType String -Force | Out-Null
    Write-Success "Manifest path : $ManifestUrl"

    # AlwaysLoadCurrentVersion
    New-ItemProperty -Path $manifestPath -Name "AlwaysLoadCurrentVersion" -Value 1 -PropertyType DWord -Force | Out-Null
    Write-Success "AlwaysLoadCurrentVersion : 1"

    Write-Step "Vérification"
    $verify = Get-ItemProperty -Path $RegPath -ErrorAction SilentlyContinue
    if ($verify) {
        Write-Success "Registry vérifié — tout est en place"
    } else {
        Write-Warning-Custom "Impossible de vérifier la registry"
    }

    Write-Step "Installation terminée !"
    Write-Host @"

    Prochaine étapes :
    1. Ouvre Excel
    2. Clique sur l'onglet Compléments
    3. KuroAgent devrait apparaître dans la liste
    4. Clique dessus pour ouvrir le panneau

    Pour mettre à jour (nouveau commit sur kuroagent) :
    .\excel-kuroagent-registry-setup.ps1 -DownloadFromGitHub

    Note : Le panneau ne s'ouvre PAS automatiquement (limitation Microsoft).
"@ -ForegroundColor White
}

function Uninstall-KuroAgent {
    Write-Step "Suppression de la registry : $RegPath"

    if (Test-Path $RegPath) {
        Remove-Item -Path $RegPath -Recurse -Force -ErrorAction Stop
        Write-Success "Registry supprimé"
        Write-Host "`n    KuroAgent sera désinstallé au prochain démarrage d'Excel." -ForegroundColor White
    } else {
        Write-Warning-Custom "Aucune registry trouvée pour KuroAgent"
    }
}

# ─── Logique principale ───────────────────────────────────────────────────────

if ($Uninstall) {
    Uninstall-KuroAgent
} else {
    if (-not (Test-Registry)) {
        exit 1
    }
    # Par défaut, on télécharge depuis GitHub + registry
    Install-KuroAgent -DownloadFromGitHub
}
