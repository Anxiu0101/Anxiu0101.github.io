---
title: 'Gorm 结构体定义时标签定义的相关记录'
date: 2022-08-28 10:59:05
tags: [Golang,Code]
published: true
hideInList: false
feature: 
isTop: false
---

> [[Go Web开发] 结构体序列化](https://www.jianshu.com/p/49198840449c)

为了对返回结果进行序列化，一般是定义一个序列化的结构体，然后进行返回。

但是如果合理利用 go 的结构体标签，可以更加简洁的进行序列化。

在定义结构体时候，通过使用omitempty可以控制对应字段在JSON中的可见性。当您不希望JSON输出中出现特定的结构体字段时，可以使用-(连字符)指令。这对包含和用户不相关的内部系统信息的字段或不想公开的敏感信息(如密码哈希值)非常有用。

> https://www.jianshu.com/p/49198840449c

即，如果字段与用户无关或不希望返回该字段，使用 `-` 使之完全不会被解析到 JSON 中。但是如果使用的是 `omitempty` 时，当这个字段值为空时，不解析该字段。 

如在一下用户结构体中，
```go
type User struct {
    ID string `gorm:"primarykey"; json:"id"`
    UserName string `json:"user_name"`
    Password string `json:"password,-"`
    Email string `json:email,omitempty`
}
```
Password 一定不会被返回，而 Email 字段仅在不为空的情况下会被解析为 JSON 的一部分。

另外标签还有一个用法，就是结构体标签 string 指令
例如
```go
type Movie struct {
    ID  int   `json:"id,omitempty,string"` 
}
```
返回示例 JSON，
```json
{
    "id": "123",
}
```

string 指令的作用是将结果以字符串的形式呈现，注意只对 int，uint，float 或 bool 类型的字段生效。
