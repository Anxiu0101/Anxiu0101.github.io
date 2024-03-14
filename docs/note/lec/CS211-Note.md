---
title: 
author: Anxiu
creation date: 2022-07-04 21:23
modification date: 星期一 4日 七月 2022 22:08:57
categories: # 分类
- Note
tags: # 标签
- Algorithm
---

CS211-Note 算法与数据结构
<!--more-->


# Lecture-10 Graphs I

---

- Learn different types of graphs and their properties 学习不同类型的图表及其属性
- Learn Graph ADT and different presentations of graphs 学习 Graph ADT 和图形的不同表示
- Build edge list structure 建立边缘列表结构
- Build adjacency list 建立邻接表
- Build adjacency matrix 建立邻接矩阵

---

## Graph

Graphs are one of the most versatile structures used in computer programming and are used to solve the more interesting problems.

have two type: 

- Unweighted graphs where the links between nodes are equal.
- Weighted graphs where the links are each associated with an individual weight.

### Graph Structure

- Nodes are called ==vertices==.
- ==Edges== link vertices.
- Vertices are labeled in some way, often with letters.
- Each edge has two vertices at its ends.
- The graph represents which vertices are connected to each other.

A graph is a pair $(V, E)$, where 

- $V$ is a set of nodes called vertices. 
- $E$ is a collection of pairs of vertices, called edges.
- Vertices and edges are positions and store elements.

Graph 在实际生活中的应用有：Electronic circuits、Transportation networks、Computer networks、Databases

### Terminology

- End vertices (or endpoints) of an edge: U and V are the endpoints of a
- Edges incident on a vertex: a, d, and b are incident on V
- Adjacent vertices: U and V are adjacent
- Degree of a vertex: X has degree 5
- Parallel edges: h and i are parallel edges
- Self-loop: j is a self-loop

![image-20220704215629637](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207042156667.png)

- Path

  - The sequence of alternating vertices and edges
  - begins with a vertex
  - ends with a vertex
  - each edge is preceded and followed by its endpoints

- Simple path: A path such that all its vertices and edges are distinct

- Example: $P1=(V,b,X,h,Z)$ is a simple path; $P2=(U,c,W,e,X,g,Y,f,W,d,V)$ is a path that is not simple. 

  ![image-20220704220542696](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207042206016.png)

- Cycle
  - circular sequence of alternating vertices and edges
  - each edge is preceded and followed by its endpoints

- Simple cycle: cycle such that all its vertices and edges are distinct

- Examples: $C1=(V,b,X,g,Y,f,W,c,U,a,¿)$ is a simple cycle $C 2=(U,c,W,e,X,g,Y,f,W,d,V,a,¿)$ is a cycle that is not simple

  ![image-20220704220855120](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202207042208152.png)

