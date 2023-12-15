我正在编写一个基于 React 和 FluentUI 的项目，我首先希望能通过它提供一个 pdf 工具，后期有更加远大的理想但是现在需要做的，是创建一个 React 项目。

## 项目环境

```shell
$ yarn --version
4.0.1
$  npm --version        
10.1.0

```

fluent-ui 和 fluentui 两个包有什么区别

```sh
$ yarn create react-app my-app --template @fluentui/cra-template
```

根据微软 FluentUI 给的指令和模板创建项目



在 Yarn 3 及更高版本中，`.yarn` 目录是 Yarn 用来存储缓存、本地 state 等信息的地方。这个目录包含一些 Yarn 的内部文件和数据，通常不应该包含在版本控制中，因此你应该将它们添加到你的 `.gitignore` 文件中，以避免将这些文件提交到代码库中。

以下是一个可能的 `.gitignore` 文件的示例，其中包含了 Yarn 3 项目中应该被忽略的文件和目录：

```properties
# Yarn
.yarn/*
!.yarn/patches
!.yarn/releases
!.yarn/plugins
!.yarn/sdks
!.yarn/versions
.pnp.*
.yarnrc.yml
.yarn/*

# Miscellaneous
*.log
.pnpm
.pnpm-debug.log

```

是的，`!` 是在 `.gitignore` 文件中的一个特殊标记，用于取消前面规则的匹配，即强制包含某个文件或目录。在上面的 `.gitignore` 文件示例中，`!.yarn/patches`，`!.yarn/releases`，`!.yarn/plugins`，`!.yarn/sdks`，`!.yarn/versions` 这些规则使用了 `!`，表示这些特定的子目录是例外，不应该被忽略。

在这个上下文中，`!` 的作用是告诉 Git 不要忽略这些子目录，即使前面有通配符匹配了整个 `.yarn` 目录。这样做是为了确保特定的子目录在版本控制中保持可见，而其他的内容仍然被忽略。

具体来说，这些目录的内容如下：

- `.yarn/patches`: 存储应用于包的补丁信息。
- `.yarn/releases`: 存储与 Yarn 本身相关的信息，例如 Yarn 的版本信息。
- `.yarn/plugins`: 存储 Yarn 插件的信息。
- `.yarn/sdks`: 存储与 Node.js 版本相关的信息。
- `.yarn/versions`: 存储包版本的信息，以及 Yarn 自身的版本信息。

这些目录的具体内容可能随着项目的不同而变化，它们通常由 Yarn 在项目构建和依赖安装过程中自动生成和维护。添加这些目录到 `.gitignore` 中是为了确保它们不会被包含在版本控制中，因为它们通常是可由 Yarn 重新生成的，而不是项目的实际源代码。

如果你想了解这些目录的详细内容，可以打开这些目录，查看其中的文件和子目录。然而，大多数情况下，你不太需要直接操作这些目录。



- [ ] yarn 配置 eslint 的 ts 检查规则出现问题。



Fuck React!   create 的程序加料太多了跑起来老是有报错遂弃用转头 Vue





## Term Table

|      |                      |         |
| ---- | -------------------- | ------- |
| dist | desitnation 分发版本 | `/dist` |
|      |                      |         |
|      |                      |         |

[Switch | Microsoft Learn](https://learn.microsoft.com/en-us/fluent-ui/web-components/components/switch?pivots=typescript)

[fluentui/packages/web-components/src/anchor/fixtures/anchor.html at master · microsoft/fluentui (github.com)](https://github.com/microsoft/fluentui/blob/master/packages/web-components/src/anchor/fixtures/anchor.html)
