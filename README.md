# Alwaysdata 搭建 vmess / vless / trojan 节点

- 服务器类型： **trojan**（默认）
- 地址：**名称.alwaysdata.net**
- 端口：**443**
- 用户ID：**1eb6e917-774b-4a84-aff6-b058577c60a5**（默认）
- 传输协议：**ws**
- 传输层安全：**tls**
- 路径：**/**

> 其他参数默认

## 搭建步骤

1. 连接**SSH**，执行以下命令

### vmess

```shell
wget -N https://raw.githubusercontent.com/castelenl/AX/main/vmess.sh && chmod +x ./vmess.sh
```

### vless

```shell
wget -N https://raw.githubusercontent.com/castelenl/AX/main/vless.sh && chmod +x ./vless.sh
```

### trojan

```shell
wget -N https://raw.githubusercontent.com/castelenl/AX/main/trojan.sh && chmod +x ./trojan.sh
```

2. 修改配置

![image](https://user-images.githubusercontent.com/70625361/168480560-7012e386-3ebc-4fa6-961c-db6ca8b4cd68.png)

## 感谢列表

原作者项目：https://github.com/wgp-2020/AX
