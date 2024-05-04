# 获取用户输入的文件名
$articleName = Read-Host -Prompt "Title Name: "

# 设置模板内容
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

# 获取用户输入的文件名
$fileName = Read-Host -Prompt "Markdown File Name:"

# 创建新的 Markdown 文件
$template | Out-File "./docs/draft/$fileName.md"

Write-Host "Markdown 文件 './docs/draft/$fileName.md' 已创建"
