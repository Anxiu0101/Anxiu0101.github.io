个人钟情于 ACM 风格的 Latex 模板，通常使用以下两个模板：
```tex
\documentclass[acmsmall,11pt]{acmart}   % Single Column
\documentclass[sigconf,11pt]{acmart}    % Double Column
```

## 文字格式



```tex
\section{}
\subsection{}
\subsubsection{}

\textbf{}
\textit{}
```

内联公式

```tex
$...$
```





## 段落格式

### 无序列表

```markdown
- a.
- b.
- ...
```

```latex
\begin{itemize}
	\item a.
	\item b.
	\item ...
\end{itemize}
```

默认情况下，列表项由一个黑色的点开始，这个点又叫做 bullet。

### 有序列表

```markdown
1. a.
2. b.
3. ...
```

```latex
\begin{enumerate}
	\item a.
	\item b.
	\item ...
\end{enumerate}
```

> [!tip]
>
> 嵌套列表的写法。

### 算法

### 代码块



## 文章素材

### 图片插入

```tex
\usepackage{graphic}

\begin{figure}[H] %H为当前位置，!htb为忽略美学标准，htbp为浮动图形
    \centering %图片居中
    \includegraphics[width=0.7\textwidth]{figures/pii.jpg} 
    %插入图片，[]中设置图片大小，{}中是图片文件名
    \caption{Image Caption} %最终文档中希望显示的图片标题
    \label{fig:figure-label} %用于文内引用的标签
\end{figure}%结束环境

Figure \ref{fig:figure-label} -> Figure 1
```

**htbp 选项** 用来指定插入图片的**理想位置**。这几个字母分别代表 here, top, bottom, float page，也就是就这里、页顶、页尾、浮动页（专门放浮动体的单独页面或分栏）.

h 当前位置， 将图形放置在正文文本中给出该图形环境的地方，如果本页所剩的页面不够， 这一参数将不起作用.

t 顶部，将图形放置在页面的顶部.

b 底部，将图形放置在页面的底部.

p 浮动页，将图形放置在一只允许 有浮动对象的页面上.

#### 多图片插入

```tex
\usepackage{float}   设置图片浮动位置的宏包
\usepackage{subfigure} 插入多行多列图片并且为子图模式 修改子图与子图、子标题的距离;
```

```tex
\subsubsection{example one}
    \begin{figure}[htbp]
        \centering   %居中放置
        \subfigure[a] %为每个图片加上编号
        {
            \begin{minipage}[b]{.3\linewidth} 
            %表示在该行所占空间的比例为0.3；其中。3=0.3；b为放置方式；
                \centering
                \includegraphics[scale=0.1]{figures/pii.jpg}
            \end{minipage}
        }
        \subfigure[A]
        {
            \begin{minipage}[b]{.3\linewidth}
                \centering
                \includegraphics[scale=0.1]{figures/pii.jpg}
            \end{minipage}
        }
        \subfigure[I]
        {
            \begin{minipage}[b]{.3\linewidth}
                \centering
                \includegraphics[scale=0.1]{figures/pii.jpg}
            \end{minipage}
        }
        \caption{These are three $\tau$}
    \end{figure}
```

[LATEX - 插入图片 & 子图模式 代码详解 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/677104524)



[如何移除acmart模板中ACM相关信息 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/144659380)

[Latex使用说明教程---ACM模板实测_\begin{acks}-CSDN博客](https://blog.csdn.net/qq_31813549/article/details/89154767)

[ACM MM 投稿论文模板修改成投稿模式 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/491172953)

![image-20240421002625815](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/202404210026949.png)

[LaTeX - 如何在图片说明（caption）中使用脚注（footnote）-CSDN博客](https://blog.csdn.net/iteye_17686/article/details/82336270)