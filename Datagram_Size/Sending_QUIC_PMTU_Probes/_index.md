---
title: "14.4 发送QUIC的PMTU探测包"
anchor: "14.4_Sending_QUIC_PMTU_Probes"
weight: 1440
---

**PMTU探测包**是ACK触发包。

终端可以限制**PMTU探测包**的内容为**Ping帧**和**填充帧**，因为比当前最大数据报尺寸更大的数据包更有可能被网络所丢弃。因此丢失一个在**PMTU探测包**中携带的QUIC数据包并不是个可靠的拥塞依据且{{< req_level SHOULD_NOT >}}触发拥塞控制的反应；详见《[DPLPMTUD]()》的[第3章]()的第7款。然而**PMTU探测包**会消耗拥塞窗口，这会延迟应用的后续传输。
