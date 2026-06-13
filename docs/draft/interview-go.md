---
title: 'Interview Go'
date: 2025-06-10 04:34:03
tags: []
published: false
comments: false
---

<!--more-->

## References

91 【后端实习什么算有产出？ - 应届生牛可乐 | 小红书 - 你的生活指南】 😆 dP1VmCRwWFBmE0I 😆 https://www.xiaohongshu.com/discovery/item/68359c0c000000002100a176?source=webshare&xhsshare=pc_web&xsec_token=ABvTRnWPNIhBhx3TR6D5FEILiqpN2jQJkBT3khUouB07k=&xsec_source=pc_share

---
16 【golang实习面经 小厂 - 今天奶茶了么 | 小红书 - 你的生活指南】 😆 PLEKWsy8CMHMyJH 😆 https://www.xiaohongshu.com/discovery/item/681c168700000000230020ba?source=webshare&xhsshare=pc_web&xsec_token=ABJZS08Lp-xXxaM_eUqREw3lQ1KaDcIOc0vV2eC14I32U=&xsec_source=pc_share

1. 项目一拷打（不用Websocket可以改用什么 http轮询 Channel Goroutine 高并发场景设计）
2. Docker命令，容器调度，如何打包
3. mysql主从复制、联合索引、InnoDB的索引结构、InnoDB（支持事务）和MyslAM的区别、sql优化方法
4. Typesrcipt 和 javascript的区别
5. Kafka、RabbitMQ 的使用和场景
6. Nginx的负载均衡、反向代理如何实现
7. 操作系统零拷贝
8. Redis缓存、分布式锁、持久化机制
9. 看你简历写了Vue，讲一下Vue做的项目二吧（拷打了几分钟 给面试官展示项目网站成品）

---
65 【字节实习golang后端-国际商务部一面 - 风止意难平 | 小红书 - 你的生活指南】 😆 9RbAJgKmO4Yi8yp 😆 https://www.xiaohongshu.com/discovery/item/68389c900000000022007a3b?source=webshare&xhsshare=pc_web&xsec_token=ABk1qDS3GlFxrCksQrioBzvOMvlg273mC-fNhxKCCSlqs=&xsec_source=pc_share
1.介绍一下自己和项目
2.问了mysql里面大数据分页查询商品的这么一个场景
自己说了给商品详情设立一个二级索引，然后查到具体数据再做回表，面试官引导应该先分页（这个忘了，的确应该这么做，简单实用）。
结合面试官和我的思路最终解答
3.gc内存回收的里面的三色标记法和混合写屏障，但是只说到了三色标记法，混合写屏障被叫停了，可能这个go1.18才引入的。（另一家也问了）
接着问标记过程中哪些是根对象
全局对象，栈上的局部变量，后面想不到了
4.说了内存逃逸
反射逃逸，指针逃逸，变量过大逃逸
5.算法是最长公共子序列

---
82 【字节实习golang后端-二面已oc - 风止意难平 | 小红书 - 你的生活指南】 😆 lPAH2gWY49ydVRV 😆 https://www.xiaohongshu.com/discovery/item/6838a6d3000000002102cb91?source=webshare&xhsshare=pc_web&xsec_token=ABk1qDS3GlFxrCksQrioBzvEspuRU0rgMrBb0gM9ZBPqs=&xsec_source=pc_share

1.问你觉得项目里面那些是你的难点❓
用户注册，商品添加购物车这个过程的步骤，鉴权等过程
2.还有呢❓
商城系统里面表的设计，商品，商品分类，商品规格包装，商品类型，商品类型属性，在这个过程中表的设计中有一对一，一对多，多对一，自关联，这些在商品增删改过程，需要注意的地方。
3.还有呢❓
说了如何解决一面中的大量数据分页查询，深查询优化，面试官能看到一面面评，说这个之前问过了。（尴尬了）
3.还有呢❓
这时候结合商城这个场景说了如何解决Redis和MySQL缓存保持一致的方案。
两种方案（应该有三种，第三种我忘了）
第二种用到了消息队列
	
4.开始问消息队列的场景，优势，展开讲一下
商品秒杀系统的应用
生产，消费者解耦，异步通知，流量削峰
	
5.哪些场景不能用
实时性要求高的场景
	
6.问我还会那些语言-java
go语言和Java优势
	
java运行时依赖JVM，java线程相对goroutine处理高并发场景性能还是较差。
go语言中依赖包自带goruntime 会自动将程序生成当前平台的可执行文件
go有goroutine轻量级，goroutine相对于线程，天然有并发优势，这里又讲述了一下gmp模型，讲了一下hand off机制(当时忘了这个叫啥了)，没讲到work stealing,面试官就ok打断了
	
7.问了使用过哪些中间件，底层实现逻辑
一开始说项目中用户登录或者管理员登录的
鉴权中间件（面试官都笑了）
后面说了gin框架里面的logger（笑死）
讲了一下大致实现过程
	
8.算法题，求数组内最大三位数字和最小三位数字，还可以使用内置的sort（感谢面试官），输出有问题，但是面试官说没问题，到这就行了。这个面试官明显放水了。
	
9.后面问了sort.Int底层实现
面试官说这个与面试结果无关，就是好奇想问一下我
我说了一下平均时间复杂度nlogn,底层是一个使用插排，堆排序进行优化的快速排序。
	
10.唠了一下研究生生活，问了一下什么时候出结果，实习时间啥的。

---
59 【研发工程师-Golang （remote） - Starry（重生之我在Web3做HR） | 小红书 - 你的生活指南】 😆 PrcC4dXlj9Hu0gF 😆 https://www.xiaohongshu.com/discovery/item/6838286c0000000021008202?source=webshare&xhsshare=pc_web&xsec_token=ABk1qDS3GlFxrCksQrioBzvIoqTw0ohamXWbDQNcQ7GtY=&xsec_source=pc_share
岗位描述：
1、参与相关需求分析、技术设计及产品研发工作，编写高质量代码，及时交付产品；
2、负责撰写相关开发文档；
3、维护相关业务系统或模块，及时解决Bug和故障，保障系统运行稳定；
4、负责保障系统安全，及时修复系统安全问题；
岗位要求：
1、本科及以上学历，计算机或相关专业；3年以上golang开发经验；
2、熟悉golang基础数据结构，Go协程、Channel和锁等；
3、熟悉Go体系的常用开发框架，比如gin、beego、echo等；
4、熟悉Web技术栈和Web应用开发，包括HTTP、安全、数据库、缓存、消息队列等；
5、熟悉Mysql数据库，能够快速根据需求完成高性能数据库设计；
6、熟悉主流非关系性数据库、缓存技术，例如：Redis、MongoDB等；
7、富有团队精神，有较强的责任心和事业心，对待工作积极主动，有严密的逻辑思维，有追求卓越的精神，能够自我驱动。 #web3   #远程工作


---
12 【有想提升技术水平的同学来么 - 金山大表哥 | 小红书 - 你的生活指南】 😆 6ICL8dlRR2AnvEC 😆 https://www.xiaohongshu.com/discovery/item/681dcfc9000000002300f2f9?source=webshare&xhsshare=pc_web&xsec_token=ABL8l3lgn5NM67MmZjoWYahK5Y0REtW2aIyQG13BFk6h8=&xsec_source=pc_share
《服务端实习开发》岗位招聘
工作职责
负责WPS Office服务端业务的需求开发；
负责WPS Office服务端管理后台与运营后台的需求开发；
分析解决系统性能问题，提升系统稳定性、扩展性；
参与调研与落地前沿测试技术，如自动化测试、混沌工程等，探索产品的边缘问题；
岗位要求
重点本科或以上学历，计算机软件相关专业优先;
熟悉Go(优先)、C++、Java、Rust、Python中至少一种编程语言，良好的编程能力;
良好的编码和文档习惯，注重代码风格，熟悉各种设计模式和原则，善于总结与优化自己做的项目；
掌握linux系统及其原理;
掌握常用的互联网技术，包括但不限于数据库 、缓存中间件、消息中间件、微服务架构等；
积极乐观，认真负责，乐于协作；
每周可以实习4天以上，连续实习2个月以上。

---

38 【字节跳动后端开发三面面经 - 3105 | 小红书 - 你的生活指南】 😆 0CJWHzh34zNxdhi 😆 https://www.xiaohongshu.com/discovery/item/6842998a000000000303f15c?source=webshare&xhsshare=pc_web&xsec_token=ABcYZdKrRUSqfQza7e25OJ1T__QEqCaKpFsALapdqjOeg=&xsec_source=pc_share
字节跳动后端开发三面面经
时间线：
5.23投递
5.26约一面
5.28一面
5.30约了6.3二面
6.4约了6.5三面
三面面试官迟到了5分钟，问八股和项目只有15~20分钟的样子，然后两道算法题，写完第一道算法题后，感觉面试官也是想拖时间，就给了第二道算法题，写完后相互提问快十分钟。
1、讲一下进程、线程、协程（一面和三面面试官都问了这个，可能是因为字节用go开发的原因）
2、用协程做高并发需要注意什么？
3、协程是用户态的如何被操作系统调度？
4、讲一下CAS？
5、项目中使用MySQL、MQ、Redis是怎么考虑的？
6、项目中的压测是如何做的？
7、如何确定你测试得到的TPS是机器的性能瓶颈呢？
8、为什么想到用“采用布隆过滤器判断短链接是否已存在，替代传统分布式锁+查询数据库方案”？
算法题：
1、判断树B是否是树A的子结构 ：输入两颗二叉树，判断B是否是A的子结构
2、接雨水 力扣
问答环节：
1、问了我觉得自己最大的优点是什么？追问让我举例说说。
2、你觉得自己有什么缺点吗？
3、做过基于大模型的项目吗？
4、讲一下MCP？

---
40 【wxg二面面了两小时 - Wesson | 小红书 - 你的生活指南】 😆 AErkAsaz0VCBHG3 😆 https://www.xiaohongshu.com/discovery/item/684ab7a0000000002200535b?source=webshare&xhsshare=pc_web&xsec_token=ABYjDDyso4PTJokwzlitzBzu8_kJycJL96IikXe4U31kQ=&xsec_source=pc_share
wxg二面面了两小时
四道算法题（手写grpo/带lora的mha/力扣二叉树/sql）
涉及面巨广的拷打：实习经历/项目经历/传统机器学习（随机森林/xgboost）/强化学习/大模型幻觉/mcp/C++能问的都问
撕完代码就80分钟了，还逮着我问了40分钟的八股

---
92 【百度go后端开发实习一二面面经 - 许哲远 | 小红书 - 你的生活指南】 😆 MRdn4ooG5UIwsez 😆 https://www.xiaohongshu.com/discovery/item/684b9a2c000000002301d2a9?source=webshare&xhsshare=pc_web&xsec_token=AB3eYBbeLrRbgv9FsZF7eoBpoUqHJLuDLJrLhVv3zcwSw=&xsec_source=pc_share
百度go后端开发实习一二面面经
分享一下oc面经
一面
自我介绍
介绍一下业务项目，讲一下抢购流程和项目难点
1500的QPS是怎么设计的
用什么工具进行压测
压测的这些请求是一样的还是按照一定规则变化
了解限流吗，项目里有实现吗
go中什么数据结构是值拷贝，引用拷贝。
讲一下slice和数组
为什么go要引入slice和数组
goroutine中只能用channel的，什么联系
goroutine中怎么用锁的
讲一下go的泛型
讲一下go的接口
讲一下了解的设计模式，讲了策略模式
用过什么数据库，讲了Redis和MySQL
MySQL和Redis的区别，它们的技术选型，应用场景，讲讲理解
讲解对MySQL索引的理解
有没有用过elasticsearch(只了解过)
共享本地ide手撕反转链表
http和tcp的区别
开始比较随便的问题
有没有用过腾讯云或者阿里云
有没有用过k8s
有没有用过docker
项目怎么部署服务的，docker部署有什么优势
有没有用什么ai辅助编程
最近在读什么书
是打算本科毕业还是读研深造
反问
	
二面
自我介绍
讲讲业务项目的难点亮点，以及整个抢购流程
讲完以后一直在对项目进行拷打
项目具体怎么部署的
每个服务只部署一个实例吗
怎么用rocketmq实现分布式事务的
什么是熔断降级，项目中具体熔断限流策略怎么做的，不是很满意我的限流方案
八股问的不多
分布式事务的特点
MySQL事务go的底层知识，讲讲slice和channel的底层原理
手撕三数之和变式，给定一个数组和目标值，在数组里找三个数，要求三个数之和最接近目标值，题目保证有且只有一个满足要求的情况
最近在看什么书，学什么新知识
反问
	
base地深圳  有近期入职的同学认识一下吗


> [!cite]
>

