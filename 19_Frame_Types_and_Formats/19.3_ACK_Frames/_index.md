---
title: "19.3 ACK帧"
anchor: "19.3_ACK_Frames"
weight: 190300
rank: "h2"
---

接收方发送**ACK帧**（类型为`0x02`或`0x03`）通知发送方其发出的数据包已经收到并处理完成了。
**ACK帧**包含一个或多个ACK块（ACK Range）。
ACK块标识被确认的数据包。
如果帧类型为`0x03`，**ACK帧**也会包含到目前为止在该连接上收到的带有相关ECN标记的QUIC数据包的累计值。
QUIC实现{{< req_level MUST >}}准确处理这两种类型，并且，如果其对发送数据包采用了ECN，其{{< req_level SHOULD >}}使用ECN块中的信息管理其拥塞状态。

QUIC的确认是不可撤销的。
数据包一旦被确认，其就会维持在被确认状态，即使其没有出现在后续的**ACK帧**中。
这一点不同于TCP选择性确认（SACK）违约（《[RFC2018](https://www.rfc-editor.org/info/rfc2018)》）。

属于不同数据包号空间的数据包可以使用相同的数值标识。
数据包的一个确认需要同时标明数据包号和数据包号空间。
这是通过让每个**ACK帧**只确认其所在数据包的相同数据包号空间内的数据包实现的。

不能确认版本协商和重试包，因为它们不包含数据包号。
这些数据包与其依靠**ACK帧**，不如通过后续客户端发送的初始包隐式确认。

**ACK帧**格式如[图25](#Figure_25_ACK_Frame_Format)所示。

{{% block_ref
    indx="Figure_25_ACK_Frame_Format"
    title="图25：ACK帧格式" %}}

```
ACK帧 {
  类型 (i) = 0x02..0x03,
  最大确认数 (i),
  ACK延迟 (i),
  ACK块计数 (i),
  首个ACK块 (i),
  ACK块 (..) ...,
  [ECN计数 (..)],
}
```

{{% /block_ref %}}

**ACk帧**包含下述字段：

最大确认数（Largest Acknowledged）：

:   一个可变长度整型，表示对端确认的最大数据包号；
    这通常是对端在生成**ACK帧**前收到的最大数据包号。
    不同于QUIC长包头或短包头里的数据包号，**ACK帧**内的包号没有截断。

ACK延迟（ACK Delay）：

:   一个可变长度整型，编码ACK延迟，单位微秒，详见[第13.2.5章](#13.2.5_Measuring_and_Reporting_Host_Delay)。
    其通过将字段中的值乘以2的`ack_delay_exponent`次方来解码的，其中`ack_delay_exponent`传输参数值是由**ACK帧**发送方发出的，详见[第18.2章](#18.2_Transport_Parameter_Definitions)。
    相比于简单地用整型表示延迟，这种编码在相同字节数内支持更大范围的值，代价是分辨率较低。

ACK块计数（ACK Range Count）：

:   一个可变长度整型，表示**ACK帧**中ACK块字段的数目。

首个ACK块（First ACK Range）：

:   一个可变长度整型，表示在最大确认数之前正在被确认的连续的数据包的数量。
    也就是说，块内最小被确认的数据包的包号可以通过最大确认数减去首个ACK块值得到。

ACK块：

:   包含额外的数据包区段，这些数据包可以是未被确认的（空档），也可以是已被确认的（ACK块），详见[第19.3.1章](#19.3.1_ACK_Ranges)。

ECN计数：

:   三个ECN统计，详见[第19.3.2章](#19.3.2_ECN_Counts)。
