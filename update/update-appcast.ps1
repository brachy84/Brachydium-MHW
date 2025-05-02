param (
    [string]$Version,
    [string]$Description,
    [string]$OS,
    [string]$File,
    [string]$Length,
    [string]$Type,
    [string]$TemplatePath = "update\template_update_item.xml",
    [string]$AppcastPath = "update\appcast.xml"
)

# Aktuelles Datum im RFC1123-Format
$Date = (Get-Date).ToUniversalTime().ToString("R")

# Lade Template
$template = Get-Content $TemplatePath -Raw

# Ersetze Platzhalter
$itemXml = $template `
    -replace "{{VERSION}}", $Version `
    -replace "{{DESCRIPTION}}", $Version `
    -replace "{{OS}}", $OS `
    -replace "{{FILE}}", $File `
    -replace "{{LENGTH}}", $Length `
    -replace "{{TYPE}}", $Type `
    -replace "{{DATE}}", $Date

# Lies appcast.xml
$appcast = Get-Content $AppcastPath -Raw

# Füge Item nach Marker ein
$newAppcast = $appcast -replace '(<!--ITEM_MARKER-->)', "`$1`r`n$itemXml"

# Überschreibe Datei
Set-Content $AppcastPath $newAppcast

Write-Host "✅ Update-Item für $OS Version $Version in appcast.xml eingefügt."
