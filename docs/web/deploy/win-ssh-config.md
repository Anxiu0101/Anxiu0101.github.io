---
title: 'Win SSH host 代理配置及远程免密码登陆'
date: 2022-10-01 16:06:24
tags: [Tool]
published: true
hideInList: false
feature: 
isTop: false
---
https://blog.csdn.net/u010649766/article/details/78423186

```config
Host <remote host name-just you like>
	HostName <remote host ip>
	User <remote user, usually 'root'>
	IdentityFile <your private rsa key, My location is 'C:/Users/A/.ssh/id_rsa'>
```

Then upload your public rsa key in remote server.

```bash
ssh <remote host name>
```