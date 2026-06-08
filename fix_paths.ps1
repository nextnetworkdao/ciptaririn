$weDir = "c:\Users\Lenovo\Downloads\de\we"
$aldiDir = "$weDir\erawebs.mehnikah.com\the-wedding-of-aldi-and-fitri"
$eraDir = "$weDir\erawebs.mehnikah.com"

Copy-Item -Path "$aldiDir\*" -Destination $weDir -Recurse -Force

if (Test-Path "$eraDir\wp-includes") {
    Copy-Item -Path "$eraDir\wp-includes" -Destination $weDir -Recurse -Force
}
if (Test-Path "$eraDir\signals") {
    if (-not (Test-Path "$weDir\signals")) {
        New-Item -ItemType Directory -Path "$weDir\signals" | Out-Null
    }
    Copy-Item -Path "$eraDir\signals\*" -Destination "$weDir\signals" -Recurse -Force
}

Remove-Item -Path $eraDir -Recurse -Force

Get-ChildItem -Path $weDir -Filter "*.html" | ForEach-Object {
    $content = Get-Content -Raw -Path $_.FullName
    $newContent = $content -replace '\.\./\.\./', '' -replace '\.\./', ''
    Set-Content -Path $_.FullName -Value $newContent -NoNewline
}

Write-Output "Done organizing files and fixing paths!"
