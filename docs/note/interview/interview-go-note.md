---
title: 'Interview Go Note'
date: 2025-06-14 10:54:46
tags: []
published: false
comments: false
---

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

非常好的问题！在 Golang 中，**数组（Array）** 和 **切片（Slice）** 是两个紧密相关但有本质区别的数据结构，理解它们对于掌握 Go 的内存模型、性能优化至关重要。

---

 ✅ 数组（Array）

 定义：

Go 中的数组是 **固定长度**、**同质类型元素的集合**。

```go
var a [3]int = [3]int{1, 2, 3}
```

 特点：

* 长度是数组类型的一部分，`[3]int` 和 `[4]int` 是不同的类型。
* 元素在内存中是 **连续分布** 的。
* 是 **值类型**，赋值或作为参数传递时是 **拷贝整个数组**（除非使用指针）。

 示例：

```go
func changeArray(arr [3]int) {
    arr[0] = 100
}

func main() {
    a := [3]int{1, 2, 3}
    changeArray(a)
    fmt.Println(a) // 输出 [1 2 3]，未改变
}
```

---

 ✅ 切片（Slice）

 定义：

切片是一个对数组的**轻量级抽象**，包括：

* 指针（指向底层数组的元素）
* 长度（slice当前长度）
* 容量（从指针起始位置到底层数组结尾的容量）

```go
s := []int{1, 2, 3} // 底层创建一个数组
```

 特点：

* 是 **引用类型**，传参时会 **共享底层数组**。
* 可以动态增长（使用 `append`）。
* 底层是数组，但你通常不直接操作底层数组。
* 更加灵活和强大，是 Go 中使用最广泛的序列类型。

 示例：

```go
func changeSlice(s []int) {
    s[0] = 100
}

func main() {
    s := []int{1, 2, 3}
    changeSlice(s)
    fmt.Println(s) // 输出 [100 2 3]，改变了
}
```

---

 ✅ 数组 vs 切片：区别一览表

| 特性     | 数组 Array    | 切片 Slice         |
| ------ | ----------- | ---------------- |
| 是否固定长度 | ✅ 是         | ❌ 否，可动态扩展        |
| 是否是值类型 | ✅ 是（值拷贝）    | ❌ 否（引用底层数组）      |
| 是否可变长  | ❌ 否         | ✅ 是（通过 `append`） |
| 使用场景   | 对性能、内存可控要求高 | 日常开发、灵活处理集合类型    |
| 类型定义   | `[3]int`    | `[]int`          |
| 内存分配   | 编译期确定       | 运行期动态分配          |

---

 ✅ 适用场景

| 类型     | 推荐使用场景                                                 |
| ------ | ------------------------------------------------------ |
| **数组** | 系统底层开发、需要确定性行为（如嵌入式、网络协议 buffer）或作为固定结构（例如 `[32]byte`） |
| **切片** | 大多数业务逻辑场景，如集合处理、数据转换、排序、过滤等；推荐作为函数参数类型                 |

---

 🔄 Go 1.17+ 优化（值得了解）

自 Go 1.17 起，Go 编译器对小数组参数传递做了优化，**小数组可能通过寄存器传递**，性能成本降低。但在语义上仍然是值拷贝，**使用场景需注意不可变性**。

---

如需我提供例子、图示 slice 和 array 的内存布局，或者源码实现（例如 `reflect.SliceHeader`），也可以继续问我。是否需要？




#### 值拷贝 \& 引用拷贝

哪些数据结构是值拷贝，引用拷贝。



### GMP 模型与 Goroutine



#### 进程、线程、协程



### Golang Features



#### Generics 泛型



#### Interface 接口





## Data Storage



### MySQL



#### Session



### Redis Cache



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

