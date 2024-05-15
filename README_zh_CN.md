[English](README.md) | 简体中文

# Xray4Magisk

~~该项目 fork 自 [V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray)。~~

本项目为 Xray/V2ray/Sing-box/Mihomo(Clash.Meta) 的 Magisk 模块，支持 arm64， x64 架构。

## 免责声明

本项目不对以下情况负责：设备变砖、SD 卡损坏或 SoC 烧毁。

**请确保您的配置文件不会造成流量回环，否则可能会导致您的手机无限重启。**

如果你真的不知道如何配置这个模块，你可能需要像 v2rayNG、SagerNet（或 AnXray）、ClashMeta For Android等应用程序。

## 安装

从 [Release](https://github.com/Asterisk4Magisk/Xray4Magisk/releases) 下载模块压缩包，然后通过 [Magisk](https://github.com/topjohnwu/Magisk) 进行安装  

注意：这个模块不包含任何核心的二进制文件，安装时，联网下载相关文件，若您的网络访问Github速度不佳，建议在模块安装过程中开启网络代理或者选择不在线安装Core并在模块安装成功后手动安装Core、配置XrayHelper

如果你的设备没有音量键，可以创建文件 `/sdcard/xray4magisk.setup`，该文件的第一行将决定在线安装的核心类型，`xray` 表示使用 Xray，`v2ray` 表示使用 V2ray，`sing-box` 表示使用 Sing-box，`mihomo` 表示使用 Mihomo(Clash.Meta)，其他任意内容将跳过核心安装；该文件的第二行将决定是否覆盖旧配置文件，`keep`表示保留旧配置文件，其他内容将会覆盖配置文件。

## 配置文件

- XrayHelper 配置文件保存在 `/data/adb/xray/xrayhelper.yml`
- Xray 核心的配置文件保存在 `/data/adb/xray/confs/*.json`
- V2ray 核心的配置文件保存在 `/data/adb/xray/v2ray.v5.json`
- Sing-box 核心的配置文件保存在 `/data/adb/xray/singconfs/*.json`
- Mihomo(Clash.Meta) 核心的模板配置文件保存在 `/data/adb/xray/mihomoconfs/template.yaml`

提示：默认配置已经设置了 inbounds 部分来配合透明代理脚本工作。建议您使用 xrayhelper 管理代理服务器，进阶配置请参考相应官方文档，如 [Xray](https://xtls.github.io/)、 [V2ray](https://www.v2fly.org/) 、 [Sing-box](https://sing-box.sagernet.org/)以及 [Mihomo](https://wiki.metacubex.one/)

## 使用方法

[快速入门](quickstart_zh_CN.md)

### 管理服务的启停

**以下核心服务统称 Xray**

- Xray 服务默认会在系统启动后自动运行。
- 您可以通过 Magisk 管理应用打开或关闭模块来启动或停止 Xray 服务。启动服务可能需要等待几秒钟，停止服务可能会立即生效。

### 在 Termux 配置 xrayhelper
  - 安装 Termux：

    [Termux on Github](https://github.com/termux/termux-app/releases)
  - 配置别名 (bash)：

    `echo "alias xrayhelper=\"su -c /data/adb/xray/bin/xrayhelper\"" >> ~/.bashrc && source ~/.bashrc`

### xrayhelper 使用示例
#### 管理服务的启停
- 启动服务 :

  `xrayhelper service start`

- 停止服务 :

  `xrayhelper service stop`

#### 管理透明代理是否启用
- 启用透明代理：

  `xrayhelper proxy enable`

- 停用透明代理：

  `xrayhelper proxy disable`

### 有关模块的更多配置

3.0 以上版本使用了 XrayHelper， 更多详细配置请参考 [XrayHelper](https://github.com/Asterisk4Magisk/XrayHelper/blob/master/README_zh_CN.md) 

## 调试 & 开发

### 进入手动模式

如果您希望完全通过运行命令来控制 Xray，只需新建一个文件 `/data/adb/xray/manual`。在这种情况下，Xray 服务不会在启动时自动启动，您也不能通过 Magisk 管理器应用管理服务的启动/停止。

### 打印详细日志

在使用 xrayhelper 命令时，添加`-v`或`--verbose`参数即可

## 卸载

1. 从 Magisk 管理器应用卸载本模块。
2. 使用命令清除 Xray 数据：`rm -rf /data/adb/xray && rm -rf /data/adb/service.d/xray4magisk_service.sh`

## FAQ

3.0 版本和先前版本有何区别？

> 使用 Golang 重写的版本，实现了一些难以用shell实现的功能，不依赖 BusyBox，可以在 [KernelSU](https://github.com/tiann/KernelSU) 上安装使用

这个模块导致电池电量消耗非常快？

> 可能是 DNS 问题，查看 `/data/adb/xray/run/error.log`。

GUI 支持？

> 没有计划

## 联系

- [Telegram](https://t.me/AsteriskFactory)

## Project X

Project X 是一套网络工具，帮助你建立你自己的计算机网络。它能保证你的网络连接安全，从而保护你的隐私。具体信息参见 [Project X](https://github.com/XTLS/xray-core)

## XrayHelper

[XrayHelper](https://github.com/Asterisk4Magisk/XrayHelper) 是一个安卓专属的通用代理助手，使用 Golang 重新实现 Xray4Magisk 的部分功能，提供 arm64 和 amd64 二进制文件.

## 许可

[Mozilla Public License Version 2.0 (MPL)](https://github.com/XTLS/Xray-core/blob/main/LICENSE)
