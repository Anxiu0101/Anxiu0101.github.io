# Using Zotero in your Project

此文为笔者在完成毕设期间进行修订的一些个人经验总结，如有误欢迎指正。



Zotero 是一个非常知名的文献管理工具，笔者这里使用的是 Zotero 7 (beta version) 需要从 [Zotero Beta Builds](https://www.zotero.org/support/beta_builds) 里下载，但是 Zotero 6 亦支持所提及的内容。


![image-20240309140756427](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240309140756427.png)


首先是关于引用文献的生成，笔者习惯使用 MyBib，但是近期发现 Zotero 官方也提供了类似的工具，[ZoteroBib: Fast, free bibliography generator - MLA, APA, Chicago, Harvard citations (zbib.org)](https://zbib.org/) 可以用于快速生成指定格式下的引用文本，对于引用格式的支持也很全面。


![image-20240309140828326](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240309140828326.png)



## Zotero 使用介绍

其实网络上很多，这里简单介绍两句，以下是 Zotero 7 的页面（比 6 好看太多了XD


![image-20240309153540249](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240309153540249.png)


在使用 Zotero 时，需要同时安装 Zotero 软件本体和浏览器上的 Zotero 插件 [Zotero Connector](https://microsoftedge.microsoft.com/addons/detail/zotero-connector/nmhdhpibnnopknkmonacoephklnflpho)。

打开你想要阅读或导入到文献库的论文页面，使用 Zotero 浏览器插件一键导入到文献库中，


![image-20240309155137251](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240309155137251.png)


你可以通过单机文献库中的每一个条目并使用快捷键 `ctrl + shift + c` 复制参考文献的文本，引文格式可以在软件菜单 `编辑 > 设定 > 导出` 的快速复制部分修改，如果菜单内并没有你预期的格式，可以在 `设定 > 引用` 中添加你所需的参考文献样式。

但是 Zotero 可以通过与 Word 联动达成文献索引的更新添加等操作，无需复制参考文献后一步一步进行格式和次序的调整，打开 `设定 > 引用` 下来可以看到安装 Microsoft Word 加载项。


![image-20240309155948526](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240309155948526.png)


下载它！

移步到 Word 中 (如果已经打开请重启 Word 软件使得 Zotero 插件加载入 Word 应用中)，你就可以看到如下的顶部菜单。通过 `Add/Edit Citation` 在光标位置插入引用，这是会唤起 Zotero 的搜索栏，你可以直接搜索存在在你文献库中的条目直接插入引用。


![image-20240309160309592](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240309160309592.png)


当你的文档中已经存在有插入的引用后，将光标移动到你的 Reference 部分，通过 `Add/Edit Bibliography` 插入**自动排序**的参考文献表 (如果在使用过程中发现没有更新次序，请使用通缉菜单下的 `Refresh` 按钮或打开 `Document Perferences` 里的自动更新引注选项)。可以通过 `Document Preferences` 进行参考文献样式和语言的设置。


![image-20240309160730362](https://raw.githubusercontent.com/Anxiu0101/PicgoImg/master/image-20240309160730362.png)


## 关于作图

科研作图的重要性其实还挺高的，笔者并不算拥有很多经验，各位可以通过 Matlab、Python 等等加上 GPT 生成代码的方式快速产出包括且不限于流程图，折线图等等。但是代码中默认的颜色可能会较为突兀，可以调整颜色进行适当美化，具体去浏览器搜索关键词 `科研作图 颜色 美化` 即可。

对于架构图、时序图等，网络上存在大量平台可供使用，包括且不限于 [ProcessOn](https://www.processon.com/)，[draw.io](https://www.drawio.com/)，[Excalidraw](https://excalidraw.com/) 等工具。

作为开发者，另外可以参考的一个重要平台是 Figma 这类的设计网站，Figma 上存在大量的架构图等的模板，本就是互联网公司的设计部门大佬们贡献的，使用起来较为便利，并且在花费一定时间后成品效果较好。

> [!Note]
>
> 例如 [GT 架构图工具包-轴侧风格 – Figma](https://www.figma.com/community/file/961535928702839503/gt) 的演示 Demo 效果如下，整个模板中提供了大量组件可供使用
>
> ![GT 架构图工具包-轴侧风格 preview](https://s3-figma-hubfile-images-production.figma.com/hub/file/carousel/img/1429e8394d36752cd2a32185576a1257428bdc0a)
