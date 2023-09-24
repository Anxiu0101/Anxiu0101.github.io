---
title: 'Interface and Type Assertion in Golang'
date: 2022-08-06 15:52:18
tags: [Code,Golang]
published: true
---
本文用于记录 Go 语言的接口机制和断言机制
<!--more-->

## Interface 接口

Go 语言是一门鸭子类型的语言，没有类似于 Java 一样的 `implements` 关键字，而是在编译期间隐式指定。只要一个结构体能够想鸭子一样跑，像鸭子一样叫，那这个结构体就是鸭子。

## Type Assertion 类型断言

类型断言（Type Assertion）是一个使用在接口值上的操作，用于检查接口类型变量所持有的值是否实现了期望的接口或者具体的类型。

## 开发中遇到的简单例子

我们有三种 `user`，分别为 `teacher` `studnet` `parent`，让这三种用户都实现 `user` 接口，就能进行类似泛型的使用。

时至今日，还是不敢让泛型上开发环境，继续观望一下

```go
// 根据路由查询用户
switch userType {
    case "student":
    user, err = model.QueryStuDataByID(service.UID)
    data = model.BuildStu(user.(*model.Student))
    case "teacher":
    user, err = model.QueryTchDataByID(service.UID)
    data = model.BuildTch(user.(*model.Teacher))
    case "parent":
    user, err = model.QueryParDataByName(service.UserName)
    data = model.BuildPar(user.(*model.Parent))
    default:
    return Response{
        Status: e.InvalidParams,
        Msg:    "不存在此类型成员",
    }
}
```

不知道我这样的写法正不正常，仅作记录

### 需要注意的点

定义接口后，

```go
type User interface {
    SetPassword(string) error
	CheckPassword(string) bool
}

type Teacher struct {}

//SetPassword 设置密码，实现 user 接口
func (tch *Teacher) SetPassword(password string) error {
	bytes, err := bcrypt.GenerateFromPassword([]byte(password), PassWordCost)
	if err != nil {
		return err
	}
	tch.Password = string(bytes)
	return nil
}

//CheckPassword 校验密码，实现 user 接口
func (tch *Teacher) CheckPassword(password string) bool {
	err := bcrypt.CompareHashAndPassword([]byte(tch.Password), []byte(password))
	return err == nil
}
```

如果像以上，方法接受者使用的是指针类型，由于该类型的方法只能被该结构体的指针类型调用，故 User 接口只对此结构体的指针生效。可以通过以下方法进行类型断言，即判断该对象是否符合接口的指针类型

```go
user, err = model.QueryParDataByName(service.UserName)
data = model.BuildPar(user.(*model.Parent))
```



但是如果方法接收者是一个结构体，则该结构是同时实现了接口类型和接口指针类型，就没有以上类型判断的限制，以下两种方法都可以，不过返回的结果一个是 Parent 类型，一个是 Parent 指针类型。

```go
data = model.BuildPar(user.(model.Parent))
data = model.BuildPar(user.(*model.Parent))
```

