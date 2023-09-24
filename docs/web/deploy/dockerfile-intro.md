---
title: 'Dockerfile 的简单使用'
date: 2022-07-30 17:10:48
tags: [Docker,Tool,Linux]
published: true
hideInList: false
feature: 
isTop: false
---
Go 项目创建 Dockerfile

<!--more-->



## Dockerfile 的主要结构

### FROM

`FROM` 为你要定制的镜像选择基础镜像

```dockerfile
FROM [--platform=<platform>] <image> [AS <name>]
FROM [--platform=<platform>] <image>[:<tag>] [AS <name>]
FROM [--platform=<platform>] <image>[@<digest>] [AS <name>]
```

- `ARG` 是唯一可能在`FROM`之前出现的指令
- 单个`Dockerfile`中可以出现多次`FROM`命令，用来创建多个镜像，或使用一个构建阶段作为另一个构建阶段的依赖项
- 可以选择通过添加`AS name`到 `FROM`指令来为新的构建阶段命名。该名称可在后续`FROM`和 `COPY --from=<name>`说明中用于引用此阶段构建的镜像。
- 该`tag`或`digest`值是可选的。如果您省略其中任何一个，构建器默认使用一个`latest`标签。如果找不到该`tag`值，构建器将返回错误。

`--platform`可以指定构建的目标平台，可以指定`linux/amd64`, `linux/arm64`, `windows/amd64`, 默认使用当前平台（`--platform=$BUILDPLATFORM`）



### RUN

`RUN` 用于执行后面跟着的命令行格式，有 `shell` 和 `exec` 两种格式，

- shell: 使用 Linux平台的`/bin/sh -c` 或 windows平台的`cmd /S /S`执行命令

  ```dockerfile
  RUN <命令行命令>
  # <命令行命令> 等同于，在终端操作的 shell 命令。
  ```

- exec

  ```dockerfile
  RUN ["可执行文件", "参数1", "参数2"]
  # 例如：RUN ["./test.php", "dev", "offline"] 等价于 RUN ./test.php dev offline
  ```
  
  

Dockerfile 的指令每执行一次都会在 docker 上新建一层。过多无意义的层，会造成镜像膨胀过大。所以可以将部分指令进行简化，合并到同一层，

```bash
FROM centos
RUN yum -y install wget
RUN wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz"
RUN tar -xvf redis.tar.gz

# Simplified
FROM centos
RUN yum -y install wget \
    && wget -O redis.tar.gz "http://download.redis.io/releases/redis-5.0.3.tar.gz" \
    && tar -xvf redis.tar.gz
```



### EXPOSE

```docker
EXPOSE <port> [<port>/<protocol>...]
```

`EXPOSE`指令通知 Docker , 容器在运行时侦听指定的网络端口。可以指定端口是监听TCP还是UDP，如果不指定协议，默认为TCP。

该`EXPOSE`指令实际上并未暴露端口。它充当构建镜像的人和运行容器的人之间的一种文档，关于打算暴露哪些端口。要在运行容器时实际暴露端口，请在`docker run`中使用`-p`标志 来暴露和映射一个或多个端口，或者使用`-P`标志来发布所有暴露的端口并将它们映射到高阶端口。EXPOSE默认使用TCP，也能手动指定UDP。

```dockerfile
EXPOSE 80/tcp
EXPOSE 80/udp
```

无论`EXPOSE`设置的如何，在运行时都可以用`-p`覆盖它们。

```bash
 $ docker run -p 80:80/tcp -p 80:80/udp ...
```

> ==docker network== 命令支持创建用于容器间通信的网络，而无需公开或发布特定端口，因为接到该网络的容器可以通过任何端口相互通信。



### ENV

```docker
ENV <key>=<value> ...
```

`ENV`设置环境变量，用在后续构建阶段的环境中，也用在许多变量内联替换中。

使用`ENV`设置的环境变量，将在容器运行时始终存在。使用命令`docker inspect`可以查看环境变量的值，也可以使用`docker run --env <key>=<value>`修改运行时的环境变量。

如果仅在构建阶段使用到这个变量，而不是在最终的镜像中，可以在单个命令中设置该值，而非设置成环境变量。

```docker
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y ...
```



### CMD

一个`Dockerfile`只能指定一个`CMD`指令，若是有多个`CMD`指令，只有最后一个是生效的。`CMD`指令的目的是为了给“执行容器”一个默认的执行程序。

`CMD` 指令有三种形式：

- `CMD ["executable","param1","param2"]`（exec 形式，这是首选形式）
- `CMD ["param1","param2"]`（作为 ENTRYPOINT 的默认参数）
- `CMD command param1 param2`（shell 形式）

### ENTRYPOINT

ENTRYPOINT有两种形式：

优先选用EXEC形式：

```docker
ENTRYPOINT ["executable", "param1", "param2"]
```

shell形式：

```docker
ENTRYPOINT command param1 param2
```

`ENTRYPOINT`允许你将容器配置成是“可执行”的。

`docker run <image>`的命令行参数将会附加到exec形式的`ENTRYPOINT`后面，同时也会覆盖所有`CMD`指令参数。例如，`docker run <image> -d`中的`-d`参数将会附加到entry point 后面。使用`docker run --entrypoint`标志可以覆盖`ENTRYPOINT`指令。

shell形式的`ENTRYPOINT`将会阻止`CMD`或`docker run`命令行参数。但是这种形式的`ENTRYPOINT`有个缺点，它会使用命令`/bin/sh -c`启动，并且不通过信号量机制。这意味着这个进程的PID不是1（sh 的PID才是1），并且收不到Unix的信号量，所以收不到`docker stop <container>`发送来的信号。

若有多个`ENTRYPOINT`指令，只有最后一个是有效的。

**Exec形式的ENTRYPOINT示例**

使用exec形式的`ENTRYPOINT`设置固定的参数，使用`CMD`指令设置可更改的参数的默认值。

```docker
FROM ubuntu
ENTRYPOINT ["top", "-b"]
CMD ["-c"]
```

默认执行`docker run <image>`执行的是`top -b -c`，而`docker run <image> -H`执行的是`top -b -H`.（`CMD`指令指定的参数被覆盖了）

**Shell形式的ENTRYPOINT示例**

shell形式的`ENTRYPOINT`指令将会在`/bin/sh -c`中执行。这种形式运行的程序将会忽略`CMD`和`docker run`指定的所有参数。

为了保证收到`docker stop`的信号，命令可以以exec开头：

```text
FROM ubuntu
ENTRYPOINT exec top -b
```

以exec开头的shell形式的`ENTRYPOINT`指令，PID仍然是1.

**CMD和ENTRYPOINT交互**

指令`CMD`和`ENTRYPOINT`都指定了容器运行的命令，下面是两者交互的规则：

- Dockerfile中至少有一个`CMD`或`ENTRYPOINT`指令
- 将容器作为一个执行体的时候应该定义`ENTRYPOINT`指令
- `CMD`指令应该定义`ENTRYPOINT`指令的默认参数，或者执行容器的临时命令
- 当容器运行使用了其他参数，`CMD`指令将被覆盖

> 如果CMD是在基础镜像中定义的，ENTRYPOINT将会重置CMD。在这种情况下，CMD必须在当前镜像中重新定义一个新值。





## 影响镜像大小的原因

- 选择的基础镜像的大小会影响定制镜像的大小

  这里有一些适用于 Linux 生产环境的基础镜像，

  | 镜像名称 | 大小   | 使用场景                                                     |
  | -------- | ------ | ------------------------------------------------------------ |
  | busybox  | 1.15MB | 临时测试用，超级简化版嵌入式Linux系统                        |
  | alpine   | 4.41MB | 主要用于测试，也可用于生产环境，面向安全的、轻量级的Linux系统 |
  | centos   | 200MB  | 主要用于生产环境，支持CentOS/Red Hat，常用于追求稳定性的企业应用 |
  | ubuntu   | 81.1MB | 主要用于生产环境，常用于人工智能计算和企业应用               |
  | debian   | 101MB  | 主要用于生产环境                                             |

  如果你不想使用任何镜像作为基础镜像或不需要基础镜像，可以使用 ==scratch== 作为基础镜像，这个镜像是虚拟的概念，并不实际存在，它表示一个空白的镜像。对于 Linux 下静态编译的程序来说，并不需要有操作系统提供运行时支持，所需的一切库都已经在可执行文件里了，因此直接 `FROM scratch` 会让镜像体积更加小巧。使用 Go 语言开发的应用很多会使用这种方式来制作镜像。


- Dockerfile 的指令每执行一次都会在 docker 上新建一层。过多无意义的层，会造成镜像膨胀过大。



> [Dockerfile 使用说明 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/434090003)
> [go项目创建Dockerfile，构建docker镜像 - 水木神舟10 - 博客园 (cnblogs.com)](https://www.cnblogs.com/zhouj850/p/15796935.html)