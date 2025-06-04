---
title: 'Golang 使用腾讯云短信服务'
date: 2022-09-12 01:40:56
tags: [Golang,Tool,Code]
published: true
hideInList: false
feature: 
isTop: false
---
因为遇到了一个需要短信验证码服务的需求，所以使用了一下腾讯云的短信服务。这里进行一些简单的记录。

<!--more-->

开发中遇到了一个需要使用短信验证码的服务需求，这里使用了腾讯云的短信服务，Go 版本为 1.18

首先要先开通腾讯云的短信服务，相当于一个专门用于发送短信的服务器。

![image-20220914125844802](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209141258887.png)

一共涉及到两个接口，分别是 `SendVerificationCode()` `CheckVerificationCode()`

- 客户端先通过 `SendVerificationCode()` API 要求服务端使用 SMS 服务向用户手机发送验证码
- 服务端生成随机验证码，并将该验证码和用户手机号码存入缓存，
- 通过 Tencent SDK Go 向 SMS 发送包含随机验证码和用户手机号码的短信发送请求
- SMS 向用户发送短信并给服务端响应
- 客户端通过 `CheckVerificationCode()` API 向服务器发送用户获取到的验证码。
- 服务端检查验证码，通过后提供服务。

这里我是通过引入腾讯云的 Go SDK 来进行 SMS(Short Message Service) 业务的使用。需要引入，

```go
import (
	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common"
	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common/errors"
	"github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/common/profile"
	sms "github.com/tencentcloud/tencentcloud-sdk-go/tencentcloud/sms/v20210111"
)
```

> [短信 Go SDK-SDK 文档-文档中心-腾讯云 (tencent.com)](https://cloud.tencent.com/document/product/382/43199)

SMS 服务需要几个参数，
```yaml
sms:
  secret-key:  #秘钥，可在控制台查询
  secret-id:  #秘钥id ,可在控制台查询
  sms-sdk-app-id:  #应用id
  sign-name:  #申请的签名
  template-id:  #模板id
```

`SecretId`、`SecretKey` 查询地址：https://console.cloud.tencent.com/cam/capi

应用 ID 可前往 [短信控制台](https://console.cloud.tencent.com/smsv2/app-manage) 查看

短信签名内容: 使用 UTF-8 编码，必须填写已审核通过的签名，签名信息可前往 [国内短信](https://console.cloud.tencent.com/smsv2/csms-sign) 查看

模板 ID: 必须填写已审核通过的模板 ID，模板 ID 可前往 [国内短信](https://console.cloud.tencent.com/smsv2/csms-template) 查看

下发手机号码，采用 E.164 标准，`+[国家或地区码][手机号]` 示例如：+8613711112222， 其中前面有一个+号 ，86为国家码，13711112222为手机号，最多不要超过200个手机号



在开发期间建议将 Send Message 的 response 打印出来，例如以下

```go
response, err := sendClient.SendSms(s.Request.request)
if _, ok := err.(*errors.TencentCloudSDKError); ok {
    LogrusObj.Warnf("An API error has returned: %s", err)
    return false
}
if err != nil {
    LogrusObj.Warnf("发送短信失败:%s,requestId:%s", err)
    return false
}
b, _ := json.Marshal(response.Response)
```

有很大一部分错误通过打印 `response.Response` 可以更快的找到问题。
