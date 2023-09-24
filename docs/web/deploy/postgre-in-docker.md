---
title: 'Use Postgre in Docker'
date: 2022-07-08 01:06:32
categories: [Code]
tags: [Tool,Docker,PostgreSQL,Linux]
published: true
hideInList: false
feature: 
isTop: false
---

使用 Docker 安装 Postgre 并通过 psql-client 进行使用

<!--more-->

## 环境

- Ubuntu 20.04.4 LTS
- psql (12.9 (Ubuntu 12.9-0ubuntu0.20.04.1)
- server 14.2 (Debian 14.2-1.pgdg110+1))
- Docker 

## 安装

> 参考网址
> [教程 PostgreSQL - Docker 安装](https://techexpert.tips/zh-hans/%E6%B3%A2%E6%96%AF%E7%89%B9%E6%A0%BC%E9%9B%B7%E6%96%AF/postgresql-docker-%E5%AE%89%E8%A3%85/)



### 通过 Dockerfile 安装 PostgreSQL

通过编写 Dockerfile 拉取官方的 postgres 的最新版本镜像，然后设置环境变量和暴露的端口即可。

```
FROM postgres:latest

# PostgreSQL Env Variable
ENV POSTGRES_USER root
ENV POSTGRES_PASSWORD 123456@pgsql
ENV POSTGRES_DB camp

# Postgres Listen Port
EXPOSE 5432
```

需要注意的是，这里的三个环境变量只有 `ENV POSTGRES_PASSWORD` 是必备的，剩下两个都是可选的环境变量配置。

编写完 Dockerfile 就可以创建镜像了，你可以选择命令行创建，这种方式便于大规模的集群部署。如果，是在本地使用 Goland 编辑的话可以使用 GUI 来创建，

![image-20221010222400721](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202210102224196.png)



## Docker 环境

Docker 环境里三个组成部分，Image, Container, Volume。你可以把你的配置保存为自己的镜像，例如我这里设置了这个镜像为 `postgre-camp:1.0`。容器是你的机器里具体在运行的虚拟化应用，你可以在同一个机器中创建多个容器。Volume 是数据卷，用于保存持久化数据，postgres 默认保存路径为, `/var/lib/postgresql/data`。

![image-20221010222726919](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202210102227949.png)





## 使用 pgsql 服务

你可以使用 `docker` 指令去访问容器内部的 `pgsql` 服务，如下

```she
docker exec -it <Container ID> /bin/bash
```

进入到容器后，使用 `psql` 客户端连接 `PostgreSQL`，

```shell
psql -h 127.0.0.1 -U postgres
# -U 用户名
# -p 指定端口
# -h IP 地址
# -d 数据库库名(可选)
```

### `pgsql` 快捷指令

- `\l` 查看系统中现存的数据库

- `\q` 退出客户端程序psql

- `\c` 从一个数据库中转到另一个数据库中，如 `template1=# \c sales` 从template1转到sales

- `\dt` 查看表

- `\d` 查看表结构

- `\di` 查看索引
