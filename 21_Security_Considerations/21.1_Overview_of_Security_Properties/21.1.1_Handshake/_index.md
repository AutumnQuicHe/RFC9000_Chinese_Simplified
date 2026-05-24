---
title: "21.1.1. 握手"
anchor: "21.1.1_Handshake"
weight: 210110
rank: "h3"
---

QUIC握手中包含着TLS 1.3握手，所以会继承在《[TLS13](https://www.rfc-editor.org/info/rfc8446)》的[附录E.1](https://www.rfc-editor.org/rfc/rfc8446.html#appendix-E.1)中描述的加密安全性。QUIC的安全性有相当一部分依靠TLS握手来提供。任何针对TLS握手的攻击都会影响到QUIC。

对于在会话密钥的机密性和唯一性上或在认证对端身份时让步的TLS握手的攻击会影响到QUIC所提供的依赖这些密钥的安全性保证。比如，连接迁移（详见[第9章](#9_Connection_Migration)）为了避免跨网络路径的可关联性，依赖着在使用TLS握手的密钥协商过程和QUIC数据包保护过程中的可信度保护。

针对TLS握手的完整性进行的攻击可能使得攻击者能够影响应用协议或QUIC版本的选择。

在TLS提供的安全性之外，QUIC握手也提供了一些防御手段来对抗针对握手的拒绝服务攻击。
