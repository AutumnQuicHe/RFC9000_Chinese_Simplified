# RFC9000 QUIC中文翻译

QUIC传输协议中文翻译。

# 搭建运行环境

本站点基于hugo。下面介绍如何运行本站开发环境：

## 如何运行安装及运行hugo

Linux下可以直接`apt install hugo`安装环境，mac下可以用brew命令安装，windows下则需要去hugo站点下载hugo.exe执行文件并添加到环境变量里，
使得在命令行下执行`hugo --help`不会提示说找不到执行文件。

更多请移步[Hugo文档](https://gohugo.io/)。

# 翻译说明

在翻译的过程中，深刻体会到英语与汉语语法思维上的差别，其也体现在行文的方方面面。以下记录翻译QUIC系列文档时应该做的处理：

## 1. 方括号引用参考文献

形如：

```markdown
The integration of TLS and QUIC is described in more detail in [[QUIC-TLS](#QUIC-TLS)].
```

[QUIC-TLS]是句子里实际提到的参考文献，这个结构本身参与语法构建，按照中文的习惯一般使用书名号《》将这种引用括起来。因此其应该翻译为：

```
《[QUIC-TLS](#QUIC-TLS)》
```

但是下述这种：

```markdown
QUIC integrates the TLS handshake [[TLS13](#TLS13)].
```

[TLS13]并不是语句的一部分，更类似于书本中的上标或下标引用。本站将其统一用html的上标引用之：

```
TLS握手<sup>[TLS 1.3](#TLS13)</sup>
```

## 2. 图表

为了支持文档中的图表，这里fork了kraiklyn主题并添加了一个shortcode方法专门用来绘制图表，例如：

```markdown
{{% block_ref
    indx="Table_1_Stream_ID_Types"
    title="表1：流类型" %}}
\`\`\`
|位  |流类型|
|:---|:-----|
|0x00|客户端创建的双向流|
|0x01|服务端创建的双向流|
|0x02|客户端创建的单向流|
|0x03|服务端创建的单向流|
\`\`\`
{{% /block_ref %}}
```

这里，`block_ref`是专门定义的shortcode，`indx`用来指定锚点（请注意锚点不能使用的特殊字符），`title`表示图表名称。
`block_ref`会将`title`转成一个带跳转的href结构。引用该图表的方式：

```markdown
[表1](#Table_1_Stream_ID_Types)
```

## 3. 何时添加英语原文

只在如下情况添加：
- 在正式介绍一个名词的时候，在该章节其首次出现的地方用中文括号（）添加英语原文；
- 使用英语括号()括起来的一个名词或短语在翻译时使用中文括号（）括起来翻译内容，并在逗号后添加英语原文，逗号用中文；

## 4. 帧类型等翻译展示

`ACK`、`STREAM`、`NEW_CONNECTION_ID`等帧类型如果直接使用原文实为不妥，并不直观。然而，其又以大写形式表现，固所以需要进行特别处理。

本文决定暂时采用将其加粗展示的方式进行区分。

## 5. 错误类型翻译展示

形如`CONNECTION_ID_LIMIT_ERROR`的错误类型也比较麻烦，因其可能细碎地提前引用。因此，需要将其特别考虑。在其正式介绍前，如果首次出现在一个大章节中，则该大写字段以括号（）附上中文翻译。同章节后续再出现则不再附上翻译。

## 6. 传输参数翻译展示

传输参数（transport parameters）展示方式同第5点。