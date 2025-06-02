---
title: 'Systemctl 介绍'
date: 2022-07-26 23:21:51
tags: [Linux,Tool]
published: true
hideInList: false
feature: 
isTop: false
---

## Systemd 介绍

https://blog.csdn.net/shliang310/article/details/122576783

## Systemctl in Ubuntu

Ubuntu 中 `.service` 文件路径: `/etc/systemd/system`，但实际上部分服务是从 `/lib/systemd/system` 中软连接的。

https://blog.csdn.net/qq_44947550/article/details/119052871

## `.service` 文件配置

https://blog.csdn.net/qq_41035283/article/details/122793745

更改完 `/service` 文件后使用 `systemctl daemon-reload` 刷新 Systemctl 服务配置。

## Using `journalctl` review service log

`journalctl -u <service_name> -f`

`-u` 指定服务名字，在这里全称是 `unit`。

https://askubuntu.com/questions/659267/how-do-i-override-or-configure-systemd-services