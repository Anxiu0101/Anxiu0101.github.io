# Initialize Develop Environment in Ubuntu

[设置 WSL 开发环境 | Microsoft Learn](https://learn.microsoft.com/zh-cn/windows/wsl/setup/environment)

查看系统版本，

```bash
$ lsb_release -a
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 22.04.3 LTS
Release:        22.04
Codename:       jammy
```



## Languages Installation

### Go

从官方二级制包中安装，

```shell
// 更新本地包索引
sudo apt update
// 下载版本对应的包
wget https://go.dev/dl/go1.21.2.linux-amd64.tar.gz
// 将文件内容解压到 /usr/local 目录
sudo tar -C /usr/local -xzf go1.21.2.linux-amd64.tar.gz
// 查看 /usr/local/go 目录的内容
ls -al /usr/local/go
// 将 Go 二进制文件添加到 $PATH 环境变量中
// 打开 .bashrc 或者 .bash_profile 文件
nano ~/.bash_profile
// 写入 Path，更改并保存
export PATH=$PATH:/usr/local/go/bin
// 重新加载 .bashrc 或者 .bash_profile 文件
source ~/.bash_profile
// 验证安装
go version
```

### Rust

官网给出了针对 WSL 用户的安装指令：

> If you’re a Windows Subsystem for Linux user run the following in your terminal, then follow the on-screen instructions to install Rust.
> [Install Rust - Rust Programming Language (rust-lang.org)](https://www.rust-lang.org/tools/install)

```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```





### Node.js

通过 apt 直接安装

```shell
sudo apt update
sudo apt install nodejs npm
// 验证安装
nodejs --version
npm --version
// 卸载指令
sudo apt-get --purge remove nodejs npm
```

但是 apt 源中分发的应用版本不一定是最新的，所以如果你找不到你需要的版本，还是通过官方的二进制包进行安装是比较合理且便于调整的选择。

> 原本以为直接放在 `/usr/local/nodejs` 底下就行，但是看看 Linux 的文件层级发现还有更好的方式，是放在 `/opt/` 目录下，然后将二进制文件目录也就是 `/bin` 软链接到 `/usr/local/bin` 下更加合适。
>
> [Ubuntu 20.04.3 LTS - 安装 Node.js v16.14.2-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/891091)

```shell
wget https://nodejs.org/dist/v20.10.0/node-v20.10.0-linux-x64.tar.xz
sudo tar -C /usr/local -xf node-v20.10.0-linux-x64.tar.xz
cd usr/local
mv node-v20.10.0-linux-x64/ nodejs/
cd /home/<user>
nano ~/.bash_profile
source ~/.bash_profile
```



> 在 node 20 版本里（我并未确认先前版本的情况，仅讨论我使用 node v20 时的结果）解压二级制包后实际可以看到 `node/bin` 下直接就是一个只想 `/usr/bin` 的，你可以直接运行起它并且将它软链接到 `/usr/local/bin` 即可
> ```
> anxiu@Anxiu-Desktop:~/node-v20.10.0-linux-x64$ ls -l /bin
> lrwxrwxrwx 1 root root 7 Nov 23 05:36 /bin -> usr/bin
> ./bin/node -v
> ```



```shell
tar xf node-v20.10.0-linux-x64.tar.xz
cd node-v20.10.0-linux-x64/
ls -l /bin
cd ..
sudo mv node-v20.10.0-linux-x64 /opt/
sudo ln -s /opt/node-v20.10.0-linux-x64/bin/node /usr/local/bin/
sudo ln -s /opt/node-v20.10.0-linux-x64/bin/npm /usr/local/bin/
````

我个人更加喜欢用 yarn 所以附上 yarn1 的安装

[How to Install Yarn on Ubuntu {With Screenshots} | phoenixNAP KB](https://phoenixnap.com/kb/how-to-install-yarn-ubuntu#:~:text=Install Yarn Using Ubuntu 1 Configure the Yarn,key%3Acurl -sS https%3A%2F%2Fdl.yarnpkg. 2 Install Yarn See More.)

```shell
npm install --global yarn
yarn --version
```

[如何在 Ubuntu 20.04 上安装 Node.js 和 npm-阿里云开发者社区 (aliyun.com)](https://developer.aliyun.com/article/760687)



## Development Tools

### Zsh

> [Windows Subsystem for Linux（WSL）的安装、美化和增强 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/340851697)

```shell
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
// ZSH_THEME="afowler"
sudo vim ~/.zshrc
source ~/.zshrc
```

语法高亮

```shell
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
```

自动补全插件

```shell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
// plugins=(zsh-autosuggestions)
sudo vim ~/.zshrc
source ~/.zshrc
```







### Git

The vital important tool for programming development must be the version control tools, the Git.
Since WSL doesn't need to install git if the host have been installed.
Config the username and email, 

```shell
git config --global user.name "username"
git config --global user.email "user.name@exmaple.com"
ssh-keygen -t rsa -C "user.name@exmaple.com"
cat ~/.ssh/id_rsa.pub
```

Put the public key to you Github. If you use the default config, the ssh key will in the `/home/user/.ssh/id_rsa.pub`. 

### VSCode

笔者使用的是 Windows 下的 WSL2 Ubuntu，所以可以直接通过指令 code . 安装并打开项目目录。

```shell
anxiu@Anxiu-Desktop:~/project/campus-hub/campus-hub-vitepress$ code .
Installing VS Code Server for x64 (1a5daa3a0231a0fbba4f14db7ec463cf99d7768e)
Downloading: 100%
Unpacking: 100%
Unpacked 1522 files and folders to /home/anxiu/.vscode-server/bin/1a5daa3a0231a0fbba4f14db7ec463cf99d7768e.
```

好用，赞
