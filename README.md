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

关于如何行文及翻译，总的规范详见《[文档翻译规范](https://autumnquiche.github.io/Translation_Norms/#Translation_Norms)》。
此外，RFC9000还需补充如下规范：

## 1. 帧类型等翻译展示

`ACK`、`STREAM`、`NEW_CONNECTION_ID`等帧类型如果直接使用原文实为不妥，并不直观。然而，其又以大写形式表现，固所以需要进行特别处理。

本文决定暂时采用将其加粗展示的方式进行区分。

## 2. 错误类型翻译展示

形如`CONNECTION_ID_LIMIT_ERROR`的错误类型也比较麻烦，因其可能细碎地提前引用。因此，需要将其特别考虑。在其正式介绍前，如果首次出现在一个大章节中，则该大写字段以括号（）附上中文翻译。同章节后续再出现则不再附上翻译。

## 3. 传输参数翻译展示

传输参数（transport parameters）展示方式同第5点。
