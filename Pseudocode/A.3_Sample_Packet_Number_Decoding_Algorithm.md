---
title: "A.3. 数据包号解码算法样例"
anchor: "A.3_Sample_Packet_Number_Decoding_Algorithm"
weight: 230300
rank: "h2"
---

[图47]()中的伪代码包含了在移除头部保护后解码数据包号的算法样例。

`DecodePacketNumber`函数接收三个参数：

* `largest_pn`是当前数据包号空间中已成功处理的最大数据包号

* `truncated_pn`是数据包号字段的值

* `pn_nbits`是数据包号字段中比特位的数量（`8`、`16`、`24`或`32`）。

{{% block_ref
indx="Figure_47_Sample_Packet_Number_Decoding_Algorithm"
title="图47：数据包号解码算法样例" %}}

```
DecodePacketNumber(largest_pn, truncated_pn, pn_nbits):
  expected_pn  = largest_pn + 1
  pn_win       = 1 << pn_nbits
  pn_hwin      = pn_win / 2
  pn_mask      = pn_win - 1
  // 传入数据包号应该大于`expected_pn - pn_hwin`且小于等于
  // `expected_pn + pn_hwin`
  //
  // 这意味着我们不能简单地去掉`expected_pn`中末尾的比特位再加上`truncated_pn`
  // 因为那样会产生一个超过窗口范围的值。
  //
  // 接下来的代码计算了一个候选值，并确保它处于数据包号窗口范围中。
  // 注意用于防止数值过大和数值过小的额外检查。
  candidate_pn = (expected_pn & ~pn_mask) | truncated_pn
  if candidate_pn <= expected_pn - pn_hwin and
    candidate_pn < (1 << 62) - pn_win:
    return candidate_pn + pn_win
  if candidate_pn > expected_pn + pn_hwin and
    candidate_pn >= pn_win:
    return candidate_pn - pn_win
  return candidate_pn
```

{{% /block_ref %}}

举例来说，如果已成功认证数据包的数据包号中，最大值为`0xa82f30ea`，那么值为`0x9b32`的16比特长的数据包号字段会被解码为`0xa82f9b32`。
