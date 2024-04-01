---
title: protoc-simple-use
date: 2024-03-29 12:33:12
tags: []
categories: []
published: true
---

<!--content-->

[Install protoc on Ubuntu 22.04 | Lindevs](https://lindevs.com/install-protoc-on-ubuntu/)

```bash
curl -Lo protoc.zip "https://github.com/protocolbuffers/protobuf/releases/latest/download/protoc-${PROTOC_VERSION}-linux-x86_64.zip"
```



```bash
sudo unzip -q protoc.zip bin/protoc -d /usr/local
sudo chmod a+x /usr/local/bin/protoc
protoc --version
```



把 Include 添加到 include 下



如果给你报了 [libprotobuf WARNING google/protobuf/compiler/parser.cc:648] No syntax specified for the proto file: details.pb.go. Please use 'syntax = "proto2";' or 'syntax = "proto3";' to specify a syntax version. (Defaulted to proto2 syntax.) details.pb.go:6:1: Expected ";". 这个错

那其实就是这个目录底下还有除了 proto 文件之外的文件，proto 没有做识别，所以扫其他文件的时候也要求 proto 语法自然就报错了，解决方法就是把除了 proto 文件以外的内容移除出去
