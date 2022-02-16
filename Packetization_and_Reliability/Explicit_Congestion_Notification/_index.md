---
title: "13.4 显式拥塞通知"
anchor: "13.4_Explicit_Congestion_Notification"
weight: 1340
rank: "h2"
---

QUIC终端使用ECN（显式拥塞通知，详见《[RFC3168]()》）来检测和响应网络拥塞。ECN允许终端在一个IP数据包的ECN字段中设置`ECN-Capable Transport`（`ECT`）码点。随后网络节点可以用设置ECN字段的`ECN-CE`码点的方法来表示拥塞，而不是直接丢弃数据包（详见《[RFC8087]()》）。作为响应，终端通过降低发送速率来应对被对端报告的拥塞情况，详见《[QUIC恢复]()》。

要启用ECN，要发送数据的QUIC终端首先判断一条路径是否支持ECN标记，还要判断对端是否会报告在IP头部接收到的ECN值，详见[第13.4.2章]()。
