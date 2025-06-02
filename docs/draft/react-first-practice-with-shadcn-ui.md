---
title: 'React first practice with shadcn-ui'
date: 2024-05-09 06:15:15
tags: []
published: false
comments: false
---

## Before Article





## About Stack of CampusHub



### React


### Different Import

在现代 TypeScript + React + Vite/Webpack 项目中，存在几种常见的 Import 方式：

```typescript
import { XXComponent } from '@/components/xx-componnet';

import XXComponent from '@/components/xx-componnet';

import type XXComponent from '@/components/xx-componnet';
```

第一种和第二种的区别较小，主要是 default 导出的区别。对于第一种引用，被引用组件是通过类似于以下代码导出的

```typescript
export const XXComponent = () => { ... };
// or
export function XXComponent() { ... }
```
 
该文件可能还导出了其他内容，但是这里只取名字为 XXComponent 的对象。我们称这种方法为 **命名导出（Named Export）**。

而默认导出则在 `export` 时携带了 `default` 关键字，例如如下代码，

```typescript
export default function XXComponent() { ... }
// or 
const XXComponent = () => { ... };
export default XXComponent;
```

这时这个组件只会通过默认名导出一个主模块对象或组件。

| 区别点               | 命名导出 `{}`                 | 默认导出                  |
| ----------------- | ------------------------- | --------------------- |
| 语法结构              | `import { A } from './x'` | `import A from './x'` |
| 一个文件是否能导出多个？      | ✅ 可以多个命名导出                | ⚠️ 只能有一个默认导出          |
| 对 Tree Shaking 支持 | ✅ 更容易优化                   | 较差，尤其是大型默认导出对象        |
| 导入名是否必须匹配？        | ✅ 必须匹配导出名                 | ❌ 不需要匹配导出时的变量名        |
| 常用于               | 多工具函数、多组件导出               | 单一组件、类库入口             |

- 对于页面组件、主要 UI 组件：通常使用 default export，便于 lazy 加载或 app/router 自动识别。
- 对于工具方法、类型定义、多个组件集合：建议使用 named export，保持模块结构清晰，方便 IDE 自动提示。

### Typescript



### Next.js



### Shadcn-ui



### Redux

在 Redux Toolkit 中，使用 features 来组织按功能区分的代码和状态是一种常见的最佳实践。每个 feature 可以包含一个或多个 slices，每个 slice 管理该功能区域的一部分状态。最后，所有的 slices 被合并到一个 central store 中，这个 store 是全局状态的主要源，为整个应用提供状态管理的功能。这种组织方式提高了代码的可维护性和可扩展性。

#### Features

在一个复杂的应用中，通常会有多个不同的功能区域，每个区域可能需要管理自己的状态。在 Redux Toolkit 中，我们通常按功能模块来组织代码和状态，每个功能模块通常被称为一个 "feature"。

例如，在一个电商应用中，可能有购物车、用户认证、产品目录等功能区域，每个区域都可以被视为一个独立的 feature。将应用按 feature 组织有助于保持代码的清晰和可维护性。通常在项目目录中，每个 feature 都有自己的文件夹，如 `features/cart`、`features/user` 等。

### Slice

在 Redux 中，全局的应用状态被存储在一个单一的对象树中，这个对象树被称为 "store"。为了管理这个大的状态树，Redux 引入了 "reducers" 的概念，每个 reducer 管理状态树的一部分。

在 Redux Toolkit 中，一个 "slice" 是指状态树中的一部分，它包括了相关的 reducer 函数和产生状态变化的 actions。`createSlice` 函数是 Redux Toolkit 提供的一个工具，它可以自动生成 action creators 和 action types，同时基于初始状态和 reducer 函数定义生成一个 slice reducer。

每个 slice 通常只负责应用中的一个特定功能区域或模块的状态。比如，你可能有一个名为 `userSlice` 的 slice 来管理用户的登录状态、个人信息等。

### Store

Store 是 Redux 应用中的核心，它是一个容纳应用所有状态的对象。Store 提供了一种方式来访问状态、派发 actions 以及注册监听器。在整个应用中，你只会有一个 Redux store。

在 Redux Toolkit 中，你可以使用 `configureStore` 方法来创建 store。这个方法简化了 store 的配置过程，自动集成了 Redux DevTools 和 redux-thunk 等中间件，以及方便的开发者工具支持。

例如，创建一个 store 可能看起来像这样：

```typescript
import { configureStore } from '@reduxjs/toolkit';
import userReducer from './features/user/userSlice';

export const store = configureStore({
  reducer: {
    user: userReducer
  }
});
```

在这个例子中，我们创建了一个 store，其中包含了一个名为 `user` 的 slice。这个 slice 由 `userReducer` 管理，它定义在 `features/user/userSlice.js` 文件中。

> [!note]





## Shadcn-ui Using



> [!note]
>
> [[feat\]: Timeline Component · Issue #3584 · shadcn-ui/ui (github.com)](https://github.com/shadcn-ui/ui/issues/3584)
> [feat: :sparkles: create new timeline component by flixlix · Pull Request #3374 · shadcn-ui/ui (github.com)](https://github.com/shadcn-ui/ui/pull/3374)





[^ES6Syntax]: [ES6 Syntax and Feature Overview | Tania Rascia](https://www.taniarascia.com/es6-syntax-and-feature-overview/)
[^NextDocs]: [Docs | Next.js (nextjs.org)](https://nextjs.org/docs)
[^Shadcn]: [Introduction - shadcn/ui](https://ui.shadcn.com/docs)
[^v0dev]: [v0 by Vercel](https://v0.dev/)
