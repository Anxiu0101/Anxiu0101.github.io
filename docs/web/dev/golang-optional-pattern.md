---
title: 'GOLANG-选项模式'
date: 2022-07-08 01:06:27
tags: [Code,Golang]
published: true
hideInList: false
feature: /post-images/Golang-选项器模式.png
isTop: false
---

函数选项器模式是 Go 开发中经常使用的一种方式，可以更加便捷地整合配置信息，适用于可选项配置中。
<!--more-->

## 初遇函数式选项模式

第一次在应用中接触到 go 的选项模式是在 gRPC 入门学习时，开启 gRPC 服务端和客户端时使用的 `grpc.ServerOption` 以及 `grpc.DialOption` 这两个选项。

> The Go (Golang) Functiona Options Pattern is a way, a pattern of structuring your structs in Go by designing a very expressive and flexible set of APIs that will help with the configuration and initialisation of your struct.
> Go 函数式选项模式 是一种在 Go 中构建结构的模式，它通过设计一组非常富有表现力和灵活的 API 来帮助配置和初始化结构
> 来自：[Golang Functional Options Pattern | Golang Cafe](https://golang.cafe/blog/golang-functional-options-pattern.html)

这是我在使用 `grpc.ServerOption` 时的代码片段，

```go
var opts []grpc.ServerOption

// 使用证书文件和密钥文件为服务端构造 TLS 凭证
certs, err := credentials.NewServerTLSFromFile("../certs/memo.pem", "../certs/memo.key")
if err != nil {
    log.Printf("Failed to generate credentials %v", err)
}

opts = append(opts, grpc.Creds(certs))

// 使用一元拦截器（grpc.UnaryInterceptor），验证请求
var interceptor grpc.UnaryServerInterceptor = func(ctx context.Context, req interface{}, info *grpc.UnaryServerInfo, handler grpc.UnaryHandler) (resp interface{}, err error) {
    // 拦截普通方法请求，验证 Token
    log.Println("filter:", info)
    username, err := service.CheckAuthority(ctx)
    if err != nil {
        log.Fatalf("interceptor err: %v", err)
        return nil, err
    } else {
        log.Printf("%v pass Authority", username)
    }
    // 继续处理请求
    return handler(ctx, req)
}

opts = append(opts, grpc.UnaryInterceptor(interceptor))

// 创建新 grpc 服务
server := grpc.NewServer(opts...)
```

可以看到我新建了一个服务器选项切片 ==ServerOption Slice==，在每次调取函数设置选项后将选项插入到选项切片中，并在最后创建 gRPC 服务时传入该选项切片。

这样使得代码结构可读性更高。

## 选项模式结构

看以下来自 [Golang Functional Options Pattern | Golang Cafe](https://golang.cafe/blog/golang-functional-options-pattern.html) 中的代码，

我们首先为 Server 创建一个构造函数，函数参数为不定参数类型的 Server 方法函数，返回一个 Server 类型的指针。然后为 Server 的字段建立名为 `Withxxx` 的函数

> 参考了 [Option pattern of common design patterns in Golang](https://segmentfault.com/a/1190000041262739/en)

```go
package server

import (
    "errors"
    "log"
    "time"
)

const (
    defaultHost    = "127.0.0.1"
    defaultPort    = 8000
    defaultTimeout = time.Minute
    defaultMaxConn = 120
)

type Server struct {
    Host    string
    Port    int
    Timeout time.Duration
    MaxConn int
}

// All server attribute can edit
type ServerOptions struct {
    Host    string
    Port    int
    Timeout time.Duration
    MaxConn int
}

type ServerOption interface {
    apply(*ServerOptions)
}

type funcServerOption struct {
    f func(*ServerOptions)
}

func (fo funcServerOption) apply(option *ServerOptions) {
    fo.f(option)
}

func newFuncServerOption(f func(*ServerOptions)) *funcServerOption {
    return &funcServerOption{
        f: f,
    }
}

// All Withxx function to edit option
func WithHost(host string) ServerOption {
    return newFuncServerOption(func(option *ServerOptions) {
        option.Host = host
    })
}

func WithPort(port int) ServerOption {
    return newFuncServerOption(func(option *ServerOptions) {
        option.Port = port
    })
}

func WithTimeout(timeout time.Duration) ServerOption {
    return newFuncServerOption(func(option *ServerOptions) {
        option.Timeout = timeout
    })
}

func WithMaxConn(maxConn int) ServerOption {
    return newFuncServerOption(func(option *ServerOptions) {
        option.MaxConn = maxConn
    })
}

// Create New Object with option parameters
func NewServer(opts ...ServerOption) *Server {
    options := ServerOptions{
        Host:    defaultHost,
        Port:    defaultPort,
        Timeout: defaultTimeout,
        MaxConn: defaultMaxConn,
    }

    for _, opt := range opts {
        opt.apply(&options)
    }

    return &Server{
        Host:    defaultHost,
        Port:    defaultPort,
        Timeout: defaultTimeout,
        MaxConn: defaultMaxConn,
    }
}

func (s *Server) Start() error {
    log.Printf("Server: %v", s)
    return errors.New("Error")
}
```

![image-20220615113124817](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202206151131934.png)

```go
package main

import (
    "log"
    "time"

    "example.com/server"
)

func main() {
    // Init options
    var opts []server.ServerOption

    // Add options
    opts = append(opts, server.WithHost("localhost"))
    opts = append(opts, server.WithPort(8081))
    opts = append(opts, server.WithTimeout(time.Minute))
    opts = append(opts, server.WithMaxConn(120))

    // Create Object
    svr := server.NewServer(opts...)
    if err := svr.Start(); err != nil {
        log.Fatal(err)
    }
}
```

我们定义 `ServerOptions` 结构来配置默认参数。因为这几个字段有默认参数，所以 `ServerOptions` 的定义与 `Server` 的定义相同。但是，==结构中可能存在一些具有一定复杂性的参数没有默认参数==，==必须由用户配置==。这时候 `ServerOptions` 中的字段会比较少，可以根据需要定义。

同时，我们还定义了一个 `ServerOption` 接口和一个实现该接口的 `FuncServerOption` 结构。它们的作用是允许我们通过 `apply` 方法为 `ServerOptions` 结构单独配置一个参数。

我们可以为每个默认参数定义一个 `WithXXX` 函数来配置参数，比如这里定义的 `WithHost` 和 `WithPort`，这样用户就可以通过调用 `WithXXX` 函数来自定义需要覆盖的默认参数。

这时候在构造函数 `NewServer` 中定义了默认参数。构造函数接收一个变长参数，类型为 `ServerOption`。在构造函数内部，通过for循环调用每个传入的 `ServerOption` 对象的apply方法，将用户配置的参数依次赋值给构造函数内部的默认参数对象 options，替换默认参数。执行完 for 循环后，得到的 options 对象就是最终的配置。依次将其属性分配给 Server 以生成新对象。

## Attachment

```shell
├─server
│  └─server.go
└─main.go
```

### server.go

```go
package server

import (
    "errors"
    "log"
    "time"
)

const (
    defaultHost    = "127.0.0.1"
    defaultPort    = 8000
    defaultTimeout = time.Minute
    defaultMaxConn = 120
)

type Server struct {
    Host    string
    Port    int
    Timeout time.Duration
    MaxConn int
}

type ServerOptions struct {
    Host    string
    Port    int
    Timeout time.Duration
    MaxConn int
}

type ServerOption interface {
    apply(*ServerOptions)
}

type funcServerOption struct {
    f func(*ServerOptions)
}

func (fo funcServerOption) apply(option *ServerOptions) {
    fo.f(option)
}

func newFuncServerOption(f func(*ServerOptions)) *funcServerOption {
    return &funcServerOption{
        f: f,
    }
}

func WithHost(host string) ServerOption {
    return newFuncServerOption(func(option *ServerOptions) {
        option.Host = host
    })
}

func WithPort(port int) ServerOption {
    return newFuncServerOption(func(option *ServerOptions) {
        option.Port = port
    })
}

func WithTimeout(timeout time.Duration) ServerOption {
    return newFuncServerOption(func(option *ServerOptions) {
        option.Timeout = timeout
    })
}

func WithMaxConn(maxConn int) ServerOption {
    return newFuncServerOption(func(option *ServerOptions) {
        option.MaxConn = maxConn
    })
}

func NewServer(opts ...ServerOption) *Server {
    options := ServerOptions{
        Host:    defaultHost,
        Port:    defaultPort,
        Timeout: defaultTimeout,
        MaxConn: defaultMaxConn,
    }

    for _, opt := range opts {
        opt.apply(&options)
    }

    return &Server{
        Host:    defaultHost,
        Port:    defaultPort,
        Timeout: defaultTimeout,
        MaxConn: defaultMaxConn,
    }
}

func (s *Server) Start() error {
    log.Printf("Server: %v", s)
    return errors.New("Error")
}
```

### main.go

```go
package main  

import (  
   "GoSketch/OptionPattern/server"  
   "log"   "time")  

func main() {  
   var opts []server.ServerOption  

   opts = append(opts, server.WithHost("localhost"))  
   opts = append(opts, server.WithPort(8081))  
   opts = append(opts, server.WithTimeout(time.Minute))  
   opts = append(opts, server.WithMaxConn(120))  

   svr := server.NewServer(opts...)  
   if err := svr.Start(); err != nil {  
      log.Fatal(err)  
   }  
}
```
