---
title: "17.2 长包头数据包"
anchor: "17.2_Long_Header_Packets"
weight: 1720
rank: "h2"
---

{{% block_ref
indx="Figure_13_Long_Header_Packet_Format"
title="图13：长包头数据包格式" %}}

```
长包头数据包 {
  包头形式 (1) = 1,
  固定比特位 (1) = 1,
  长数据包类型 (2),
  类型特定比特位 (4),
  版本 (32),
  目标连接ID长度 (8),
  目标连接ID (0..160),
  源连接ID长度 (8),
  源连接ID (0..160),
  类型特定载荷 (..),
}
```

{{% /block_ref %}}

长包头被用于在1-RTT密钥建立前发送的数据包。一旦有了1-RTT密钥，发送方就会改用短包头发送数据包（[第17.3章](#17.3_Short_Header_Packets)）。长类型包头允许特殊数据包——例如版本协商数据包——以这种统一的固定长度的数据包格式呈现。使用长包头的数据包包含以下字段：

包头形式（Header Form）：

:   对于长包头，字节0（第一个字节）的最高有效位（`0x80`）被设置为`1`。

固定比特位（Fixed Bit）：

:   字节0中的下一个比特位（`0x40`）被设置为`1`，除非该包是一个版本协商数据包。此比特位为`0`的数据包表示它不是当前版本的合法数据包且{{< req_level MUST >}}被丢弃。此比特位为`1`允许QUIC与其他协议共存，详见《[RFC7983](https://www.rfc-editor.org/info/rfc7983)》。

长数据包类型（Long Packet Type）：

:   字节0中的后两个比特位（掩码为`0x30`的那两个）包含了数据包类型。[表5](#Table_5_Long_Header_Packet_Types)罗列了数据包类型。

类型特定比特位（Type-Specific Bits）：

:   字节0中最低的四个比特位（掩码为`0x0f`的那四个）的语义由数据包类型决定。

版本（Version）：

:   QUIC的版本是一个跟在第一个字节后的32比特长的字段。该字段表明了正在使用的QUIC版本并且决定了如何解释剩下的协议字段。

目标连接ID长度（Destination Connection ID Length）：

:   跟在版本后面的那个字节包含了这个字节后方的目标连接ID字段的长度。这个长度以字节为单位，且被编码为一个8位无符号整型值。在QUIC版本1中，该值{{< req_level MUST_NOT >}}超过20字节。收到版本为`1`的长包头数据包且本字段的值超过`20`的终端必须丢弃它。为了正确构造一个版本协商数据包，服务器{{< req_level SHOULD >}}有能力从其他QUIC版本中读取更长的连接ID。

目标连接ID（Destination Connection ID）：

:   目标连接ID字段跟在目标连接ID长度字段后面，后者指出了本字段的长度。[第7.2章](#7.2_Negotiating_Connection_IDs)更详细地描述了本字段的用法。

源连接ID长度（Source Connection ID Length）：

:   跟在目标连接ID后面的那个字节包含了这个字节后方的源连接ID字段的长度。这个长度以字节为单位，且被编码为一个8位无符号整型值。在QUIC版本1中，该值{{< req_level MUST_NOT >}}超过20字节。收到版本为1的长包头数据包且本字段的值超过`20`的终端必须丢弃它。为了正确构造一个版本协商数据包，服务器{{< req_level SHOULD >}}有能力从其他QUIC版本中读取更长的连接ID。

源连接ID（Source Connection ID）：

:   源连接ID字段跟在源连接ID长度字段后面，后者指出了本字段的长度。[第7.2章](#7.2_Negotiating_Connection_IDs)更详细地描述了本字段的用法。

类型特定载荷（Type-Specific Payload）：

:   数据包的剩余部分是类型特定的，如果有的话。

在此版本的QUIC中，定义了以下长包头数据包的类型：

{{% block_ref
indx="Table_5_Long_Header_Packet_Types"
title="表5：长包头数据包类型" %}}

| 类型   | 名称    | 章节           |
|:-----|:------|:-------------|
| 0x00 | 初始    | [第17.2.2章](#17.2.2_Initial_Packet) |
| 0x01 | 0-RTT | [第17.2.3章](#17.2.3_0-RTT) |
| 0x02 | 握手    | [第17.2.4章](#17.2.4_Handshake_Packet) |
| 0x03 | 重试    | [第17.2.5章](#17.2.5_Retry_Packet) |

{{% /block_ref %}}

一个长包头数据包的包头形式比特位、目标和源连接ID长度、目标和源连接ID，以及版本字段是版本无关的。第一个字节的其他字段是版本特定的。有关怎样解释不同QUIC版本的数据包的细节，见《[QUIC不变量](../RFC8999_Chinese_Translation)》。

第一个字节的其他字段和载荷的解释方法取决于版本和数据包类型。接下来的章节会描述当前版本下，各种数据包类型对它们的特定语义。在这个版本的QUIC中，一些长包头数据包均包含了这些额外字段：

保留比特位（Reserved Bits）：

:   字节0的某两个比特位（掩码为`0x0c`的那两个）在多种数据包类型中都被保留使用。这些比特位被头部保护所保护，详见《[QUIC-TLS](../RFC9001_Chinese_Translation)》的[第5.4章](../RFC9001_Chinese_Translation/#5.4_Header_Protection)。在进行保护前，这两个比特位的值{{< req_level MUST >}}被设置为0。若在移除数据包保护和头部保护之后发现这些位被设置为非零值，则接收到该数据包的终端{{< req_level MUST >}}将该情况视作一个类型为`PROTOCOL_VIOLATION`的连接错误。仅在移除头部保护后就丢弃这样的数据包会使终端暴露于攻击之下，详见《[QUIC-TLS](../RFC9001_Chinese_Translation)》的[第9.5章](../RFC9001_Chinese_Translation/#9.5_Header_Protection_Timing_Side_Channels)。

数据包号长度（Packet Number Length）：

:   在包含数据包号字段的数据包类型中，字节0最低的两个有效位（掩码为`0x03`的那两个）包含数据包号字段的长度。该长度被编码为一个2位无符号整型值，这个值比数据包号字段的字节长度小`1`。也就是说，数据包号字段的长度等于这个字段的值加`1`。这些比特位被头部保护所保护，详见《[QUIC-TLS](../RFC9001_Chinese_Translation)》的[第5.4章](../RFC9001_Chinese_Translation/#5.4_Header_Protection)。

长度（Length）：

:   这是数据包剩余部分（也就是数据包号字段和载荷字段）的字节长度，被编码为一个可变长度整型值。

数据包号（Packet Number）：

:   这个字段的长度是1至4字节。数据包号被头部保护所保护，详见《[QUIC-TLS](../RFC9001_Chinese_Translation)》的[第5.4章](../RFC9001_Chinese_Translation/#5.4_Header_Protection)。数据包号字段的长度被编码进字节0的数据包号长度比特位，见上文。

数据包载荷（Packet Payload）：

:   这是数据包的载荷——包含一系列帧——它们被数据包保护所保护。
