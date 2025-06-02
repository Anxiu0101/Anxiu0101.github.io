---
title: 'Build Ai Asstant By Vercel AI SDK'
date: 2025-04-17 16:20:30
tags: [ai, llm, agent, vercel, nextjs, react, typescript]
published: false
comments: false
---

一篇关于如何通过 Next.js 与 Vercel AI SDK 创建人工智能代码助手的简单指南。

<!--more-->

## Before Development

### 关于 Next.js 和 Vercel AI SDK

> [!note]
>
> 技术选型内容仅代表笔者观点，请读者自行分辩内容是否依然符合开发现状。

Next.js 是在前端 React 开发中广为所知的框架，靠着 Vercel 强大的 Serverless 生态以及诸多特性被广泛使用。于此同时，Vercel 在近些年公开的的 AI SDK 从前端开发的角度将和 AI 交互的诸多细节进行包装，提供了更加快速上手的 LLM 应用开发体验。~~笔者选它们绝对不是因为实现搞不懂 Langchain 一堆奇奇怪怪的概念和 Python 令人绝望的依赖版本冲突的原因（~~

### 关于 LLM 代码助手

有大语言模型的加持，现今的代码助手可以直接生成大量接近可用代码的程度。通过 Agent 的几个主要能力：Planning，Reasoning，以及 Reflection，单模型中的幻觉问题将被消减，能力上限边界可以被拓展。通过使用 Local RAG 和 在线搜索 等工具，Agent 可以补充模型数据集中未包含数据与互联网中的最新信息，从而在更有针对性和时效性的知识基础上完善回答。

## 项目结构剖析



