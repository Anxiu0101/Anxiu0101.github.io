Using Docker in Development Env 
<!--more-->

> Ref: 
>
> - [Docker 手册 - docker动态 - docker中文社区](https://www.docker.org.cn/docker/docker-206.html)
> - [Docker 入门教程 - 阮一峰的网络日志 (ruanyifeng.com)](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)

在开发环境中使用 Docker，首先需要先了解 Docker 的使用场景及其提供的功能。

## Basic Intro 基础介绍

由于各个用户的机器环境都不同，在部署运维过程中常常会遇到哪些由于兼容性而引发的问题。所以我们需要一个能够在所有机器上建立一个指定生产环境的工具，使得服务可以不用受困于系统的兼容性问题。

过去服务提供商们也许会使用虚拟机，但是虚拟机的一大缺点就是它需要移植一整套操作系统环境，也许在当时可以称为解决兼容性的一种措施。但是在云原生的今天，虚拟机的性能问题和内存占用使得这个方法已经无法解决服务系统的高性能要求，也会带来很大的成本开销。假设一台服务器上运行三四个微服务，使用虚拟机的策略就会使得这台服务器上同时安装着几个相同的独立的固定空间占用的操作系统，性能和弹性都达不到需求，这样的冗余拥有巨大的优化空间。

于是 Containers 容器技术应运而生，Docker 就是一个使用 Container 容器技术的软件完成虚拟化的应用。

- Docker 可以让开发者打包他们的应用以及依赖包到一个轻量级、可移植的容器中，然后发布到任何流行的 Linux 机器上，也可以实现虚拟化；
- 容器是完全使用沙箱机制，相互之间不会有任何接口，更重要的是容器性能开销极低

于是被广泛用于：

- Web应用的自动化打包和发布，自动化测试和持续集成、发布；
- 在服务型环境中部署和调整数据库或其他的后台应用；
- 从头编译或者扩展现有的 OpenShift 或 Cloud Foundry 平台来搭建自己的 PaaS 环境。

### Linux Container

如果你是一名 Golang 开发者，那么你可能知道当下最流行的容器应用 Docker 和分布式容器管理系统 [Kubernetes](https://kubernetes.io/zh-cn/) (我们也称为 k8s) 都是使用 Golang 编写的。基于此，你可以参考以下链接中演示了如何编写一个基础容器软件的视频，一段 GOTO Conferences 中的演示。(当场手搓一个容器软件，演示过程没有任何 bug，这真的很酷，不是吗)。印象中，知乎上有一篇使用 C++ 复刻这个视频代码的文章可供参考，这里就不提供链接了。

> [Containers From Scratch • Liz Rice • GOTO 2018](https://youtu.be/8fi7uSYlOdc)

这里也主要依据这个视频和其他资料对容器技术进行讲解。

首先你需要先理解两个个概念，**namespaces & control group**。

Namespace is a domain which limits what you can see. And it set up by syscalls. There are six system process attribute main:

- Unix Timesharing System
- Process IDs
- Mounts
- Network
- User IDs
- InterProcess Comms

Maybe have a tiny different in different OS, but it's important for container technology to limit the scheme, and control things going on the machine.

And there are one last sort of property of containers, that is control groups.

If no space is restricted what we can see from inside the container. A control group limits the resources that we can use inside it. And we do this it's configured using another one of these pseudo file system interfaces so it's another set of what looks like directories and files but we can manipulate them to set properties that we want the kernel to understand and the kernel will write information into the file system so that we can read it back out again and we could taking about things like how much memory is allowed to be use, how much CPU, how much IO band width it's allowed, how many processes were allowed.

And then the speaker shows how control group defined the folk bomb like this command 
```shell
: ( ) { : | : & } ; :
```

> Overview:
>
> - Namespaces 命名空间
>   - What you can see 限制了容器的可见域
>   - Created with syscalls 通过 `syscall` 创建
> - CGroups (Control Groups) 控制组
>   - What you can use 限制了你可以使用的资源
>   - Filesystem interface 通过文件系统的接口实现
>
> This two establish a container. 二者共同构建了一个基础的容器



### Basic Components in Docker

从上述对于容器技术的介绍，你应该已经理解了什么是容器，当然这也是我想首先介绍的。

#### Container

The unit of a env. 一个环境单元，这是我的理解方式，容器内的运行独立的进程群，系统进程对于容器内进程不可见，系统进程也只能通过特定接口访问容器进程。

你可以在你的服务器中封装一个独立的容器，a container。来进行内外服务的隔离，同时 Docker 对于各个系统做出了适配使得内部的环境可以根据你的想法来设定，例如在 CentOS 系统中运行一个 Ubuntu 的容器。适配性兼容性问题由 Docker 的虚拟化技术为你解决，而你只需要专注于开发即可。

#### Image

镜像，你可以将它理解为开源的 Docker 环境配置文件或者说，模板。你可以通过镜像 Image 来生成一个容器 container。Docker 中有一个 Docker-Hub，所有人可以将自己的容器封装为镜像 push 到 Docker-Hub 中，就像我们在 GitHub 中做的那样。自然，Docker-Hub 上也有很多官方发布的镜像 (毕竟几乎所有大型云服务商都在用 Docker)，包括常见的 MySQL，Redis，Nginx 等。

你可以从 Docker-Hub 上拉取镜像，然后改造为适合你使用的配置或是直接使用。下文将会向你介绍具体的操作步骤。

#### Volume

数据卷，实际上是 docker 数据的挂载点。对于容器来说，这是一个可选项。有时我们希望 container 将它处理好的数据储存在服务器上特定的位置进行持久化，或是几个容器之间共享数据，例如在使用 MySQL 容器时，我们希望让它将数据库数据持久化到 `/data/mysql:/var/lib/mysql` 之中。(虽然这个操作还有很多争议，有些人认为这些数据库不应该使用容器，因为容器的意义就在于随用随丢。But, anyway, just follow your company or organization said.)

通过设置数据卷，我们可以将容器内的数据挂载到服务器目录下 (虽然也可以文件挂载，不过一般推荐目录挂载)。数据卷独立于容器，即使容器被关闭被删除，数据卷中的数据也会保留在服务器上而不是随之被销毁。

## How to use Docker?

以下提供了三种方式来使用 Docker，分别是在终端输入执行的 Docker command (最常用)，以及两个 Docker 配置方案，Dockerfile 和 Docker-Compose。下文会描述如何使用这些工具，但是不会提及具体的安装方式。

### Docker Command

我们最常用的流程是，

`拉取镜像[搜索镜像版本] -> 创建容器[相关配置指令] -> 管理容器[进入容器调试]`

[Docker-Hub](https://hub.docker.com/) 上有各种版本的应用镜像，这里以拉取 `mysql` 为例，在 Hub 上搜索 MySQL，

![image-20230426154515808](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202309241724143.png)

点击进入 MySQL 的官方镜像，

![image-20230426154616645](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202304261546750.png)

然后选择你需要的版本即可，在本地运行指令，

```shell
docker pull mysql:<version>
# 例如
docker pull mysql:latest	# 拉取最新版本
docker pull mysql:5.7		# 拉取 5.7 版本
# 感觉还在用 5.0+ 版本的应该不会用 Docker，XD
```

镜像便被拉取到本地了，你可以通过 Docker Desktop 查看你的镜像列表，

![image-20230426155217454](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202304261552566.png)

当然如果你嫌弃 GUI 应用缓慢的启动速度，那么更适合你的方式自然是优雅高效的终端指令，

```shell
docker image ls
# 示例
➜  project docker image ls
REPOSITORY                 TAG       IMAGE ID       CREATED        SIZE
jaegertracing/all-in-one   latest    1fc7df263d67   3 weeks ago    60.3MB
mysql                      latest    1fecb86b5237   3 weeks ago    530MB
rabbitmq                   latest    9492b0e4eea5   3 weeks ago    246MB
redis                      latest    31f08b90668e   4 weeks ago    117MB
prom/prometheus            latest    a07b618ecd1d   5 weeks ago    234MB
quay.io/coreos/etcd        v3.5.5    673f29d03de9   7 months ago   182MB
```

以下列出了其他击中常用的镜像管理的指令，

```shell
# 删除指定镜像
docker rmi [OPTIONS] IMAGE [IMAGE...]
Options:
  -f, --force 强制删除
# 搜索镜像，你不必一定要使用浏览器访问 Docker-Hub
docker search [OPTIONS] TERM
# 给镜像设置新的 Tag
docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
```

然后我们就该介绍关于容器管理的指令了，这些才是真正常用的。

#### run & rm

**run** 用于创建并启动一个容器，配置很多，但是现在不会用 Command 创建了，写的麻烦，主要以 Dockerfile 和 docker-compose 创建，创建方式见后文。

```shell
Usage: docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
Options:
  -d, --detach 后台运行容器，并输出容器ID
  -e, --env list 设置环境变量，该变量可以在容器内使用
  -h, --hostname string 指定容器的hostname
  -i, --interactive 以交互模式运行容器，通常与-t同时使用
  -l, --label list 给容器添加标签
  --name string 设置容器名称，否则会自动命名
  --network string 将容器加入指定网络
  -p, --publish list 设置容器映射端口
  -P,--publish-all 将容器设置的所有exposed端口进行随机映射
  --restart string 容器重启策略，默认为不重启
    on-failure[:max-retries]：在容器非正常退出时重启，可以设置重启次数。
    unless-stopped：总是重启，除非使用stop停止容器
    always：总是重启
  --rm 容器退出时则自动删除容器
  -t, --tty 分配一个伪终端
  -u, --user string 运行用户或者UID
  -v, --volume list 数据挂载
  -w, --workdir string 容器的工作目录
  --privileged 给容器特权
```

**rm**，即 remove，用于删除一个或多个容器

```shell
Usage: docker rm [OPTIONS] CONTAINER [CONTAINER...]
Options:
  -f, --force 强制删除
  -v, --volumes 同时删除数据卷
```

#### exec

向正在运行的容器下发命令，

```shell
Usage: docker exec [OPTIONS] CONTAINER COMMAND [ARG...]
Options:
    -d, --detach 在后台运行命令
    -e, --env list 设置环境变量
    -i, --interactive 以交互模式运行
    -t, --tty 分配一个伪终端
    -u, --user string 执行命令的用户
    -w, --workdir string 工作目录
# 假如你想要进入容器内，
docker exec -it <container_id> /bin/bash
# 该指令的意思是使用交互模式开启一个新的 bash 终端访问指定 id 的容器
```

#### start, stats, stop & restart

**start** 用于启动一个或多个容器，
**stats** 显示容器资源使用情况，
**stop** 用于停止一个或多个容器，
**restart** 用于重启一个或多个容器。

```shell
Usage: docker start [OPTIONS] CONTAINER [CONTAINER...]
Usage: docker stats [OPTIONS] [CONTAINER...]
Options:
  -a, --all 显示所有容器，默认只显示正在运行的容器
Usage: docker stop [OPTIONS] CONTAINER [CONTAINER...]
Usage: docker restart [OPTIONS] CONTAINER [CONTAINER...]
```



### Dockerfile

一个配置 Docker 镜像的文件

不想写了，看看我以前写的对付下 [Dockerfile 的简单使用 - Anxiu-Blog (anxiu0101.github.io)](https://anxiu0101.github.io/2022/07/30/dockerfile-的简单使用/)

补充一个 Docker Command 指令 `build`，作用是使用 Dockerfile 创建镜像。

```shell
Usage: docker build [OPTIONS] PATH | URL | -
Options:
    -f, --file string 指定Dockerfile，默认为当前路径的Dockerfile
    -q, --quiet 安静模式，构建成功后输出镜像ID
    -t, --tag list 给镜像设置tag，name:tag
# 示例
docker build # 一般来说在根目录啦，直接默认即可
```





有空再整理

### Docker-Compose

同样是配置 Docker 镜像的文件，但是它的不同在于，它同时是一组镜像的管理工具。在开发过程中，我们可能会使用多个 Docker 镜像，例如数据库，缓存，消息队列等等应用集成在一起。Docker-Compose 就是用户管理一组相关联的容器组。

它的配置文件名为 `docker-compose.yaml`，放在项目根目录下或是 `/deploy` 中，使用 `.yaml` 格式，相较来说可读性不错。(~~`.yaml` 就是异端，什么贵缩进要看半天，可读性比也只能跟 `.properties` 比，层级管理用缩进来表示的格式都是\*\*，~~`.toml` 才是未来！私货而已请不必在意)

它的使用十分便利，在写好 `docker-compose.yaml` 之后，你可以直接通过以下指令来使用它，

```sh
# 启动所有服务
$ docker-compose up
# 关闭所有服务
$ docker-compose stop
```



#### How to write a `docker-compose.yaml`?

拿一个 Redis 的镜像配置举例，

```yaml
version: '3'

services:

  # Redis
  redis:
    image: "redis:latest"
    restart: always
    ports:
      - "6379:6379"
    volumes:
      - /usr/local/redis:/var/lib/redis
    environment:
      - REDIS_PASSWORD=examplepwd
      - ALLOW_EMPTY_PASSWORD=no
```

这里有几个主要的配置项：

- `version` 指明 compose 的模板文件版本，`v2` 和 `v3` 都使用 `.yaml` 格式，但是语义上有一定区别 [创建应用 - Compose文件v3和v2版本的区别](https://www.bookstack.cn/read/docker-handbook/docs-compose_v2v3.md)
- `services` 下包含了所有容器，该层级下的每一个子层级都是一个服务，也就是一个容器。
- `image` 指定使用的模板镜像，这里使用的是 `redis` 的最新版本镜像
- `restrat` 设置 always 使得服务宕机后自动重启。
- `ports` 指定映射的端口号，意思是 `container` 内部端口和外部端口的映射关系，可以指定复数个端口映射。
- `volumes` 指定挂载的数据卷地址
- `environment` 一系列环境变量。使用 `key=value` 的形式编写。



编写完成后，你可以用 `docker-compose config` 进行配置文件的检查，

```shell
➜  deploy git:(master) docker-compose config --services
etcd
jaeger
mysql
prometheus
rabbitmq
redis

Usage: config [options]
Options:
  -q, --quiet 安静模式，不输出任何信息，除非文件错误
  --services 显示服务名称
  --volumes 显示挂载卷名称
# 这个命令不能指定yaml文件，默认为docker-compose.yaml或docker-compose.yml
```

当然 docker-compose 也提供了很多其他的指令，你可以看看[Docker 手册 - docker中文社区](https://www.docker.org.cn/docker/docker-206.html)的 `6.2` 部分。