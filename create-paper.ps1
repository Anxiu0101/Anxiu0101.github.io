param (
    [string]$fileName
)

# Check if a parameter is provided
if (-not $fileName) {
    Write-Host "Error: Please provide a file name as an argument. Use './create.ps1 help' for help."
    exit
}

# Check if help is requested
if ($fileName -eq "help") {
    Write-Host "Usage: ./create.ps1 <fileName>"
    Write-Host "Description: Creates a new note file based on a template."
    Write-Host "Arguments:"
    Write-Host "  fileName   Specify the Markdown file name, e.g., 'latex-simple-note.md'"
    Write-Host "Example:"
    Write-Host "  ./create-paper.ps1 latex-simple-note.md"
    exit
}

# Convert the fileName parameter to title case for articleName
$words = ($fileName -replace '\.md$', '' -replace '-', ' ') -split ' '
$articleName = ($words | ForEach-Object { $_.Substring(0,1).ToUpper() + $_.Substring(1).ToLower() }) -join ' '

# Set template content
$template = @"
---
title: '$articleName'
date: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
tags: []
published: false
comments: false
publish-link:
---

$articleName Note.

<!--more-->


"@

# Create the new Markdown file with UTF-8 encoding
$template | Out-File -FilePath "./docs/rsc/draft/$fileName" -Encoding UTF8

Write-Host "Markdown file './docs/rsc/draft/$fileName' has been created"