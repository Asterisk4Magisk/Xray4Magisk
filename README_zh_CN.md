[English](README.md) | 简体中文

# Xray4Magisk

该项目 fork 自 [V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray)。

本项目为 Xray/v2ray/sing-box 的 Magisk 模块，支持 arm, arm64, x86, x64 架构。

## 免责声明

本项目不对以下情况负责：设备变砖、SD 卡损坏或 SoC 烧毁。

**请确保您的配置文件不会造成流量回环，否则可能会导致您的手机无限重启。**

## 管理器 APP

[Xray4Magisk_Manager](https://github.com/whalechoi/Xray4Magisk_Manager)

## 安装

从 [Release](https://github.com/Asterisk4Magisk/Xray4Magisk/releases) 下载模块压缩包，然后通过 [Magisk](https://github.com/topjohnwu/Magisk) 或 [Xray4Magisk_Manager](https://github.com/whalechoi/Xray4Magisk_Manager) 安装。

### 自动安装

这个模块不包含 [Xray-core](https://github.com/XTLS/Xray-core) 或 [v2ray-core](https://github.com/v2fly/v2ray-core) 等二进制文件。

- 使用 Magisk 安装：

  - 可以通过音量键选择需要安装的核心及规则文件
  - 可以在 `/sdcard` 目录下放 `xray.config` 文件自定义初次安装：（安装完成可删除）

  ```
  core=
  asset=
  ```

  `core` 为核心文件，有效值：`custom/xray/v2ray/sagernet/sing-box`

  custom 为自定义，v2ray 为 [v2fly/v2ray-core](https://github.com/v2fly/v2ray-core)，sagernet 为 [SagerNet/v2ray-core](https://github.com/SagerNet/v2ray-core)

  `asset` 为规则文件，有效值：`loyalsoldier/dat/customDat/db/customDb`

  loyalsoldier 为 [Loyalsoldier/v2ray-rules-dat](https://github.com/Loyalsoldier/v2ray-rules-dat)，dat 和 db 分别为对应的默认，customDat 和 customDb 分别为对应的自定义

  **xray.config 的优先级高于音量选择安装**

  升级安装可以修改 `/data/adb/xray/` 目录的 `xray.config`

### 手动安装（custom）

下载对应架构的核心文件并打包成压缩包，与规则文件一起放置于 `/sdcard/Download` 目录下。

核心文件命名规则如下：（\* 表示随意字符）

- xray ---> Xray-\*.zip
- v2ray/sagernet ---> v2ray-\*.zip
- sing-box ---> sing-box-\*.tar.gz

**注意：检查您的设备的 CPU 架构，并选择正确的 zip 文件。**

例如，对于 sdm855 下载 xray-core，请下载 `Xray-android-arm64-v8a.zip`。

## 配置文件

- 配置文件保存在 `/data/adb/xray/confs/config.json`
- 提示：默认配置已经设置了 inbounds 部分来配合透明代理脚本工作。建议您只编辑 `outbounds` 部分来添加您的代理服务器，进阶配置请参考相应官方文档，如 Xray 的 [Project X](https://xtls.github.io/)
- 文件 `/data/adb/xray/appid.list` 用于选择需要代理的应用程序（APP）。编辑 `ignore_out.list` 文件可以忽略某些网络出口，例如可以实现连接 WiFi 时不走代理。

## 使用方法

### 常规方法（默认 & 推荐方法）

#### 管理服务的启停

**以下核心服务统称 Xray**

- Xray 服务默认会在系统启动后自动运行。
- 您可以通过 Magisk 管理应用打开或关闭模块来启动或停止 Xray 服务。启动服务可能需要等待 10 秒钟，停止服务可能会立即生效。

#### 选择要代理的应用程序（APP）

- 如果您希望对特定的应用程序（APP）进行透明代理（阅读透明代理部分了解更多细节），只需在文件 `/data/adb/xray/appid.list` 中写下这些应用程序（APP）的 uid。

  每个应用程序（APP）的 uid 使用空格分隔，或者每行一个应用程序（APP）的 uid。对于 Android 应用程序（APP）的 uid，可以在 `/data/system/packages.list` 文件中搜索应用程序（APP）的包名，或者使用 Magisk 管理器应用查看应用的 uid

- 如果您希望 Xray 代理所有应用程序（APP），只需在文件 `/data/adb/xray/appid.list` 中写上 `ALL`。

- 如果您希望 Xray 代理所有应用程序（APP），除了某些特定的应用，那么请在 `/data/adb/xray/appid.list` 文件的第一行写下 `bypass` 之后再如前文所述的方法写下您**不希望**代理的应用的 uid。

- Xray 服务正常启动且文件 `/data/adb/xray/appid.list` 不为空的情况下，透明代理才会生效。

### 高级用法（仅限调试 & 开发）

#### 进入手动模式

如果您希望完全通过运行命令来控制 Xray，只需新建一个文件 `/data/adb/xray/manual`。在这种情况下，Xray 服务不会在启动时自动启动，您也不能通过 Magisk 管理器应用管理服务的启动/停止。

#### 管理服务的启停

- Xray service 脚本是 `$MODDIR/scripts/xray.service`.

- 例如，在测试环境中（Magisk-alpha version: 23001）

  - 启动服务 :

    `/data/adb/xray/scripts/xray.service start`

  - 停止服务 :

    `/data/adb/img/xray/scripts/xray.service stop`

#### 管理透明代理是否启用

- 透明代理脚本是 `/data/adb/xray/scripts/xray.tproxy`.

- 例如，在测试环境中（Magisk-alpha version: 23001）

  - 启用透明代理：

    `/data/adb/xray/scripts/xray.tproxy enable`

  - 停用透明代理：

    `/data/adb/xray/scripts/xray.tproxy disable`

#### 连接到 WLAN 时绕过透明代理

TODO

#### 选择要代理的应用程序（APP），以及选择要使用第二个代理的应用程序（APP）

TODO

#### 启用 IPv6

- 启用 DNS AAAA 记录查询，编辑 `dns.json`，将 `"queryStrategy"` 从 `"UseIPv4"` 改为 `"UseIP"`。

- 启用本地 IPv6 直连，编辑 `base.json`，找到 `"tag": "freedom"` 的 `inbounds` 数组元素，将 `"domainStrategy"`从 `"UseIPv4"` 改为 `"UseIP"`。

- 启用 IPv6 代理转发，编辑 `proxy.json`，将 `"domainStrategy"` 从 `"UseIPv4"` 改为 `"UseIP"`。

## 卸载

1. 从 Magisk 管理器应用卸载本模块。
2. 使用命令清除 Xray 数据：`rm -rf /data/adb/xray && rm -rf /data/adb/service.d/xray4magisk_service.sh`

## FAQ

No such file or directory?

> Android NDK 需要 Busybox

Error calling service activity?

> 这个模块被设计用于自动打开和关闭飞行模式，以清除 DNS 缓存。然而，只当 SELinux 处于 `premissive` 的条件下才能正常运行。所以，可以忽略 `service.log` 中的错误信息。如果您愿意修复此“错误”，可以手动开启和关闭飞行模式。

为什么我需要打开 WIFI 热点，否则我无法连接到互联网？
为什么我在使用**域名**时无法连接到代理服务器？

> 这是一个 DNS 问题。您需要添加 `"sockopt": {"domainStrategy": "UseIP"}` 到您的代理的 `"streamSettings"` 元素内。另外，修复此问题需要正确配置 DNS 和路由。如果你不知道怎么做，建议使用 IP 地址而不是域名。或者使用启用了 CGO 的 Xray 程序。 参考： [#12](https://github.com/CerteKim/Xray4Magisk/issues/12)

这个模块导致电池电量消耗非常快？

> 可能是 DNS 问题，查看 `/data/adb/xray/run/error.log`。

GUI 支持？

> 还未完成

## 联系

- [Telegram](https://t.me/AsteriskFactory)

## Project X

Project X 是一套网络工具，帮助你建立你自己的计算机网络。它能保证你的网络连接安全，从而保护你的隐私。具体信息参见 [Project X](https://github.com/XTLS/xray-core)

## 许可

[Mozilla Public License Version 2.0 (MPL)](https://github.com/XTLS/Xray-core/blob/main/LICENSE)
