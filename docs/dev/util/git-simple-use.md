```shell
git clone git@github.com:Anxiu0101/Anxiu0101.github.io.git

// clone 指定分支
git clone -b gh-pages git@github.com:Anxiu0101/Anxiu0101.github.io.git

git pull origin master --allow-unrelated-histories
```



```shell
git status
# Sample
PS E:\Desktop\BlogEnv\BlogMkdocs> git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        deleted:    docs/web/deploy/git.md

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        docs/web/deploy/git-simple-use.md

no changes added to commit (use "git add" and/or "git commit -a")
```



[git 远程仓库回退的两种方式_git回退远程仓库-CSDN博客](https://blog.csdn.net/chushoufengli/article/details/101683839)

## `Git` 贡献提交规范



参考 [vue](https://github.com/vuejs/vue/blob/dev/.github/COMMIT_CONVENTION.md) 规范 ([Angular](https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-angular))

- `feat` 增加新功能
- `fix` 修复问题/BUG
- `style` 代码风格相关无影响运行结果的
- `perf` 优化/性能提升
- `refactor` 重构
- `revert` 撤销修改
- `test` 测试相关
- `docs` 文档/注释
- `chore` 依赖更新/脚手架配置修改等
- `workflow` 工作流改进
- `ci` 持续集成
- `types` 类型定义文件更改
- `wip` 开发中
