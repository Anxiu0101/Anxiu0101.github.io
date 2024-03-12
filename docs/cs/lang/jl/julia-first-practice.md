# Julia 初尝试

> [!note]
>
> [The Julia Programming Language (julialang.org)](https://julialang.org/) | [Julia 中文社区 (julialang.org)](https://cn.julialang.org/)
>
> Scientific computing has traditionally required the highest performance, yet domain experts have largely moved to slower dynamic languages for daily work. We believe there are many good reasons to prefer dynamic languages for these applications, and we do not expect their use to diminish. Fortunately, modern language design and compiler techniques make it possible to mostly eliminate the performance trade-off and provide a single environment productive enough for prototyping and efficient enough for deploying performance-intensive applications. The Julia programming language fills this role: it is a flexible dynamic language, appropriate for scientific and numerical computing, with performance comparable to traditional statically-typed languages.
>
> Because Julia's compiler is different from the interpreters used for languages like Python or R, you may find that Julia's performance is unintuitive at first. If you find that something is slow, we highly recommend reading through the [Performance Tips](https://docs.julialang.org/en/v1/manual/performance-tips/#man-performance-tips) section before trying anything else. Once you understand how Julia works, it is easy to write code that is nearly as fast as C.

个人推荐直接通过 winget 下载，这种方式是通过安装 `juliaup` 管理工具来下载，指令如下

> [!tip]
>
> Windows 也可以通过官网的可执行文件进行下载，这里就不做介绍了，移步官网下载页面有更加详细的内容。Julia 中文社区中提供的下载方式并不全面，需要访问英文官网获取全部咨询。

```powershell
PS C:\Users\Anxiu> winget install julia -s msstore
已找到 Julia [9NJNWW8PVKMN] 版本 Unknown
此程序包是通过 Microsoft Store 提供的。winget 可能需要代表当前用户从 Microsoft Store 获取该程序包。
的协议 Julia [9NJNWW8PVKMN] 版本 Unknown
版本: Unknown
发布者: Julia Computing, Inc.
发布服务器 URL: https://julialang.org/
许可证: ms-windows-store://pdp/?ProductId=9NJNWW8PVKMN
隐私 URL: https://juliacomputing.com/privacy/
协议：
  Category: Developer tools
  Pricing: Free
  Free Trial: No
  Terms of Transaction: https://aka.ms/microsoft-store-terms-of-transaction
  Seizure Warning: https://aka.ms/microsoft-store-seizure-warning
  Store License Terms: https://aka.ms/microsoft-store-license

发行商要求你在安装前查看上述信息并接受协议。
是否同意上述条款?
[Y] 是  [N] 否: Y
正在启动程序包安装...
  ██████████████████████████████  100%
已成功安装
```

当你有使用 Windows Terminal 软件时，`juliaup` 安装会自动将 Julia 添加到你的 Terminal 中，

![image-20240311152051952](C:\Users\Anxiu\AppData\Roaming\Typora\typora-user-images\image-20240311152051952.png)

现在就可以直接通过 `julia` 指令来启动 Julia 了，退出方式为快捷键 `Ctrl + D` 或者输入 `exit()` 皆可。

你还可以使用 `juliaup` 工具来检查本机 Julia 环境，

```powershell
# 查看 julia 当前安装状态 
juliaup status
 Default  Channel  Version                   Update
----------------------------------------------------
       *  release  1.10.2+0.x64.w64.mingw32

# 查看可以安装的版本
juliaup list
 Channel            Version
----------------------------------------------------
 0                  0.7.0+0.x64.w64.mingw32
 0.7                0.7.0+0.x64.w64.mingw32
 0.7.0              0.7.0+0.x64.w64.mingw32
# ...
 release            1.10.2+0.x64.w64.mingw32
 release~x64        1.10.2+0.x64.w64.mingw32
 release~x86        1.10.2+0.x86.w64.mingw32
 nightly            latest-win64
 nightly~x86        latest-win32
 nightly~x64        latest-win64

# 指定版本安装
julia add '1.10'
```



## Pluto.jl

笔者因为课程需求，使用了 Julia 中的一个名为 [Pluto.jl](https://plutojl.org/) 的 Notebook，功能类似于 Python 的 Jupyter Notebook，Julia 还有一个同类产品的项目叫做 [Binder](https://mybinder.org/)。

### Pluto Installation

直接参考官网 [下载页面](https://plutojl.org/#install)，在安装并运行 Julia 后执行指令 `import Pkg; Pkg.add("Pluto")` 和  `import Pluto; Pluto.run()` 即可完成安装并启动 Pluto 的页面，默认页面在 http://localhost:1234/ 位置。

```julia
julia> import Pluto; Pluto.run()
┌ Info:
│   Welcome to Pluto v0.19.40 🎈
│   Start a notebook server using:
│
│ julia> Pluto.run()
│
│   Have a look at the FAQ:
│   https://github.com/fonsp/Pluto.jl/wiki
└
[ Info: Loading...
┌ Info:
└ Opening http://localhost:1234/?secret=wOrEm4HR in your default browser... ~ have fun!
┌ Info:
│ Press Ctrl+C in this terminal to stop Pluto
└
```



## Julia Practice

> [!note]
>
> TODO!

### Grammer

#### function



### Data Structure