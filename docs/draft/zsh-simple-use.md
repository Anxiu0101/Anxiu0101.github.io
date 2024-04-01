---
title: zsh-simple-use
date: 2024-03-28 01:42:48
tags: []
categories: []
published: true
---



<!--content-->

“～ ” 你的home目录，在OS X下位于/Users/你的用户名/
“.” 类unix下的隐藏文件，文件名带"."之后在GUI文件管理器和ls的默认设置下不会显示出来，使用ls -a命令可以显示出这些文件。
zshrc是一个文件，准确的说这个文件的文件名是".zshrc".

zsh是shell语言类型，兼容bash，提供强大的命令行功能，比如tab补全，自动纠错功能等。缺点就是配置太麻烦，好在有一个叫做oh-my-zsh的开源项目，很好的弥补了这一缺陷，只需要修修改改配置文件，就能很顺手。

替换bash的方式：

```bash
chsh -s /bin/zsh
```

关闭终端，再次打开即为zsh。

zshrc是zsh的配置文件，我会在此添加一些alias设置。比如:

```zshrc
alias st='open -a "Sublime Text"'
```

