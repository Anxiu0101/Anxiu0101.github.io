---
title: 'Python Deps Management'
date: 2024-04-20 00:48:18
tags: [Code,Python,Poetry,Pip]
published: true
comments: true
---



```python
pip list
pip install -r requirements.txt
```

[[python\]Poetry在windows下的安装使用_window安装python poetry-CSDN博客](https://blog.csdn.net/FL1623863129/article/details/132630580)

[Can't install tensorflow on linux · Issue #8764 · python-poetry/poetry (github.com)](https://github.com/python-poetry/poetry/issues/8764)

![image-20240420014806696](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202404200148795.png)

```python
poetry init  # 初始化项目  
poetry shell  # 激活虚拟环境  
poetry show
poetry show 命令有一些选项可以帮助你更精确地列出依赖项。以下是一些常用选项：

--tree：以树形结构显示依赖关系，包括子依赖项。
--no-dev：仅显示主要依赖项，不包括开发依赖项。
--latest：显示每个依赖项的最新版本。
--outdated：仅显示已过时的依赖项及其当前版本。
--format [table|json]：指定输出格式为表格或 JSON 格式。
你可以在命令行中使用 poetry show --help 来查看所有可用选项及其描述。
poetry install  # 安装pyproject.toml里或poetry.lock里列出来的包  
poetry install --no-dev  # 只安装生产用依赖  
poetry add httpx  # 安装一个新的包  
poetry update httpx  ipython  # 升级已安装的一个或多个包  
poetry show --tree  # 展示已安装的包  
poetry remove gunicorn  # 卸载已安装的包  
poetry run python manage.py runserver   # 在不激活虚拟环境时执行命令
```







