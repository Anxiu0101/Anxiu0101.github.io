---
title: 'Integrate Umami with your MkDocs Site'
date: 2024-03-16 09:01:15
tags: [Umami, MkDocs, Tool, Vercel, Supabase]
published: true
---

通过免费服务 Vercel 和 Supabase，将 Umami 和你的 MkDocs 站点进行集成，获取隐私性优于 Google Analysis 的站点访问统计服务！

<!--more-->

## Basic Introduction

[Umami](https://umami.is/) is a simple, fast, privacy-focused alternative to Google Analytics. Umami makes it easy to collect, analyze, and understand your web data — while maintaining **visitor privacy** and **data ownership**. 

本文的方案是使用 [Vercel](https://vercel.com/) 部署 Umami 应用，并集成 [Supabase](https://supabase.com) 作为数据储存的 MkDocs 站点数据统计整合方案。整个方案主打的就是一个免费 笑（其实就是不怎么用 Google Analysis 自己部署了一个开源版本就想用了 XD

Umami 官方在他们的 [文档](https://umami.is/docs) 中提供了很多部署方案，包括且不限于从源码安装，使用 Docker-compose 和 Docker 镜像。

直接看 [Docs: Running on Vercel – Umami](https://umami.is/docs/running-on-vercel) 这一章节，官方甚至写了一键部署我哭死，大胆点击 Deploy 按钮即可

![image-20240316080233265](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316080233265.png)

在仓库名位置写入自定的仓库名，Vercel 将会在你的 Github 上创建同名仓库，你可以自选 Private 或是 Public，一般私有就行，然后点击 Create。在第二步 Configure Project 中，Umami 会要求你填写字段 `DATABASE_URL`。这是因为 Umami 需要一个 PostgreSQL 或 MySQL 作为数据库。

![image-20240316082251637](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316082251637.png)

这时候就要用到 [Supabase](https://supabase.com/) 了（虽然官方提示可以用 Vercel 提供的 Vercel Postgres 数据库，但是笔者没试过。

[Supabase](https://github.com/supabase/supabase) 同样是一个开源项目，号称 The open source Firebase alternative。注册并登陆后创建一个新项目即可，命名自定，密码记住，Host 的位置自行选择，笔者使用的是美国西（听起来像火车站乐，进入项目页面选择右上角的绿色按钮 Connect，或者 Database 页面里也有，自己翻去吧。

![image-20240316083029612](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316083029612.png)

Supabase 弹出一个窗口，选择 URI 的链接点击 Copy 即可，注意将里面的那个 [YOUR-PASSWORD] 改成你创建项目时设置的那个密码。

![image-20240316083232854](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316083232854.png)

回到 Vercel，将链接复制到 `DATASET_URL` 的值中即可，点击 Deploy 部署，等待一两分钟后即完成部署。

![image-20240316080858125](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316080858125.png)

如果你想要为这个 Vercel 服务配置个人域名，点击 `Domains` 按钮进入配置页。我使用的是我的一个三级域名，直接输入你预期的域名后点击 Add，然后第一次解析肯定不成功，因为你的域名还没配置解析。复制 Vercel 提供的 DNS (二级域名是一个 DNS 的 IP 地址 A~~ddress~~，三级域名是一个域名 CNAME)，如下图

![image-20240316081231299](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316081231299.png)

去到你的域名服务商，例如我的是阿里云，去到域名解析功能，添加一条即可，

![image-20240316081710546](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316081710546.png)

回到 Vercel，转一会就成功了

![image-20240316080945489](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316080945489.png)

进入你的 Umami 网站，登录管理员账号，默认账号为 `admin`，密码为 `umami`，在 Umami 的官方文档里有写。

![image-20240316083710607](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316083710607.png)

进入后第一时间将管理员密码修改，进入 `Setttings > Users`，对管理员条目点击 Edit 修改密码。然后创建一个普通用户账户，身份设置为 User，用于你自己的日常使用。

![image-20240316083836294](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316083836294.png)

登出管理员后，登入你自己的新用户中，在 `Setting > Website` 页面中添加你要管理的站点，添加后的效果如下，

![image-20240316084243174](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316084243174.png)

点击 `Add website`，输入站点的名字和域名，

![image-20240316084341384](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316084341384.png)

然后对刚创建的条目点击 `Edit` 进行编辑。在 `Tracking code` 菜单下复制 HTML 标签，下一步就是将这个标签按 Umami 要求插入到你个人网站的 `<head></head>` 块中。

![image-20240316084641805](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316084641805.png)

笔者使用的博客方案是 MkDocs 的 Material 主题，需要在博客根目录下的 `overrides/` 中进行模板覆盖。创建一个`main.html` (或者 `base.html` 应该也行，因为 Material 主题的 `main.html` 是继承的 `base.html` 的) 在里面复制上原本 `base.html` 的内容并在 `<head>...</head>` 中添加上刚刚 Umami 生成的追踪脚本。

由于 MkDocs 是一个 Python 工具，并且需要安装一些 Python 包，所以笔者的博客目录下是使用 `poetry` 来管理环境的，所以你可以和我一样通过以下指令找到当前项目所在的 Python 环境

```shell
poetry env list --full-path
```

复制地址并进入 `./Lib/site-packages/`，找到 `material/` 包，打开 `templates/`，即可找到你现在环境使用的 `base.html` 的内容，修改并复制过去即可完成修改。重新部署站点后内容即会被添加到 `<head>...</head>` 标签之中。关于更多样式覆盖和修改的内容，可以参考 [Customization - Material for MkDocs (squidfunk.github.io)](https://squidfunk.github.io/mkdocs-material/customization/#overriding-partials)。

最终效果如下，

![image-20240316085832195](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240316085832195.png)