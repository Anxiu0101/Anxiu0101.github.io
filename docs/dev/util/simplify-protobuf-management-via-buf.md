---
title: Simplify protobuf management via Buf
date: 2024-03-31 06:38:21
tags: [buf, protoc, proto, grpc, grpc-gateway]
categories: [util]
published: true
---

这是我在 [个人项目](github.com/Campus-Hub/server-micro) 中使用 buf 工具进行配置的一个简单介绍，Buf BSR 仓库地址为 [Docs · anxiu/campus-hub-idl (buf.build)](https://buf.build/anxiu/campus-hub-idl)。由于并没有找到太多资料，如有不足之处欢迎交流。

<!--content-->

[Buf - Introduction](https://buf.build/docs/introduction)

我在 Go 项目根目录放置了一个 `buf.work.yaml`，内容如下，

```yaml
# buf.worl.yaml
version: v1
directories:
    - api
```

然后在 `api/` 目录下放置生成的代码和 IDL `.proto` 文件，`api/` 文件层级如下

```shell
api.
├── Makefile
├── buf.gen.yaml
├── buf.lock
├── buf.yaml
├── buf_gen
│   ├── go
│   │   └── idl
│   │       ├── common			// Basic package
│   │       │   └── base.pb.go
│   │       ├── entity			// Models
│   │       │   └── course_entity.pb.go
│   │       └── service			// Service contract
│   │           └── course
│   │               ├── rpc.pb.go		// protoc golang code
│   │               ├── rpc.pb.gw.go	// grpc-gateway code
│   │               └── rpc_grpc.pb.go	// grpc code
│   └── ts
│   │   └── ... // different language/version
└── idl
    ├── buf.yaml
    ├── common
    │   └── base.proto
    ├── entity
    │   └── course_entity.proto
    └── service
        ├── course
        │   └── rpc.proto
        └── resource
            └── rpc.proto
```

我将 `.proto` 文件分为三个层级，分别为 用于放置基本通用类型的 `common`，用于放置模型实体的 `entity`，以及用于放置服务约定的 `service`。`service` 下再依据各个模块进行业务分类。 

`buf.yaml` 配置如下，

```yaml
# buf.yaml
version: v1
name: buf.build/anxiu/campus-hub-idl
deps:
  - buf.build/googleapis/googleapis
breaking:
  use:
    - FILE
lint:
  use:
    - DEFAULT
```

其中 `name` 字段是 buf 提供的 BSR 功能中 proto 仓库的名字；`deps` 字段是你 `proto` 文件的依赖，这个依赖也是通过 BSR 功能来支持的，它通过获取远程仓库内容来进行引入和编译；`breaking` 和 `lint` 可以配置运行的模型。

```shell
$ go install \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway \
    github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-openapiv2 \
    google.golang.org/protobuf/cmd/protoc-gen-go \
    google.golang.org/grpc/cmd/protoc-gen-go-grpc
```

| Name                    | Version                  | Address                                    |
| ----------------------- | ------------------------ | ------------------------------------------ |
| protoc                  | libprotoc 26.1           | /usr/local/bin/protoc                      |
| protoc-gen-go           | protoc-gen-go v1.33.0    | /home/anxiu/go/bin/protoc-gen-go           |
| protoc-gen-go-grpc      | protoc-gen-go-grpc 1.1.0 | /home/anxiu/go/bin/protoc-gen-go-grpc      |
| protoc-gen-grpc-gateway | Version dev              | /home/anxiu/go/bin/protoc-gen-grpc-gateway |
| protoc-gen-openapiv2    | Version dev              | /home/anxiu/go/bin/protoc-gen-openapiv2    |
| buf                     | 1.30.0                   | /home/anxiu/go/bin/buf                     |

> [!warning]
>
> 对于以上版本内容，对于 gRPC 包的版本亦有要求(>=1.32.0)，否则生成的代码将会找不到 grpc 相关的一些结构体。
>
> [docker - undefined: grpc.SupportPackageIsVersion7 grpc.ServiceRegistrar - Stack Overflow](https://stackoverflow.com/questions/63662787/undefined-grpc-supportpackageisversion7-grpc-serviceregistrar)
>
> **`grpc.SupportPackageIsVersion`** is used to track the version of the protobuf generated code and is different from the grpc release version.
>
> In short, Your generated GRPC code structure is newer than your `google.golang.org/grpc` package. So you must update your `go grpc` package to the new one.
>
> `SupportPackageIsVersion7` support after `1.32.0` versions. and they support old versions with **go version >= 1.12**

在 `buf.gen.yaml` 文件中你可以指定使用的插件，通过 `yaml` 的格式进行配置显然比原本 `protoc` 命令的编写更具可读性。你需要使用 `go_package_prefix` 字段填写生成位置的前缀，但是这个字段不影响代码生成的位置，只影响生成的代码中 `import` 部分的前缀内容，如果无法确定可以先生成一次然后再修改这个前缀后重新生成。

通过指定 `plugins` 的名字选择使用的 plugin，然后通过 `out` 字段进行生成位置的配置，以及通过 `opt` 字段为插件提供入参。

```yaml
# buf.gen.yaml
version: v1
managed:
  enabled: true
  go_package_prefix:
    default: github.com/Campus-Hub/server-micro/api/buf_gen/go
plugins:
  - name: go
    out: buf_gen/go
    opt:
      - paths=source_relative
  - name: go-grpc
    out: buf_gen/go
    opt:
      - paths=source_relative
      - require_unimplemented_servers=false
  - name: grpc-gateway
    out: buf_gen/go
    opt:
      - paths=source_relative
  - name: openapiv2
    out: buf_gen/openapiv2/
```



在部分情况下，例如使用 grpc-gateway 插件进行网关代码生成时，需要使用到 `googleapi` 的两个 `proto` 文件。

```protobuf
import "google/api/http.proto";
import "google/api/annotations.proto";
```

可以通过在 `buf.yaml` 中引入，只有在你准备运行的目录下的 `buf.yaml` 中指定才能有效。

```yaml
deps:
  - buf.build/googleapis/googleapis
```

引入后需要进行依赖的更新/下载才可以被调用，本质应该是调用的 buf 的 BSR 内的 googleapi 仓库[^3]的内容， 

```shell
buf mod update
```

将会在指令执行的同级目录下生成/更新 `buf.lock` 文件。之后就可以进行 `buf generation` 了，将会在你的指定目录为你生成 `.pb.gw.go` 文件。

## Reference

[^1]: [iamrajiv/helloworld-grpc-gateway: This project is a basic hello world program utilizing gRPC-Gateway. It was developed as part of my participation in Google Season of Docs 2020 with gRPC-Gateway. The goal of this project is to introduce and familiarize individuals with gRPC-Gateway. (github.com)](https://github.com/iamrajiv/helloworld-grpc-gateway)
[^2]: [gRPC: 如何让 gRPC 提供 Swagger UI? - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/419897333)
[^3]: [Docs · googleapis/googleapis (buf.build)](https://buf.build/googleapis/googleapis/docs/main)
[^4]: [Generating stubs using buf | gRPC-Gateway (grpc-ecosystem.github.io)](https://grpc-ecosystem.github.io/grpc-gateway/docs/tutorials/generating_stubs/using_buf/)
