# Xray4Magisk
该项目 fork 自 [V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray)。

本项目为 Magisk 的 Xray 模块，支持 arm, arm64, x86, x64 架构。


## 免责声明
我不对以下情况负责：设备变砖、SD 卡损坏或 SoC 烧毁。

**请确保您的配置文件不会造成流量回环，否则可能会导致您的手机重置，然后造成无限重启。**


# 管理器 APP
[Xray4Magisk_Manager](https://github.com/whalechoi/Xray4Magisk_Manager)


## 安装

下载“Releases”中的压缩文件，并通过 Magisk 管理器应用进行安装。

### 下载 Xray 核心二进制文件：自动
注意：这个模块不包含 Xray-core 的二进制文件。相反，安装过程中，程序会从 Xray 的 GitHub 仓库中下载最新的二进制文件。

### 下载 Xray 核心二进制文件：手动
在 Xray-core 的 GitHub 仓库下载对应架构的 zip 文件，并将其放置于 `/sdcard/Download` 目录下。

**注意：检查你的设备的 CPU 架构，并选择正确的 zip 文件。**
例如，对于 sdm855，请下载“Xray-android-arm64-v8a.zip”。



## 配置文件

- Xray 的配置文件保存在 `/data/adb/xray/confs/*.json` 目录内。
- 代理配置文件保存在 `/data/adb/xray/confs/proxy.json` 目录内。

- 提示：默认配置已经设置了 inbounds 部分来配合透明代理脚本的工作。建议你只编辑 `proxy.json` 来添加你的代理服务器，并编辑文件 `/data/adb/xray/appid.list` 来选择要代理的应用程序。当然你也可以修改 `routing.json`、`dns.json` 来修改路由规则和 DNS 配置，编辑 `ignore_out.list` 文件可以忽略某些网络出口，例如可以实现连接WiFi时不走代理。



## 使用方法

### 常规方法（默认&推荐方法）

#### 管理服务的启停

- Xray 服务默认会在系统启动后自动运行。
- 你可以通过 Magisk 管理应用打开或关闭模块来启动或停止 Xray 服务。启动服务可能会等待 10 秒钟，停止服务可能会立即生效。在这个过程中，会自动切换到飞行模式再复原。



#### 选择要代理的应用程序

- 如果你希望对特定的应用程序进行透明代理（阅读透明代理部分了解更多细节），只需在文件 `/data/adb/xray/appid.list` 中写下这些应用程序的 uid。 

  每个应用程序的 uid 应该用空格隔开，或者每行只有一个应用程序的 uid。(对于 Android 应用程序的 uid，可以在 `/data/system/packages.list` 文件中搜索应用程序的包名，或者使用 Magisk 管理器应用查看应用的 uid)

- 如果你希望 Xray 代理所有应用程序，只需在文件 `/data/adb/xray/appid.list` 中写上 `ALL`。

- 如果你希望 Xray 代理所有应用程序，除了某些特定的应用，那么请在 `/data/adb/xray/appid.list` 文件的第一行写下 `bypass` 之后再如前文所述的方法写下你**不希望**代理的应用的 uid。

- Xray 服务正常启动且文件 `/data/adb/xray/appid.list` 不是空的情况下，透明代理才会生效。


### 高级用法（仅限调试&开发）

#### 进入手动模式

如果你想完全通过运行命令来控制 Xray，只需新建一个文件 `/data/adb/xray/manual`。在这种情况下，Xray 服务不会在启动时自动启动，你也不能通过 Magisk 管理器应用管理服务的启动/停止。



#### 管理服务的启停

- Xray service 脚本是 `$MODDIR/scripts/xray.service`.

- 例如，在我的环境中（Magisk-alpha version: 23001）

  - 启动服务 : 

    `/data/adb/xray/scripts/xray.service start`

  - 停止服务 :

    `/data/adb/img/xray/scripts/xray.service stop`



#### 管理透明代理是否启用

- 透明代理脚本是 `/data/adb/xray/scripts/xray.tproxy`.

- 例如，在我的环境中（Magisk-alpha version: 23001）

  - 启用透明代理： 

    `/data/adb/xray/scripts/xray.tproxy enable`

  - 停用透明代理：

    `/data/adb/xray/scripts/xray.tproxy disable`


#### 连接到 WLAN 时绕过透明代理
TODO

#### 选择要代理的应用程序，以及选择要使用第二个代理的应用程序
TODO

#### 启用 IPv6
为了获得最佳兼容性，本模块默认禁用IPv6。

要启用 IPv6 代理，请执行 `touch /data/adb/xray/ipv6`

要启用 DNS AAAA 记录查询，编辑 `dns.json`，将 `"queryStrategy"` 从 "UseIPv4" 改为 "UseIP"。

要启用本地 IPv6 直连，编辑 `base.json`，找到第一个带有 "freedom" 标签的 inbounds，将 `"domainStrategy"`从 "UseIPv4" 改为 "UseIP"。

要启用 IPv6 代理转发，编辑 `proxy.json`，将 `"domainStrategy"` 从 "UseIPv4" 改为 "UseIP"。



## 卸载

1. 从 Magisk 管理器应用卸载本模块。
2. 使用以下指令清理 Xray 数据：`rm -rf /data/adb/xray && rm -rf /data/adb/service.d/xray4magisk_service.sh`



## FAQ
No such file or directory?
> Android NDK 需要 Busybox

Error calling service activity?
> 这个模块被设计用来自动打开和关闭飞行模式，以清除 DNS 缓存。然而，这只当 SELinux 处于预设的条件下才会正常运行。所以请忽略 `service.log` 中的错误信息。如果你愿意，可以手动开启和关闭飞行模式。

为什么我需要打开 WIFI 热点，否则我无法连接到互联网？?
为什么我在使用**域名**时无法连接到代理服务器？
> 这是一个 DNS 问题。你需要添加 `"sockopt"。{ "domainStrategy": "UseIP" }` 到你的代理的 `"streamSettings"`。顺便说一下，这个修复需要正确的 DNS 和路由配置。如果你不知道怎么做，我建议使用 IP 地址而不是域名。或者使用启用了 CGO 的 Xray 程序。 参考： [#12](https://github.com/CerteKim/Xray4Magisk/issues/12)

这个模块导致电量消耗得非常快。
> 可能是 DNS 问题，可以查看 `/data/adb/xray/run/error.log`。

GUI 支持?
> 还未完成



## 联系方式
- [Telegram](https://t.me/AsteriskFactory)


## Project X

Project X 是一套网络工具，帮助你建立你自己的计算机网络。它能保证你的网络连接安全，从而保护你的隐私。具体信息参见 [Project X](https://github.com/XTLS/xray-core)



## License

[Mozilla Public License Version 2.0 (MPL)](https://raw.githubusercontent.com/XTLS/xray-core/master/LICENSE)
