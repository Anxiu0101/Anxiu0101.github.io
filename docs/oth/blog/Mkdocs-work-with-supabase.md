[![Made with Supabase](https://supabase.com/badge-made-with-supabase.svg)](https://supabase.com)

这是一个在 `mkdocs` 站点使用 `supabase` 构建个性化功能的实践记录。

我希望通过 `supabase` 建立一个多人合作维护的 `mkdocs` 站点，任何访问网站的人都可以通过站点提供的可视化按钮去进行个人贡献。

大致思路

贡献者在网站上传 markdown，文件被 `supabase` 存入数据库中并进入审核状态，触发邮箱提示，向贡献者发送邮件提示。在此之后，审核人员进行审核和格式修饰，然后完成发布，发布成功向贡献者发送邮件提示。

这里面需要使用的技术包括邮件系统，需要做对邮件协议的支持(或者直接企业邮箱自定义域名实现)。但是需要做的细节还是有很多的。

`supabase` 开源，可以本地化这是最好的一点。自己用 docker 再包一层就可以拿来提供服务，或者直接开源出来。

在这个过程中，储存这些数据有几种方案，一个是依赖数据库，存入用户信息，以及文档信息。但是我更想用数据库低依赖或无依赖的方案，将大部分数据写入到 markdown meta 之中。

```yaml
title: default
author: name <email@example.com>
create_at: 2006-01-02 15:04:06
update_at: 2006-01-02 15:04:06
state: public/draft/reject
category: (single option in GUI.)
tags: 
  - domain
  - master?phd?...
  - cost?life-experience?research-experience? ...
License: MIT for example.
```

contact user 这个还是通过使用数据库的方式进行，做个 key map 就行，或者说工作量大一点图标附上然后做个表单，并且不想做 SSO 太重了。

然后还想模范 hexo 的那个 fluid 做一个 License Card。