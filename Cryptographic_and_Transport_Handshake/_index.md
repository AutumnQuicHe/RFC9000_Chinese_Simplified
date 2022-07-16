---
title: "7. 加密与传输握手"
anchor: "7_Cryptographic_and_Transport_Handshake"
weight: 700
rank: "h1"
---

QUIC通过将加密与传输握手组合最小化连接建立的延迟。
QUIC使用**加密帧**（详见[第19.6章](#19.6_CRYPTO_Frames)）传递加密握手信息。
本文所定义的QUIC版本标识为`0x00000001`，使用《[QUIC-TLS](https://www.rfc-editor.org/info/rfc9001)》描述的TLS，而不同的QUIC版本可能表面其使用了不同的加密握手协议。

QUIC可靠、有序地传递加密握手数据。
QUIC数据包保护用于尽可能多地对握手协议进行加密。
加密握手{< req_level MUST >}具备如下属性：
- 密钥交换是认证的，需要
    - 服务端总是经过认证的，且
    - 客户端是否经过认证是可选的，且
    - 每个连接生成不同且不相关的密钥，且
    - 密钥材料对0-RTT和1-RTT数据包均可提供保护。
- 双端传输参数值的交换是认证的，且对服务端传输参数提供机密性保护。
- 应用层协议的认证协商（为此，TLS使用的是应用层协议协商——[ALPN](https://www.rfc-editor.org/info/rfc7301)）。

**加密帧**可以在不同数据包号空间发送（详见[第12.3章](#12.3_Packet_Numbers)）。
在每个数据包号空间，**加密帧**用来确保加密握手数据有序传递的偏移量都是从0开始的。

[图4](#Figure_4_Simplified_QUIC_Handshake)展示了一个简化的握手及用于推动握手进程的数据包与帧的交换。
如果可以的话，尽量在握手期间交换应用层数据，并用星号（"\*"）表示。
一旦完成握手，终端就能自由交换应用层数据。

{{< block_img
indx="Figure_4_Simplified_QUIC_Handshake"
title="图4：简版QUIC握手"
src="/RFC9000_Chinese_Translation/images/Figure_4_Simplified_QUIC_Handshake.svg" >}}

终端可以使用握手期间发送的数据包来测试是否支持显式拥塞通知（ECN），详见[第13.4章](#13.4_Explicit_Congestion_Notification)。
终端通过观察用于确认其发送的首个数据包的**ACK帧**是否携带ECN计数，验证是否支持ECN，更多细节详见[第13.4.2章](#13.4.2_ECN_Validation)。

终端{{< req_level MUST >}}明确地协商应用层协议。
这避免了对使用中的协议还存在分歧的情况。
