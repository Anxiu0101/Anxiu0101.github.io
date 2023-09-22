



`venv`  是 python 中搭建虚拟环境的一个工具，是 python virtual environments 特性中的一部分，有时也会被缩写成 `virtualenv` 
  
```ad-note
Python virtual environments allow you to install Python packages in an isolated location from the rest of your system instead of installing them system-wide. Let’s look at how to use the Python venv, short for Python virtual environment, also abbreviated as _virtualenv_.
```

个人理解上，它的作用类似于前端项目中的 `node_module`，将依赖包安装到项目依赖路径下而不是系统依赖中。

## Install

执行以下指令安装 python virtual environment，

```python
pip install virtualenv
```

也可以通过阿里云的镜像进行安装，

```python
pip install virtualenv -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
```

## Get Started

以下是虚拟环境的简单使用，笔者使用的是 `win`，路径自己改改分隔符。

```python
# 创建虚拟环境
python -m venv .\venv
# ./venv 为依赖创建的路径。
```

创建完成后，终端进入虚拟环境，使用 `.\venv\Scripts` 下的 `python.exe` 作为解释器。终端将会出现类似于 `(venv)` 的字样，显示已经进入虚拟环境中。

![image.png](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202308071038311.png)

![image.png](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202308071039196.png)

如果终端没有成功进入虚拟环境，可以使用 `venv` 生成的脚本进行启动，

```shell
# For Windows OS,
# In cmd.exe
.\venv\Scripts\activate.bat
# In PowerShell
.\venv\Scripts\Activate.ps1

# For Linux and MacOS, 
source myvenv/bin/activate
```

一般来说，我们会将虚拟环境命名为 `/venv`，这个文件夹中将包含以下内容。

```shell
# In windows OS
.
├── Include
├── Lib
│   └── site-packages
├── pyvenv.cfg
└── Scripts
	├── activate
	├── activate.bat
	├── Activate.ps1
	├── deactivate.bat
	├── pip3.10.exe
	├── pip3.exe
	├── pip.exe
	├── python.exe
	└── pythonw.exe

# In Linux, 
.
├── bin
│   ├── activate
│   ├── activate.csh
│   ├── activate.fish
│   ├── easy_install
│   ├── easy_install-3.6
│   ├── pip
│   ├── pip3
│   ├── pip3.6
│   ├── python -> /usr/bin/python
│   └── python3 -> python
├── include
├── lib
│   └── python3.6
│       └── site-packages
├── lib64 -> lib
└── pyvenv.cfg
```

`Lib/` 中包含的是依赖文件，`Scripts/` 中提供了一系列的运行脚本和二进制文件，`pyenv.cfg` 是一些可修改配置项，你可以自定义使用的 home Python Interpretation。

结束使用后可以退出虚拟环境，使用以下指令即可。

```python
# 退出虚拟环境
deactivate
```

```ad-quote
title: 参考资料
- [Python venv: How To Create, Activate, Deactivate, And Delete • Python Land Tutorial](https://python.land/virtual-environments/virtualenv)
- [为python项目配置专属虚拟环境 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/463314523)
```
