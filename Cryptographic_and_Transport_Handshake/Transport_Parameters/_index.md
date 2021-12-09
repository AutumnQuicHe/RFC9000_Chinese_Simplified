---
title: "7.4. 加密与传输握手"
anchor: "7.4_Transport_Parameters"
weight: 740
rank: "h2"
---

连接建立期间，双端对各自的传输参数作出验证声明。
终端必须遵守每个参数定义的约束规范，每个参数的描述包括其处理规则。

传输参数由每个终端单方面声明。
每个终端可以独立选择传输参数的值而不依赖于对端的选择。

传输参数的编码详见[第18章]().

QUIC includes the encoded transport parameters in the cryptographic handshake. Once the handshake completes, the transport parameters declared by the peer are available. Each endpoint validates the values provided by its peer.

Definitions for each of the defined transport parameters are included in Section 18.2.
