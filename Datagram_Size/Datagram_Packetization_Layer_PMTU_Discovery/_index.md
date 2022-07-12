---
title: "14.3 数据报分包层PMTU发现"
anchor: "14.3_Datagram_Packetization_Layer_PMTU_Discovery"
weight: 1430
rank: "h2"
---

DPLPMTUD（详见《[DPLPMTUD](https://www.rfc-editor.org/info/rfc8899)》）依赖对**PMTU探测包**中携带的QUIC数据包的丢失或确认进行追踪。DPLPMTUD中使用了**填充帧**的**PMTU探测包**实现了如《[DPLPMTUD](https://www.rfc-editor.org/info/rfc8899)》的[第4.1章](https://www.rfc-editor.org/rfc/rfc8899.html#name-plpmtu-probe-packets)所述的“使用填充数据进行探测”。

终端{{< req_level SHOULD >}}将`BASE_PLPMTU`（基本分包层路径最大传输单元）（详见《[DPLPMTUD](https://www.rfc-editor.org/info/rfc8899)》的[第5.1章](https://www.rfc-editor.org/rfc/rfc8899.html#name-dplpmtud-components)）的初始值设置为与QUIC允许的最大数据报尺寸中的最小值一致的值。`MIN_PLPMTU`（最小分包层路径最大传输单元）就是`BASE_PLPMTU`。

实现DPLPMTUD的QUIC终端为每一对本地IP地址和远程IP地址的组合维护一个DPLPMTUD最大数据包尺寸（MPS）（详见《[DPLPMTUD](https://www.rfc-editor.org/info/rfc8899)》的[第4.4章](https://www.rfc-editor.org/rfc/rfc8899.html#name-the-maximum-packet-size-mps)）。它对应着最大数据报尺寸。
