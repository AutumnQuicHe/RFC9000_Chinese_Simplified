---
title: "13.4.2 ECN验证"
anchor: "13.4.2_ECN_Validation"
weight: 1342
rank: "h3"
---

故障的网络设备可能损坏或错误地丢弃携带非零ECN码点的数据包。为了在有这类设备存在的前提下确保连接，终端为每条网络路径验证ECN计数，并当检测到错误时在那条路径上禁用ECN。

要为一条新路径进行ECN验证：

* 对于在一条新路径上发向对端的出站数据包，终端在早期的几个数据包的IP头部设置一个`ECT(0)`码点。

* 终端观察是否所有具有`ECT`码点的数据包最终都被视为丢包（详见《[QUIC恢复](../RFC9002_Chinese_Translation)》的[第6章](../RFC9002_Chinese_Translation/#6_Loss_Detection)），若是则表明ECN验证失败了。

如果终端怀疑一个故障的网络设备正在丢弃具有`ECT`码点的IP数据包，那么它可以为路径上仅前十个出站数据包设置`ECT`码点，或以每三个PTO（详见《[QUIC恢复](../RFC9002_Chinese_Translation)》的[第6.2章](../RFC9002_Chinese_Translation/#6.2_Probe_Timeout)）一次的间隔设置。如果所有标记为非零ECN码点的数据包都接连遭遇丢包，那么它就可以基于标记行为会引发丢包的假设来禁用标记。

就这样，终端尝试为每一条新连接使用ECN并做验证，这包括切换到服务器的首选地址时和从活跃连接迁移到新路径时。[附录A.4](#A.4_Sample_ECN_Validation_Algorithm)描述了一种可行的算法。

可能存在其他探测路径是否支持ECN的方法以及不同的标记策略。QUIC实现{{< req_level MAY >}}使用定义在RFC中的其他方法，详见《[RFC8311](https://www.rfc-editor.org/info/rfc8311)》。使用了`ECT(1)`码点的实现需要用报告的`ECT(1)`计数进行ECN验证。
