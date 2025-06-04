---
title: 'Convert Pdf2png'
date: 2025-06-02 13:07:38
tags: []
published: false
comments: false
---

<!--more-->

## Main Content

> [!cite]
>

Using python package `pdf2image`:

```python
from pdf2image import convert_from_path			
pages = convert_from_path("target.pdf", dpi=300)			
pages[0].save("out.png", "PNG")
```


https://stackoverflow.com/questions/6233400/how-do-you-convert-pdfs-to-pngs-with-ghostscript?utm_source=chatgpt.com
