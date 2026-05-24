---
title: "12. 数据包与帧"
anchor: "12_Packets_and_Frames"
weight: 1200
rank: "h1"
---

QUIC终端间用交换数据包的方式交流。数据包具有可信度和完整性保护，详见[第12.1章](#12.1_Protected_Packets)。数据包是由UDP数据报携带的，详见[第12.2章](#12.2_Coalescing_Packets)。

本QUIC版本在连接建立期间使用长包头，详见[第17.2章](#17.2_Long_Header_Packets)。具有长包头的数据包分别是初始数据包（详见[第17.2.2章](#17.2.2_Initial_Packet)）、0-RTT数据包（[第17.2.3章](#17.2.3_0-RTT)）、握手数据包（[第17.2.4章](#17.2.4_Handshake_Packet)）和重试数据包（[第17.2.5章](#17.2.5_Retry_Packet)）。版本协商过程使用与版本无关的具有长包头的数据包，详见[第17.2.1章](#17.2.1_Version_Negotiation_Packet)。

具有短包头的数据包是为了最小化开销而设计的，它们被用于连接建立之后且1-RTT密钥可用时，详见[第17.3章](#17.3_Short_Header_Packets)。
