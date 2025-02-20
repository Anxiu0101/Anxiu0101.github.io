# # 获取用户输入的文件名
# $articleName = Read-Host -Prompt "Title Name: "

# # 设置模板内容
# $template = @"
# ---
# title: '$articleName'
# date: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
# tags: []
# published: false
# comments: false
# ---

# ## Main Content

# > [!note]
# > 


# "@

# # 获取用户输入的文件名
# $fileName = Read-Host -Prompt "Markdown File Name:"

# # 创建新的 Markdown 文件
# $template | Out-File "./docs/draft/$fileName.md"

# Write-Host ('Markdown 文件 ''./docs/draft/{0}.md'' 已创建' -f $fileName)

# param (
#     [string]$fileName
# )

# # 检查是否输入了参数
# if (-not $fileName) {
#     Write-Host "错误: 请输入文件名作为参数。使用 './create.ps1 help' 查看帮助信息。"
#     exit
# }

# # 检查是否请求帮助
# if ($fileName -eq "help") {
#     Write-Host "用法: ./create.ps1 <fileName>"
#     Write-Host "描述: 根据模板创建新笔记文件。"
#     Write-Host "参数:"
#     Write-Host "  fileName   指定Markdown文件名，例如 'latex-simple-note.md'"
#     Write-Host "示例:"
#     Write-Host "  ./create.ps1 latex-simple-note.md"
#     exit
# }

# # 将 fileName 参数转换为每个单词首字母大写的形式作为 articleName
# $articleName = ($fileName -replace '-',' ' | ForEach-Object { $_ -split ' ' | ForEach-Object { $_.Substring(0,1).ToUpper() + $_.Substring(1).ToLower() } } -join ' ' -replace '.md','')

# # 设置模板内容
# $template = @"
# ---
# title: '$articleName'
# date: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
# tags: []
# published: false
# comments: false
# ---

# ## Main Content

# > [!note]
# > 

# "@

# # 创建新的 Markdown 文件，并指定 UTF-8 编码
# $template | Out-File -FilePath "./docs/draft/$fileName" -Encoding UTF8

# Write-Host "Markdown 文件 './docs/draft/$fileName' 已创建"

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
    Write-Host "  ./create.ps1 latex-simple-note.md"
    exit
}

# Convert the fileName parameter to title case for articleName
$articleName = ($fileName -replace '-', ' ' | ForEach-Object { $_ -split ' ' | ForEach-Object { $_.Substring(0,1).ToUpper() + $_.Substring(1).ToLower() } } -join ' ' -replace '.md', '')

# Set template content
$template = @"
---
title: '$articleName'
date: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")
tags: []
published: false
comments: false
---

## Main Content

> [!note]
> 

"@

# Create the new Markdown file with UTF-8 encoding
$template | Out-File -FilePath "./docs/draft/$fileName" -Encoding UTF8

Write-Host "Markdown file './docs/draft/$fileName' has been created"
