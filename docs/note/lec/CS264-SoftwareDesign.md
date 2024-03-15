---
title: 'CS264-SoftwareDesign'
date: 2022-09-02 13:24:56
tags: [Design Pattern]
categories: [Note]
published: true
hideInList: false
feature: 
isTop: false
---

# 前言

> 推荐的博客
>
> [常用设计模式有哪些？ (refactoringguru.cn)](https://refactoringguru.cn/design-patterns)
> [Go设计模式24-总结(更新完毕) - Mohuishou (lailin.xyz)](https://lailin.xyz/post/go-design-pattern.html)
>
> 代码仓库
>
> 



# 创建型模式



---

## 单例模式

一个类只允许创建一个对象或者叫实例，那这个类就是一个单例类，这种设计模式就是单例模式。从业务概念上，有些数据在系统中只应该保存一份，就比较适合设计为单例类，例如日志对象。

![image-20220902134457612](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209021344834.png)

单例模式需要保证实例的唯一性，就是保证该实例在进程间唯一。
想要保证实例在进程间唯一，在 Java 中可以通过获取线程 id 的方式来完成，但是 Golang 中无法使用，go 协程并未暴露线程 id。
另外，如果想要实现集群环境之间唯一，就要通过外部共享存储的锁进行。

**如何实现单例模式？**

> 首先要考虑以下几个问题，
>
> - 构造函数是 private 访问权限
> - 考虑对象创建时的线程安全问题
> - 考虑是否支持延迟加载
> - 考虑 `GetInstance()` 方法的性能问题 (是否有加锁等)

具体实现分为以下几种方法，

### 饿汉式 Eager Initialization

通过在结构体被加载时便为结构体创建一个实例，然后禁用构造方法(例如将构造方法标记为 `private` 权限)，在其他函数需要该类型时，用 `GetInstance()` 方法替代构造方法提供对象。

```go
package singletonPattern

var Instance *object

func init() {
	Instance = &object{}
}

// 小写开头，将需要应用单例模式的类型的权限设置为包外不可见
type object struct {
	name string
}

func (o *object) SetName(name string) {
	o.name = name
}

func (o *object) Hello() {
	println("Object Name:", o.name)
}

// 创建获取实例的方法向包外暴露
func GetInstance() *object {
	if Instance == nil {
		Instance = new(object)
	}
	return Instance
}
```



测试运行

```go
package main

import "GolangDesignPattern/singletonPattern"

func main() {
	singletonPattern.Instance.SetName("Anxiu")
	singletonPattern.Instance.Hello()
}
```

运行结果

```shell
Object Name: Anxiu
```



### 懒汉式 Lazy Initialization

懒汉式也成为延迟加载式，就是不在引入包时执行单实例的创建，但是当外部代码访问 `GetInstance()` 方法时，如果没有实例则创建实例，如果实例存在则返回实例对象。但是懒汉式由于需要在运行时进行创建，就不免要面对多线程的问题，需要加锁。

```go
package singleton

import "sync"

var (
	lazyObj		  *object
	once          = &sync.Once{}
)

// GetLazyInstance 懒汉式获取实例
func GetLazyInstance() *object {
	if lazyObj == nil {
		once.Do(func() {
			lazyObj = &object{}
		})
	}
	return lazyObj
}
```



还有一种 Java 特定的创建方法，需要通过在类之内再写一个静态内部类，将变量声明在这个静态内部类中。当项目启动时，不会直接创建这个变量，但是调用时，触发对内部类的初始化，将其创建，则完成对于单实例的创建。

---



---

## 原型模式

定义：利用已有对象 (原型) 进行复制 (拷贝) 的方式来创建新对象，以达到节省创建时间的目的。

使用场景：当对象的创建成本较大，并且同一个类的不同对象之间差别不大 (大部分字段内容相同)。

> 对象的创建成本较大，指的是对象数据需要经过复杂的计算，排序 hash 等；或是需要从 rpc、网络、数据库等较慢的 io 中获得。

实现方式有两种类型，分别是**浅拷贝**和**深拷贝**。

- **浅拷贝**

  仅复制对象的引用，不进行递归复制。如果字段是一个地址，那么复制的对象，将和源对象共享相同的数据；如果字段对应的是可变对象，那么复制的对象的改动会导致原来对象的改动；如果字段对应的是不可变字段，则正常。

- **深拷贝**

  完全复制，复制出的对象和原本的对象没有关系。可以通过==递归复制==或==序列化与反序列化==的方式实现。

### 浅拷贝

```go
```



### 深拷贝

```go
```



**实例**

这是一段关于文档模板的代码，Doc Management 管理所有的模板样本，拥有一个名为 `GetOffialDocument(string) OfficialDocument` 的方法。该方法可以通过传入的文档类型字符串返回符合要求的文档实例，这个文档实例是通过 `clone` 方法复制出来的，内容与 Doc Management 中所对应的模板相符。而 `Clone()` 方法在此的具体实现是通过序列化与反序列化的方法达成的。

```go
package prototype

var DocManger = DocManagement{
	farSample: FAR{Content: "This is a FAR Doc"},
	srsSample: SRS{Content: "This is a SRS Doc"},
}

type DocManagement struct {
	farSample FAR
	srsSample SRS
}

func (m DocManagement) GetOfficialDocument(docType string) OfficialDocumentFormer {
	switch docType {
	case "far":
		return m.farSample.Clone()
	case "srs":
		return m.srsSample.Clone()
	default:
		return nil
	}
}

type OfficialDocumentFormer interface {
	Clone() OfficialDocumentFormer
	Display()
}

type FAR struct {
	Content string
}

func (f FAR) Clone() OfficialDocumentFormer {
	var newFAR FAR
	d, _ := json.Marshal(f)
	_ = json.Unmarshal(d, &newFAR)
	newFAR.Display()
	return newFAR
}

func (f FAR) Display() {
	println("==== FAR Doc ====")
	fmt.Printf("%+v\n", f)
	println("==== FAR Doc ====")
}

type SRS struct {
	Content string
}

func (s SRS) Clone() OfficialDocumentFormer {
	var newSRS SRS
	d, _ := json.Marshal(s)
	_ = json.Unmarshal(d, &newSRS)
	newSRS.Display()
	return newSRS
}

func (s SRS) Display() {
	println("==== SRS Doc ====")
	fmt.Printf("%+v\n", s)
	println("==== SRS Doc ====")
}
```



**测试程序**

```go
func TestDocManagement_GetOfficialDocument(t *testing.T) {
	type fields struct {
		farSample FAR
		srsSample SRS
	}
	type args struct {
		docType string
	}
	tests := []struct {
		name   string
		fields fields
		args   args
		want   OfficialDocumentFormer
	}{
		// TODO: Add test cases.
		{
			name:   "far test",
			fields: fields{
				farSample: DocManger.farSample, 
				srsSample: DocManger.srsSample,
			},
			args:   args{docType: "far"},
			want:   FAR{Content: "This is a FAR Doc"},
		},
		{
			name:   "srs test",
			fields: fields{
				farSample: DocManger.farSample,
				srsSample: DocManger.srsSample,
			},
			args:   args{docType: "srs"},
			want:   SRS{Content: "This is a SRS Doc"},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			m := DocManagement{
				farSample: tt.fields.farSample,
				srsSample: tt.fields.srsSample,
			}
			if got := m.GetOfficialDocument(tt.args.docType); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("GetOfficialDocument() = %v, want %v", got, tt.want)
			}
		})
	}
}

```



**运行结果**

```shell
=== RUN   TestDocManagement_GetOfficialDocument
=== RUN   TestDocManagement_GetOfficialDocument/far_test
==== FAR Doc ====
{Content:This is a FAR Doc}
==== FAR Doc ====
=== RUN   TestDocManagement_GetOfficialDocument/srs_test
==== SRS Doc ====
{Content:This is a SRS Doc}
==== SRS Doc ====
--- PASS: TestDocManagement_GetOfficialDocument (0.00s)
    --- PASS: TestDocManagement_GetOfficialDocument/far_test (0.00s)
    --- PASS: TestDocManagement_GetOfficialDocument/srs_test (0.00s)
PASS
```



---



## 生成器模式

Builder model，中文的话我更愿意称之为生成器模式，相较于建造者模式，生成器模式更加直观。在我的理解中，生成器模式是应用在一个可以拆分成多个组件的对象上。这个对象有很多可选组件，所以使用构造函数构建会较为冗余，就应该使用生成器模式。





## 工厂模式

工厂模式的意义在于，将原本耦合的代码整理出来，创建实例的过程依然是通过 `new()` 方法，但是这个过程发生在工厂中，就不会影响到原本的代码中，如果要新增其他实例的生成，可以将该实例接入到工厂之中，工厂外的实例不受影响。这对于可维护性的提高是很有意义的。







# 





## 备忘录模式

Java 的深拷贝和浅拷贝



## 状态模式

讲到和策略模式的区别是，状态模式是否也可以拥有多个操控对象？

例如那个买票的例子，就可以将这下状态复用到多种票类型，比如火车票，飞机票，当然如果不同票在同一状态的折扣是不同的情况下，还是用策略模式好一点。
