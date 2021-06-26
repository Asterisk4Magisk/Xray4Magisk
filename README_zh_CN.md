# Magisk Xray 模块
[V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray) 的一个 fork。
支持 arm、arm64、x86、x86_64 架构。


## 安装

从 [Release](<https://github.com/Asterisk4Magisk/Xray4Magisk/releases>) 下载压缩包，然后通过 Magisk Manager 安装。
在这个过程中，安装器会从 [Xray-core](<https://github.com/XTLS/Xray-core>) 下载最新的 [Release](<https://github.com/XTLS/Xray-core/releases>) 文件。

### 手动下载 Xray-core

从 [Xray-core Release](<https://github.com/XTLS/Xray-core/releases>) 下载符合你设备架构的 [Xray-core](<https://github.com/XTLS/Xray-core>)，并将其放在 `/sdcard/Download`。

你也可以自行编译一个 [Xray-core](<https://github.com/XTLS/Xray-core>)。

## Config

- [Xray-core](<https://github.com/XTLS/Xray-core>) 的配置文件存放于 `/data/adb/xray/confs/`。
- 其中，代理服务器的配置在 `/data/adb/xray/confs/proxy.json`。

- Tips：配置文件的 Inbound 和其他的 Outbound 已经写好，基本上不需要动。建议修改 `/data/adb/xray/appid.list` 来选择需要代理的应用。你也可以修改 `routing.json`、`dns.json` 来修改路由规则和 DNS 配置，编辑`ignore_out.list`文件可以忽略某些网络出口。例如，可以实现连接 WiFi 时不走代理。


## 使用方法

### 一般方法

#### 管理服务

- 模块将开机自启动。
- 你可以在 Magisk Manager 中开启/关闭模块，只不过可能需要等待一段时间生效，在这个过程中，会自动切换到飞行模式再复原。

## 卸载

1. 在 Magisk Manager 中卸载模块。
2. 你可以删除 `/data/adb/xray` 文件夹和`/data/adb/service.d/xray4magisk_service.sh`启动脚本。



## Project X

Project X is a set of network tools that help you to build your own computer network. It secures your network connections and thus protects your privacy. See [Project X](https://github.com/XTLS/Xray-core) for more information.



## 许可

[Mozilla Public License Version 2.0 (MPL)](https://github.com/XTLS/Xray-core/blob/main/LICENSE)
