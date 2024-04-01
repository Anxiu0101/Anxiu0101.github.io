---
title: 'Go 项目编译'
date: 2022-08-06 15:42:20
tags: [Golang,Code]
published: true
hideInList: false
feature: 
isTop: false
---


以下是我的项目结构

```go
.
├── api
├── cache
├── cmd
│   └── main.go
├── conf
├── cron
├── go.mod
├── go.sum
├── log
├── middleware
├── model
├── pkg
├── README.md
├── router
├── service
└── static

```

`main.go` 文件在 `cmd/` 路径下，

编译 Go 项目


```bash
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-w' -i -o civil cmd/main.go
```

- `CGO_ENABLED=0` 指明 `cgo` 工具是否可用的标识，在这里0表示禁用。
- `GOOS=linux` 目标平台（编译后的目标平台）的操作系统（`darwin`、`freebsd`、`linux`、`windows`）
- `-a` 强制重新编译所有涉及的go语言代码包
- `installsuffix` 为了使当前的输出目录与默认的编译输出目录分离，可以使用这个标记。
- `cgo` 如下：
  - `ldflags` 给 `cgo` 指定命令
  - `w` 关闭所有警告信息
  - `i` 标志安装目标的依赖包。
  - `-o` 目录/生成的程序：指定可执行文件名
  - `cmd/main.go` 编译的 `main.go` 地址

> 原文：[ golang项目编译](https://blog.csdn.net/weixin_42506905/article/details/93135684)