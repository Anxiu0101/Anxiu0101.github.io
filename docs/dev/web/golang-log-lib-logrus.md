---
title: 'Using and setup logrus lib to your go web project'
date: 2023-12-04 07:39:27
tags: [Code,Golang]
published: true
hideInList: false
feature: /post-images/
isTop: false
---









这是我个人 logrus 的一个自定义配置，放在自己的模板仓库里，写一些小项目的时候用的比较顺手。

`logrus` is a structured logger for Go (golang), completely API compatible with the standard library logger.

logrus 的日志级别包括：

。。。



JSON format output

Text format output setting

page split.



# 通过 Hook 实现行号记录

[Golang日志之logrus的使用 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/375086909)

[关于收集，标准化和集中化处理Golang日志的一些建议 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/115342221)
[Golang日志之logrus的使用 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/375086909)
[sirupsen/logrus: Structured, pluggable logging for Go. (github.com)](https://github.com/sirupsen/logrus)

# 通过中间件增加自定义字段



```go
// LoggerMiddleware Log with important fields.
func LoggerMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {

		startTime := time.Now()
		// Call the remaining handlers for this request
		c.Next()
		stopTime := time.Since(startTime)
		spendTime := fmt.Sprintf("%d ms", int(math.Ceil(float64(stopTime.Nanoseconds()/1000000))))

		statusCode := c.Writer.Status()
		dataSize := c.Writer.Size()
		if dataSize < 0 {
			dataSize = 0
		}
		method := c.Request.Method
		uri := c.Request.RequestURI

		Log := logger.Logger.WithFields(logrus.Fields{
			"spend_time": spendTime,
			"path":       uri,
			"method":     method,
			"status":     statusCode,
		})

		// create inner error
		if len(c.Errors) > 0 {
			Log.Error(c.Errors.ByType(gin.ErrorTypePrivate))
		}
		if statusCode >= errno.Error {
			Log.Error()
		} else if statusCode >= errno.InvalidParams {
			Log.Warn()
		} else {
			Log.Info()
		}

	}
}
```





## 颜色打印

[控制台终端输出颜色 - opangle - 博客园 (cnblogs.com)](https://www.cnblogs.com/opangle/p/4082692.html)
