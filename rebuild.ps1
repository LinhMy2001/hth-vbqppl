# Rebuild HTH_VBQPPL.html (+ optional docs/index.html) from _extracted_template.html
# Usage:
#   .\rebuild.ps1
#   .\rebuild.ps1 -Pages   # also copy to docs/index.html for GitHub Pages

param(
  [switch]$Pages
)

$ErrorActionPreference = 'Stop'
$dir = $PSScriptRoot
$extract = Join-Path $dir '_extracted_template.html'
$target = Join-Path $dir 'HTH_VBQPPL.html'
$pages = Join-Path $dir 'docs\index.html'

if (-not (Test-Path $extract)) { throw "Missing $extract" }
if (-not (Test-Path $target)) { throw "Missing $target" }

$utf8 = New-Object System.Text.UTF8Encoding $false
$tpl = [System.IO.File]::ReadAllText($extract, $utf8)

Add-Type -AssemblyName System.Web.Extensions
$ser = New-Object System.Web.Script.Serialization.JavaScriptSerializer
$ser.MaxJsonLength = [int]::MaxValue
$json = $ser.Serialize($tpl)

$base = [System.IO.File]::ReadAllText($target, $utf8)
$updated = [regex]::Replace(
  $base,
  '(?s)<script type="__bundler/template">.*?</script>',
  "<script type=`"__bundler/template`">$json</script>",
  1
)

[System.IO.File]::WriteAllText($target, $updated, $utf8)
Write-Output "Rebuilt: HTH_VBQPPL.html"

if ($Pages) {
  $docsDir = Split-Path $pages -Parent
  if (-not (Test-Path $docsDir)) { New-Item -ItemType Directory -Path $docsDir | Out-Null }
  [System.IO.File]::WriteAllText($pages, $updated, $utf8)
  Write-Output "Updated: docs/index.html"
}

Write-Output "Done."
