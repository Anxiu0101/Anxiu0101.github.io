---
title: UoB-ICSSec
author: Anxiu
creation date: 2025-03-18 14:37
modification date: 2025-03-18 14:37
categories: # 分类
- Note
tags: # 标签
- Security
published: false
---

UoB Industry Control System Security Group Assessments Note.

<!--more-->

## Experimental Setup

通过 OpenVPN 连接服务。

在 VMware 中将配置一张 bridge 的 network interface，网卡指定为实验室Laptop的TypeC端口（通过 Windows Setting 查询端口名。）

将 Kali 的 Network Adapter 修改为这张网卡，然后通过以下指定重启网卡。

```shell
sudo ifconfig eth0 down

sudo ifconfig eth0 up
```

或者通过 SystemCtl 直接重启整个网络服务

```shell
systemctl restart NetworkManager.service
```