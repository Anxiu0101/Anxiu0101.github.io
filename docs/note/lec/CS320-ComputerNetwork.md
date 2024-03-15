---
title: 'CS320-ComputerNetwork'
date: 2022-08-31 11:55:40
tags: [Network]
categories: [Note]
published: true
hideInList: false
feature: 
isTop: false
---




# Course overview

- Computer Networks & the Internet, packet switching, delay, loss and throughput 计算机网络和互联网、分组交换、延迟、丢失和吞吐量
- Application Layer: Web, eMail, Simple Mail Transfer Protocol(SMTP), Domain name system (DNS), P2P, content delivery network (CDNs) and Socket Programming 应用层：Web、电子邮件、简单邮件传输协议 (SMTP)、域名系统 (DNS)、P2P、内容分发网络 (CDN) 和套接字编程
- Transport Layer: Multiplexing, User Datagram Protocol (UDP), Transmission Control Protocol(TCP) and Congestion Control 传输层：多路复用、用户数据报协议 (UDP)、传输控制协议 (TCP) 和拥塞控制
- Network Layer: Virtual circuits, IP and Routing Algorithms, Routers, Internet Control Message Protocol (ICMP) 网络层：虚拟电路、IP 和路由算法、路由器、互联网控制消息协议 (ICMP)
- Link Layer: Error detection/correction, ALOHA, Carrier-sense multiple access (CSMA), Sliding window protocols, Multiple Access, Addressing and Switching 链路层：错误检测/纠正、ALOHA、载波侦听多路访问 (CSMA)、滑动窗口协议、多路访问、寻址和交换
- Internet security/Wireless Networks and Security, Wifi 802.11, mobility management and mobile IP 互联网安全/无线网络和安全、Wifi 802.11、移动管理和移动 IP



# Chapter 1 Roadmap



---

## Overview

- What is computer networks, basic components, data communication system in computer networks. 什么是计算机网络、基本组件、计算机网络中的数据通信系统。
- Different types of transmission modes in computer networks and communication ways in computer networks. 计算机网络中不同类型的传输模式和计算机网络中的通信方式。
- What is the Internet? what is a protocol? 什么是互联网？ 什么是协议？
- Network edge: hosts, access net, physical media. 网络边缘：主机、接入网、物理媒体。
- Network types and topology 网络类型和拓扑
- Network core: packet/circuit switching. 网络核心：分组/电路交换。
- Performance: loss, delay, throughput 性能：损失、延迟、吞吐量



---

## Computer Networks Components

A computer network is **a set of nodes** that are connected together by **communication links**.

**Set of nodes**: Computers, switches, routers, hubs, printers, and servers, smart phone, table
**Communication links**: Fiber optics, Coaxial pair cable, copper, radio wave, micro wave 

### Basic Components

- Server
- Client
- Hub: Hub is a device that splits a network connection into multiple computers.
- Router: A Router is a networking device that receives and forwards data packets between computer networks. 路由器是在计算机网络之间接收和转发数据包的网络设备。
- Data cable: Data cables are used to transmit the information from a source to a destination. 数据电缆用于将信息从源传输到目的地。
- Peers: a peer is also a node that accesses a service made available by a server

### Communication System Components

- Sender
- Receiver
- Message - It is the information to be communicated. Popular forms of information include text, numbers, images, audio, video etc.
- Transmission Medium 传输介质 - Cable or wire
- Protocol 协议



---

## Transmission Modes in Computer Network

Type of data communication, 

- Simplex Mode 单工模式
- Half-Duplex Mode 半双工模式
- Full-Duplex Mode 全双工模式

### Simplex Mode

单工模式，特点是

- In Simplex mode, the ==communication is unidirectional==, as on a one-way street. 单向传输
- Only ==one of the two devices== on a link ==can transmit==, the other can ==only receive==.

- The simplex mode can use the ==entire capacity of the channel== to send data in one direction.
  可以使用整个信道的容

![img](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209011251807.png)

### Half-Duplex Mode

半双工模式，

- In half-duplex mode, ==each station can both transmit and receive==, but ==not at the same time==. 
  任何一个站点可以完成 transmit 和  receive，但这两个任务不能同时进行
- When ==one device is sending==, the ==other can only receive==, and ==vice versa==. 当一个设备正在发送，则另一个只能接受，反之亦然
- The half-duplex mode is used in cases where there is ==no need for communication in both directions at the same time==.
  用于不需要同时进行双向传输的场合
- The ==entire capacity of the channel can be utilized== for each direction. 通道的全部容量可用于每个方向。
- 类似于对讲机 Walkie- talkie 的操作

![img](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209011251849.png)

### Full-Duplex Mode

- is used when communication ==in both directions is required== 用于需要双向传输的联系
- In full-duplex mode, ==both stations can transmit and receive simultaneously==. In full-duplex mode, signals going in one direction share the capacity of the link with signals going in other direction, this sharing can occur in two ways 
  在全双工模式下，两个站点可以同时发送和接收。
  一个方向的信号与另一个方向的信号共享链路容量
  这种共享可以通过两种方式发生
  - Either the link must contain ==two physically separate transmission paths==, one for sending and other for receiving
    链路必须包含两条物理上独立的传输路径，一条用于发送，另一条用于接收
  - The ==capacity is divided between signals travelling== in both directions. 
    容量在双向传输的信号之间分配。


![img](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209011252572.png)



## Data communication Ways in Computer Networks

### Unicast 单播

- Unicast is the term used to describe communication where a piece of information is sent from ==one point to another point==. In this case there is ==just one sender, and one receiver==. 
- Unicast transmission, in which a packet is sent ==from a single source to a specified destination==. 单播传输，其中数据包从单一来源发送到指定目的地。

![img](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209020743166.jpeg)

### Broadcast 广播

Broadcast 是用于描述一份信息从一个点发送到其他所有点的术语

在这种情况下，只有一个 sender 但是信息被发送给所有已连接的 receiver

> 广播有两种类型，分别是，
>
> - Limited Broadcasting 指的是向自己所在的网络中所有其他终端发送消息
>
>   ![img](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209020748594.png)
>
> - Direct Broadcasting 指的是向另外一个网络中所有已连接终端发送消息 
>
>   ![img](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209020748434.png)

### Multicast 组播

describe communication where a piece of information is sent from one point to a set ofother points. 组播是用于描述一份信息从一个节点发送给一组其他节点的术语

在这种情况下，the information is distributed to a set of receivers. 

![img](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209020743572.jpeg)



> 几个术语
>
> host = end systems, like running network apps
> communication links is like fiber, copper, radio, satelite
> tramsmission rate: bandwidth 带宽
> Packet switches: forward packets (chunks of data), routers and switches



---

## Protocol

> 没什么内容，理解协议是什么即可

In general the protocol means the formal system of rules. A network protocol is an established set of rules that determine how data is transmitted between different devices in the network. All communication activities in Internet are governed by protocol. 



---

## Network edge

Network edge: The network edge refers to endpoints of a networks. 网络边缘是指网络的端点。

- **End systems**

  The computers and other devices connected ==to the internet== are often referred to as ==end systems==. 连接到互联网的计算机和其他设备通常被称为终端系统。
  They are ==referred== to as ==end systems== because they ==sit at the edge== of the internet.

  > hosts: clients (receive services) and servers(provide services)

- **access networks**

  is a network that connects subscribers to a particular service provider(**DSL**, **cable networks**)

- **links**
  physical media like wired, wireless communication links.



### Access networks: digital subscriber line (DSL)

DSL is a technology for transmitting digital information at a high bandwidth on existing phone lines to homes and businesses DSL 是一种在现有电话线上以高带宽将数字信息传输到家庭和企业的技术

use existing telephone line to central office DSLAM 使用现有电话线连接到中央办公室 DSLAM

- data over DSL phone line goes to Internet 通过 DSL 电话线的数据进入互联网
- voice over DSL phone line goes to telephone net DSL 电话线上的语音进入电话网

> ![image-20220910170249189](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209101702315.png)
> The above figure is a schematic of a simple DSL connection (in blue). The right side shows a DSLAM residing in the telephone company's telephone exchange. The left side shows the customer premises equipment with an optional router. The router manages a [local area network](https://en.wikipedia.org/wiki/Local_area_network) which connects PCs and other local devices. The customer may opt for a modem that contains both a router and wireless access. This option (within the dashed bubble) often simplifies the connection. 上图是一个简单的 DSL 连接示意图（蓝色）。 右侧显示了驻留在电话公司电话交换机中的 DSLAM。 左侧显示带有可选路由器的客户端设备。 路由器管理连接 PC 和其他本地设备的局域网。 客户可以选择同时包含路由器和无线接入的调制解调器。 此选项（在虚线气泡内)通常会简化连接。



### Access net: cable network

network of cable, fiber attaches homes to ISP router 电缆网络，光纤将家庭连接到 ISP 路由器

- homes share access network to cable headend 家庭共享接入网络到电缆前端

- unlike DSL, which has dedicated access to central office 与 DSL 不同，DSL 具有对中央办公室的专用访问权限

![image-20220910171036723](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202209101710868.png)





### Physical media

Medium through which the information are transmitted. 传输信息的媒介。

Categories of physical media:

- Wired communication links 有线通讯链接: 
  - twisted pair 双绞线
  - coaxial cable 同轴电缆
  - fiber optics 光纤
- Wireless communication links 无线通信链接: 
  - micro wave 微波
  - radio wave 无线电波
  - infrared 红外线的



# Chapter 2 Application Layer

## Overview



## Principles of Network Applications

### TCP / IP

TCP / IP 表示 Transmission Control Protocol / Internet Protocol. 它是一个通讯协议的集合(collection). 这些协议描述了数据在互联网上从数据源到目的地的传输。



TCP / IP 的四层结构：

- Application Layer 应用层
- Transport Layer 传输层
- Network Layer 网络层
- Link Layer 连接层

### Application layer

应用层是 TCP / IP 的第一层，也是最上层，是最接近用户的一层。It means that the application layer and end user can interact directly with the software application. 这意味着应用层和最终用户可以直接与软件应用程序交互。应用层程序是基于 client 和 server 的。

### Network application architectures

Two different architectures are used in modern network applications: 

- client-server architecture
  在服务器-客户端架构中，有一个永远在线的主机称为服务器(server)，他为来自许多其他主机(client)的请求提供服务。

  > Server:
  >
  > - Servers are always on
  > - It has a permanent and fixed IP address 它有一个永久和固定的IP地址
  >
  > Client: 
  >
  > - Client communicate with Server.
  > - may have a dynamiic IP address.
  > - Communicate with each other via IP address.

- peer-to-peer(P2P) architecture
  在P2P网络中，允许主机不通过服务器直接相互连接。不同于服务器-客户端结构，P2P 不存在一个 central server 来处理请求，The peers directly interact with one aother. Peer is a host.

### Processes communicating

Processes communicating, 进程通讯。The programs, running in multiple end systems, communicate with each other by process. A process can be thought of as a program that is running within an end system.

- A sending process creates and sends messages into the network
- A receiving process receives these messages and possibly responds by sending messages back.

### Sockets

**Definition**: Process sends/receives messages to/from its socket

A process sends messages into, and receives messages from, the network through a software interface called a socket.

![image-20221010152515158](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202210101525295.png)

### Addressing processes

寻址过程，所有主机在互联网上都有一个地址，这样它们才能互相找到对方的位置。例如服务器要给客户端发送响应信息，他就需要客户端的地址，将信息按照地址发送出去。为了接受信息，进程必须有一个标识符(identifier)



> Identifier 包括 IP 地址和 端口号 (port numbers) 与进程关联。主机设备都有一个独属的 32-bit 的 IP 地址 (现在没有了 ipv4 不够用了，ipv6还没普及)，example：127.0.0.1:8080





# Chapter 3 Transport Layer

Transport Layer: 传输层 Second layer of the TCP/IP model，TCP/IP 模型的第二层



## Transport-layer Services

它提供在不同主机上运行的应用程序进程之间的逻辑通信(logical communication)

> Logical Communication: 
> 通过逻辑通信，这意味着运行进程的主机是直接连接的，但主机可能位于地球的另一端

传输协议在终端系统中运行 

- 发送方：将消息分成段(Segment)，传递到网络层(network layer) 
- 接收方：将段重新组装成消息，传递到应用层(app layer) 

传输层的数据被称为 Transport-layer segments，也就是段。
段是传输层将应用层消息分块并在每个段添加标头得到的 (breaking into smaller chunks and adding a transport-layer header to each chunk)。

传输层将 Segments 在发送终端 (Sending End System) 传给网络层 (Network layer)，然后被封装在网络层数据包中并发送到目的地。

在接收端，网络层从 datagram 中提取出 transport-layer segment 后，将 segment 传给传输层。传输层接受 segment，使得段数据可用 (available) 也就是重新组装数据然后传给应用层。



> **Transport vs. network layer**
>
> Network layer: logical communication between ==hosts==
> Transport layer: logical communication between ==processes==
> 	relies on, enhances, network layer services 依赖、增强、网络层服务



## Multiplexing and Demultiplexing

发送方多路复用 (Multiplexing at Sender)： 

- 在源主机从不同套接字收集数据块的工作， the job of gathering data chunks at the source host from different socket. 
- 使用标头信息（稍后将用于解复用）封装每个数据块（位集合）以创建段， encapsulating each data chunk (colection of bits) with header information (will be used in demultiplexing) to create segment.
- 并将段传递到网络层称为多路复用 passing the segments to the network layer is called muliplexing. 

接收端解复用 (Demultiplexing at receiver)

一个进程 process 可能有一个或多个套接字 socket，即数据从网络传递到进程以及数据从进程传递到网络的门。

接收主机中的传输层实际上并不直接将数据直接传递给进程，而是传递给中间套接字 intermediary socket。

- 在接收端，传输层检查 examine 这些字段 field 以识别 identify 接收套接字

  > TCP socket identified by 4-tuple: 
  >
  > - source IP address with port number, 
  > - destination IP address with port number.

- 然后将段定向 direct 到该套接字。

- 将传输层段中的数据传送到正确套接字的这项工作称为解复用。This job of delivering the data in a transport-layer segment to the correct socket is called demultiplexing.

![image-20221107143518890](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202211071435951.png)

## Connectionless Transport: UDP

UDP (User Datagram Protocol), is a Transport Layer protocol. 
There is ==no need== to establish a connection prior to data transfer 无需在数据传输之前建立连接
And Since that, In UDP there may be: 

- data lost 数据丢失
- Unreliable 不可靠

connectionless 无连接: 

- no handshaking between UDP sender, receiver UDP 发送者和接收者之间没有握手
- each UDP segment handled independently of others 每个 UDP 段独立处理

![UDP segment format](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202211071512526.png)



> length, in bytes of UDP segment, including header
>
> checksum 校验和
>
> application data (payload) Message 负载信息

- no connection establishment (less delay)
- simple: no connection state at sender, receiver
- small header size
- no congestion control: UDP can blast away as fast as desired 无拥塞控制：UDP 可以随心所欲地快速消失

也是这样的特点，所以在对于数据损失要求较小，但是对低延迟要求较高的直播推流领域普遍使用的是 UDP 进行数据传输。



### Checksum

checksum 校验和，detect “errors” (e.g., flipped bits) in transmitted segment 检测传输段中的“错误”（例如翻转位）

In Sender: 

- treat segment contents, including header fields, as sequence of 16-bit integers 将段内容（包括标头字段）视为 16 位整数序列
- checksum: addition (one’s complement sum) of segment contents 校验和：段内容的加法（补码和）
- sender puts checksum value into UDP checksum field

In Receiver: 

- compute checksum of received segment
- check if computed checksum equals checksum field value: 
  - NO - error detected 
  - YES - no error detected.

> ![image-20221107154213586](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202211071543412.png)
> 添加数字时，需要将最高有效位的进位添加到结果中



## Connection-oriented Transport: TCP

TCP (Transmission Control Protocol)

Connection oriented service - Unlike UDP, TCP provides connection oriented service. It defines 3 different phases: 

- Connection establishment
- Data transfer
- Connection termination

The character of TCP connection: 

- Full duplex service data [全双工](#Full-Duplex Mode)

- Connection-oriented 面向连接

  TCP 的握手机制 (Handshaking)：握手 (控制消息的交换) 在数据交换之前初始化发送方、接收方状态

- Reliability 可靠性

  TCP 使用==校验和== (checksum) 进行==错误检测== (error detection)，尝试通过==重新传输== (re-transmission) 来恢复丢失或损坏 (corrupted) 的数据包

### TCP Segment Structure

![image-20221115054025733](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202211150540170.png)



| Field                  | Size            | Desc                                                         |
| ---------------------- | --------------- | ------------------------------------------------------------ |
| Source Port            | 2 bytes         |                                                              |
| Destination Port       | 2 bytes         |                                                              |
| Sequence Number        | 4 bytes         | counting by bytes of data                                    |
| Acknowledgement Number | 4 bytes         | ACK identifies SEQ no                                        |
| Head Length            |                 |                                                              |
| URG                    |                 | urgent data (generally not used)                             |
| ACK                    |                 |                                                              |
| PSH                    |                 | push data now (generally not used)                           |
| RST, SYN, FIN          |                 | connection estab (setup, teardown, commands)<br />RST = Rest<br />SYN = Synchro<br />FIN = Finished |
| Receive Window         | 2 bytes         | rcvr willing to accept                                       |
| Checksum               | 2 bytes         | Internet Checksum,as UDP                                     |
| Urg data pointer       | 2 bytes         |                                                              |
| options                | variable length |                                                              |
| application data       | variable length |                                                              |

### TCP seq. numbers, ACKs



## Congestion Control

