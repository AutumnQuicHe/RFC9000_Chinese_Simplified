---
title: "14. 数据报尺寸"
anchor: "14_Datagram_Size"
weight: 1400
rank: "h1"
---

一个UDP数据报可以包含一个或多个QUIC数据包。数据报尺寸指的是携带QUIC数据包的单个UDP数据报的UDP载荷总大小。数据报尺寸包含一个或多个QUIC数据包头部和受保护的载荷，但不包含UDP或IP头部。

最大数据报尺寸被定义为能够经由一条网络路径使用单个UDP数据报发送的最大的UDP载荷大小。如果某条网络路径支持的最大数据报尺寸不能达到1200字节，则{{< req_level MUST_NOT >}}使用QUIC。

QUIC假设一个最小的IP数据包尺寸为至少1280字节。这是IPv6数据包的最小尺寸（见《[IPv6](https://www.rfc-editor.org/info/rfc8200)》），同时被大多数现代IPv4网络所支持。假设使用最小的IP头部，IPv6时为40字节而IPv4时为20字节，以及大小为8字节的UDP头部，则可得到IPv6中的最大数据报尺寸为1232字节，而IPv4中的为1252字节。因此，现代的IPv4网络路径和所有的IPv6网络路径都应该有能力支持QUIC。

> 注意：如果某条路径仅支持1280字节，即IPv6的最小MTU，那么要求支持1200字节的UDP载荷会限制IPv6扩展头部和IPv4选项的可用空间，前者被限制至32字节，后者被限制至52字节。

任何超过1200字节的最大数据报尺寸都可以使用路径最大传输单元发现（PMTUD）（见[第14.2.1章](#14.2.1_Handling_of_ICMP_Messages_by_PMTUD)）或数据报分包层PMTU发现（DPLPMTUD）（见[第14.3章](#14.3_Datagram_Packetization_Layer_PMTU_Discovery)）。

强制执行传输参数`max_udp_payload_size`（[第18.2章](#18.2_Transport_Parameter_Definitions)）可能成为一个额外的对最大数据报尺寸的限制。一旦这个值已知，发送方就可以避免超过这个限制。然而在获知这个传输参数的值之前，如果终端发送了比1200字节，这个在允许的最大数据报尺寸中的最小值，更大的数据报，那么终端就要承担数据报丢失的风险。

UDP数据报{{< req_level MUST_NOT >}}在IP层被分段。在IPv4（《[IPv4](https://www.rfc-editor.org/info/rfc791)》）中{{< req_level MUST >}}尽可能设置不要分段（DF）比特位来防止路径上的分段。

QUIC有时需要数据报不小于一个特定尺寸，比如[第8.1章](#8.1_Address_Validation_during_Connection_Establishment)中的例子。然而，数据报的尺寸不会被认证。也就是说，如果终端接收到了某个尺寸的数据报，它不能确定发送方发送的是不是就是那个尺寸的数据报。因此，当终端接收到一个没有满足尺寸限制的数据报时，它{{< req_level MUST_NOT >}}关闭那条连接；终端{{< req_level MAY >}}丢弃这样的数据报。
