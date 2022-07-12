---
title: "18. 传输参数编码"
anchor: "18_Transport_Parameter_Encoding"
weight: 1800
rank: "h1"
---

在《[QUIC-TLS](https://www.rfc-editor.org/info/rfc9001)》定义的`quic_transport_parameters`其`extension_data`字段包含QUIC传输参数。
它们被编码为一个传输参数序列，如[图20](#Figure_20_Sequence_of_Transport_Parameters)所示：

{{% block_ref
    indx="Figure_20_Sequence_of_Transport_Parameters"
    title="图20：传输参数序列" %}}

```
传输参数序列 {
  传输参数 (..) ...,
}
```

{{% /block_ref %}}

每个传输参数被编码为一个形如`(标识符,长度,值)`的元组，如[图21](#Figure_21_Transport_Parameter_Encoding)所示：

{{% block_ref
    indx="Figure_21_Transport_Parameter_Encoding"
    title="图21：传输参数编码" %}}

```
传输参数 {
  传输参数ID (i),
  传输参数长度 (i),
  传输参数值 (..),
}
```

{{% /block_ref %}}

`传输参数长度`字段包含`传输参数值`的字节长度。

QUIC编码传输参数为一个字节序列，并包含于加密握手中。
