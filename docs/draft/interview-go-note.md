---
title: 'Interview Go Note'
date: 2025-06-14 10:54:46
tags: [interview, golang]
published: false
comments: false
---

为 golang 工作准备的面试笔记。

<!--more-->

## Algorithm



三数之和

## Network Structure



### Network Protocol

#### TCP, UDP, HTTP



#### 三次握手



#### Websocket



### Network Security

#### TLS \& HTTPS





## Golang 语言基础



### 数据结构



#### Slice \& Array

[数组 · Go语言圣经](https://books.studygolang.com/gopl-zh/ch4/ch4-01.html)

[Slice · Go语言圣经](https://books.studygolang.com/gopl-zh/ch4/ch4-02.html)

#### 值拷贝 \& 引用拷贝

哪些数据结构是值拷贝，引用拷贝。



### GMP 模型与 Goroutine



#### 进程、线程、协程



### Golang Features



#### Generics 泛型



#### Interface 接口

!!! tip
	[Interface and Type Assertion in Golang - Anxiu's Note](https://anxiu0101.github.io/cs/lang/go/interface-in-go.html)
	[接口实现多态 | 你好](https://go.nsddd.top/markdown/12.html#接口概念)
	[接口是合约 · Go语言圣经](https://books.studygolang.com/gopl-zh/ch7/ch7-01.html)

接口只有当有两个或两个以上的具体类型必须以相同的方式进行处理时才需要。当一个接口只被一个单一的具体类型实现时有一个例外，就是由于它的依赖，这个具体类型不能和这个接口存在在一个相同的包中。这种情况下，一个接口是解耦这两个包的一个好方式。

接口是一个或多个方法签名的集合。
    任何类型的方法集中只要拥有该接口'对应的全部方法'签名。
    就表示它 "实现" 了该接口，无须在该类型上显式声明实现了哪个接口。
    这称为Structural Typing。
    所谓对应方法，是指有相同名称、参数列表 (不包括参数名) 以及返回值。
    当然，该类型还可以有其他方法。



> [!tip]
>
> 泛型出来之前是使用空接口 `interface{}` 来表示任意类型，因为空接口没有包含任何方法，因此所有类型都实现了空接口。但是现在使用 `any` 来完成类似的需求。

类型断言

什么场景使用 interface 进行抽象？具体例子

举一个AI开发的例子，多种不同的模型都需要相同的功能，传入options和连接配置发起请求即可。这个时候就可以通过接口来抽象出一个模型实体。

```go
type (
  GeneralModelConfig struct {
    modelname string
    provider string
  }
  
  OpenAILLMConn struct {
    model_conn GeneralModelConfig
    option OpenAIOption
  }
  
  XAILLMConn struct {
    model_conn GeneralModelConfig
    option XAIOption
  }
  
  QwenLLMConn struct {
    model_conn GeneralModelConfig
    option QwenOption
  }
  
  LLMConn interface {
    connect(GeneralModelConfig, options ...ModelOption)
  }
)
```



使用interface实现过什么功能？

#### Reflect 反射



## Data Storage



### MySQL



#### Session



### Redis Cache





### RAFT 分布式一致性



## Cloud Native



### Docker \& K8s







## Deployment

每个服务只部署一个实例吗



## System Design



### Design Pattern

## Personal Information

有没有用什么AI辅助编程
最近在读什么书

> [!cite]
>

