---
title: "A.1. 可变长度整型解码样例"
anchor: "A.1_Sample_Variable-Length_Integer_Decoding"
weight: 230100
rank: "h2"
---

[图45](#Figure_45_Sample_Variable_Length_Integer_Decoding_Algorithm)中的伪代码展示了如何从字节流中读取可变长度整型值。`ReadVarint`函数接收单个参数——一个字节序列，它将以网络字节序被读取。

{{% block_ref
indx="Figure_45_Sample_Variable_Length_Integer_Decoding_Algorithm"
title="图45：可变长度整型解码算法样例" %}}

```
ReadVarint(data):
  // 可变长度整型值的长度被编码在首个字节的前两个比特位中。
  v = data.next_byte()
  prefix = v >> 6
  length = 1 << prefix

  // 一旦长度已知，就移除这些比特位，并读取剩余字节。
  v = v & 0x3f
  repeat length-1 times:
    v = (v << 8) + data.next_byte()
  return v
```

{{% /block_ref %}}

举例来说，八字节序列`0xc2197c5eff14e88c`会被解码为十进制值`151,288,809,941,952,652`；四字节序列`0x9d7f3e7d `会被解码为`494,878,333`；双字节序列`0x7bbd `会被解码为`15,293`；而单字节`0x25`会被解码为`37`（和解码双字节序列`0x4025`的结果一致）。
