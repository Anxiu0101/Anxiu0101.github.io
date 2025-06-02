---
title: 'Nextjs DevNote: Pure Component and Memoization'
date: 2025-04-24 19:56:11
tags: []
published: false
comments: false
---

<!--more-->

## Main Content

> [!cite]
>
> const KbButton = memo(PureKbButton) 这个是起到什么作用？Pure 开头的对象名称有什么特别的意义？

Thought for 5 seconds

### `const KbButton = memo(PureKbButton)` 到底干了什么？

1. **`PureKbButton` 是一个普通的函数组件**

   ```tsx
   function PureKbButton(props) {
     // …渲染逻辑…
   }
   ```

2. **`memo()` 会返回一个“记忆化”版本**

   ```tsx
   const KbButton = memo(PureKbButton);
   ```

   - *记忆化（memoization）* 的意思是：
      只要 **接收到的 props 没变**，React 就会直接复用上一次渲染的结果，而 **跳过整个组件函数的执行**。
   - 这能减少不必要的重渲染，尤其是在按钮、图标这类 UI 频繁出现、却很少改动的场景里。

3. **比 `React.PureComponent` 更轻巧**

   - class 组件时代用 `PureComponent`，函数组件时代就用 `memo()`。
   - 默认的比较规则是 *浅比较*（shallow compare）：只检查第一层 props 是否 === 上一次。

4. **如果需要更精细的控制，可以传入自定义比较函数**

   ```tsx
   const KbButton = memo(PureKbButton, (prevProps, nextProps) => {
     // 返回 true 表示“看起来一样 → 跳过渲染”
     // 返回 false 表示“不同 → 重新渲染”
   });
   ```

   在你给的代码里，`SendButton` 就用了自定义比较，只在 `input` 或 `uploadQueue` 长度变化时才重渲。

------

### 为什么起名叫 `PureKbButton`？

这并不是 React 的强制要求，只是一种 **代码约定**，含义大致如下：

| 名称               | 角色                | 说明                                                         |
| ------------------ | ------------------- | ------------------------------------------------------------ |
| **`PureKbButton`** | *原始* 函数组件     | “Pure” 提醒自己：组件 **纯粹依赖 props**，内部没有副作用，也不访问外部状态。 |
| **`KbButton`**     | *导出的* 记忆化组件 | 实际给别的地方 `import` 和使用的名字，不带前缀更简洁。       |

这种写法把「组件逻辑」和「性能包装」分开看待，可读性更好，而且跟类组件时代的 `class PureComponent` 命名风格保持一致。你也可以不用 `Pure` 前缀——完全只是团队风格问题，例如：

```tsx
function KbButtonInner(props) { … }
export const KbButton = memo(KbButtonInner);
```

------

**总结**

- **`memo()`** = React 对函数组件的“PureComponent 化”。
- **`PureKbButton`** 的 “Pure” 并非框架关键字，只是作者想强调“这是纯渲染函数”。
- 你在项目里看到的 `AttachmentsButton`, `SendButton`, `StopButton` 也都用了相同套路：
   先写 `PureXxxButton` → 再 `memo` → 得到真正导出的 `XxxButton`。

>[!tip]
>
>- [memo – React](https://react.dev/reference/react/memo)
>- [What is Memoization? How and When to Memoize in JavaScript and React](https://www.freecodecamp.org/news/memoization-in-javascript-and-react/)
