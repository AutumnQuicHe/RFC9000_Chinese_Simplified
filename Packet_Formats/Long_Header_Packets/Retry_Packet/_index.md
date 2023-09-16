---
title: "17.2.5 重试数据包"
anchor: "17.2.5_Retry_Packet"
weight: 1725
rank: "h3"
---

如[图18](#Figure_18_Retry_Packet)所示，重试数据包（Retry packet）使用类型值为`0x03`的长包头。它携带着由服务器创建的一个地址验证令牌。想要进行重试的服务器会使用它，详见[第8.1章](#8.1_Address_Validation_during_Connection_Establishment)。

{{% block_ref
indx="Figure_18_Retry_Packet"
title="图18：重试数据包" %}}

```
重试数据包 {
  包头形式 (1) = 1,
  固定比特位 (1) = 1,
  长数据包类型 (2) = 3,
  未使用 (4),
  版本 (32),
  目标连接ID长度 (8),
  目标连接ID (0..160),
  源连接ID长度 (8),
  源连接ID (0..160),
  重试令牌 (..),
  重试完整性标签 (128),
}
```

{{% /block_ref %}}

重试数据包不包含任何受保护的字段。未使用字段中的值被服务器设置为任意值；客户端{{< req_level MUST >}}忽略这些比特位。除了来自长包头的字段之外，它还包含以下额外字段：

重试令牌（Retry Token）：

:   服务器用来验证客户端的地址的不透明令牌。

重试完整性标签（Retry Integrity Tag）：

:   在《[QUIC-TLS](../RFC9001_Chinese_Simplified)》的[第5.8章](../RFC9001_Chinese_Simplified/#5.8_Retry_Packet_Integrity)（《重试数据包的完整性》）中定义。
