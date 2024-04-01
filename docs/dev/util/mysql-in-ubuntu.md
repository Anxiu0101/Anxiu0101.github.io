---
title: 'MySQL in Ubuntu'
date: 2022-07-21 18:09:29
tags: [Linux,Tool,MySQL]
published: true
hideInList: false
feature: 
isTop: false
---

## Installation

```shell
sudo apt update # 更新依赖源
sudo apt install mysql-server -y # 下载安装 mysql-server，所有问询回答 Y
systemctl start mysql.service # 开启服务
```

检查服务状态

```shell
$ sudo systemctl status mysql.service
● mysql.service - MySQL Community Server
     Loaded: loaded (/lib/systemd/system/mysql.service; enabled; vendor preset: enabled)
     Active: active (running) since Thu 2022-07-21 17:55:55 CST; 13min ago
   Main PID: 223127 (mysqld)
     Status: "Server is operational"
      Tasks: 39 (limit: 1066)
     Memory: 356.3M
     CGroup: /system.slice/mysql.service
             └─223127 /usr/sbin/mysqld

Jul 21 17:55:54 ecs-anxiu systemd[1]: Starting MySQL Community Server...
Jul 21 17:55:55 ecs-anxiu systemd[1]: Started MySQL Community Server.
```

这里略过修改数据库密码，
通过密码进入 mysql-server 服务端，

```shell
$ mysql -u root -p
Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.29-0ubuntu0.20.04.3 (Ubuntu)

Copyright (c) 2000, 2022, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
```

### 配置 MySQL 允许远程链接

默认情况下，mysql帐号不允许从远程登陆，只能在localhost登录。

```sql
mysql>USE mysql;
mysql>SELECT host, user FROM user;
# 将 root 用户权限更改为所有 IP 皆可连接
mysql>update user set host = '%' where user = 'root'; 
mysql>FLUSH PRIVILEGES;
```

在配置文件中为 `localhost` 解除绑定

```shell
vim /etc/mysql/mysql.conf.d/mysqld.cnf
```

修改 `bind-address = 127.0.0.1` 为 `bind-address = 0.0.0.0`，或者直接将该字段注释掉。

> [!note]
>
> 该字段在文件中有注释内容，By dafualt we only accept connections from localhost。即默认只允许本地访问。你也可以通过配置该字段设置限定访问的服务器 IP。

同时在本文件中也可以通过修改 `[mysqld]` 的 字段 `port` 来指定你设置的 MySQL 服务访问端口。

## 关于容器

> [你在 Docker 中跑 MySQL？恭喜你，可以滚了！](https://zhuanlan.zhihu.com/p/424233173)

如此文所说，容器本身就随时可以停止、或者删除。当容器被 remove 掉，容器里的数据将会丢失。为了避免数据丢失，用户可以使用数据卷挂载来存储数据。另外由于数据库是调用硬盘的，需要强大的 IO 性能，如果在同一个服务器上跑多个容器，将会导致 MySQL IO 性能的严重下降。

有一些相应的解决措施，
1. 数据库程序与数据分离
2. 跑轻量级或分布式数据库
3. 合理布局应用

当然，MySQL 也不是全然不能容器化。
1. 对数据丢失不敏感的业务（例如用户搜索商品）就可以数据化，利用数据库分片来来增加实例数，从而增加吞吐量。
2. docker适合跑轻量级或分布式数据库，当docker服务挂掉，会自动启动新容器，而不是继续重启容器服务。
3. 数据库利用中间件和容器化系统能够自动伸缩、容灾、切换、自带多个节点，也是可以进行容器化的。

## Linux 中的相关操作

### 查看端口占用信息

```shell
lsof -i:<端口号>
```
例如，检查 MySQL 是否启用了 3306 端口，

```shell
$ lsof -i:3306
COMMAND    PID  USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
mysqld  227885 mysql   24u  IPv4 917710      0t0  TCP localhost:mysql (LISTEN)
```

当然，你也可以使用 `netstat -a` 将所有使用中的端口信息打印出来，然后检查 MySQL 使用了那个端口。如果 MySQL 服务没有启用，也可以 `netstat -ap` 打印所有端口占用信息。例如，

```shell
netstat -an|grep 3306
```




### 使用 SystemCTL 管理 MySQL 服务

```shell
systemctl start mysql.service
systemctl stop mysql.service
systemctl restart mysql.service
systemctl status mysql.service # 查看当前服务状态
systemctl enable mysql.service # 设置 MySQL 服务开机自启
systemctl disable mysql.service # 关闭 MySQL 服务开机自启
```

## MySQL 基础操作

登录数据库

```sql
mysql -u user_name -p
Enter password:******
```

数据库相关操作

```sql
# 展示 MySQL 内已有的数据库。
mysql > show databases;
# 创建一个名为 database_name 的数据库，在创建前检查 MySQL 中是否已经存在这个数据库
# 指定数据库的字符集为 utf8mb4，数据库的排序规则为 utf8mb4_general_ci
mysql > CREATE DATABASE IF NOT EXISTS database_name
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;
# 进入指定的数据库，在进入数据库之后才可以对数据表进行访问。
mysql > use database_name;
# 展示数据库中的所有数据表
mysql > show tables;
```

数据表相关操作

```sql
# 列出名为 table_name 的数据表的字段信息
mysql > desc table_name;
# 查询名为 table_name 的数据表的数据条数
mysql > select count(*) from table_name;
# 更新名为 table_name 的数据表中 user 字段为 root 的条目的 host 为 %
mysql > update table_name set host='%' where user = 'root';
```

特殊操作

```sql
# 在修改了 MySQL 数据库下的表内容时，进行权限刷新
mysql > flush privileges;
```



[SQL for Data Analysis Cheat Sheet | LearnSQL.com](https://learnsql.com/blog/sql-for-data-analysis-cheat-sheet/)
