﻿<#
.SYNOPSIS
Convert the given template file path into a valid Universal Artifact name

.DESCRIPTION
Convert the given template file path into a valid Universal Artifact repository name
Must be lowercase alphanumerics, dashes, dots or underscores, under 256 characters.

.PARAMETER TemplateFilePath
Mandatory. The template file path to convert

.EXAMPLE
Get-UniversalArtifactsName -TemplateFilePath 'C:\modules\Microsoft.KeyVault\vaults\deploy.bicep'

Convert 'C:\modules\Microsoft.KeyVault\vaults\deploy.bicep' to e.g. 'microsoft.keyvault.vaults'
#>
function Get-UniversalArtifactsName {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string] $TemplateFilePath
    )

    $ModuleFolderPath = Split-Path $TemplateFilePath -Parent
    $universalPackageModuleName = $ModuleFolderPath.Replace('\', '/').Split('/modules/')[1]
    $universalPackageModuleName = ($universalPackageModuleName.Replace('\', '.').Replace('/', '.').toLower() -Replace '[^a-z0-9\.\-_]')[0..255] -join ''

    return $universalPackageModuleName
}
