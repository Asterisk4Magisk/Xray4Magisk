English | [简体中文](README_zh_CN.md)

# Xray4Magisk

~~A fork from [V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray)~~

This is a Magisk module for Xray/v2ray, and includes binaries for arm64, x64.

## Disclaimer

I'm not responsible for bricked devices, dead SD cards, or burning your SoC.

**Make sure your config file does not cause traffic to loop back, otherwise it may cause your phone to constantly reboot.**

If you really don't know how to configure this module, you mignt need apps like v2rayNG, SagerNet(or AnXray) etc.

## Install

Download the module zip from [Release](https://github.com/Asterisk4Magisk/Xray4Magisk/releases) and install it via [Magisk](https://github.com/topjohnwu/Magisk)

### Auto installation

This module does not contain binaries such as [Xray-core](https://github.com/XTLS/Xray-core).

- Using Magisk to install.  
  You can configure the `xrayhelper.yml` inside, to choose core

## Config

- The xray config file is stored in `/data/adb/xray/confs/*.json`
- The sing-box config file is stored in `/data/adb/xray/singconfs/*.json`
- Tip: The default config already sets the inbounds section to work with transparent proxy scripts. It is recommended that you only edit the `outbounds` section to add your proxy server, for advanced configurations please refer to the appropriate official documentation, such as [Xray](https://xtls.github.io/) and [sing-box](https://sing-box.sagernet.org/)
- The file `/data/adb/xray/xrayhelper.yml` is [XrayHelper](https://github.com/Asterisk4Magisk/XrayHelper)'s configuration, you should configure it first, it is recommended to learn how to use the XrayHelper cli, it can help you manage core, asset, and proxy nodes

## Usage

### Normal usage ( Default and Recommended )

#### Manage service start / stop

**The following core services are collectively referred to as Xray**

- Xray service is auto-run after system boot up by default.
- You can use Magisk Manager App to manage it. Starting the service may take a few seconds, stopping it may take effect immediately.

### Advanced usage ( for Debug and Develop only )

#### Enter manual mode

If you want to control xray by running command totally, just add a file `/data/adb/xray/manual`. In this situation, xray service won't start on boot automatically and you cann't manage service start/stop via Magisk Manager App.

#### Manage service start / stop
- Start service :

    `xrayhelper service start`

- Stop service :

    `xrayhelper service stop`

#### Manage transparent proxy enable / disable

  - Enable Transparent proxy :

    `xrayhelper proxy enable`

  - Disable Transparent proxy :

    `xrayhelper proxy disable`

#### Bypass Transparent proxy when connecting to WLAN

TODO

#### Select which App to proxy, and which App to second proxy

TODO

## Uninstall

1. Uninstall the module via Magisk Manager App.
2. You can clean xray data dir by running command `rm -rf /data/adb/xray && rm -rf /data/adb/service.d/xray4magisk_service.sh` .

## FAQ

What is the difference between this branch and the master branch?

> Rewritten with Golang, implements some difficult functions that are difficult to implement with shell scripts, does not depend on BusyBox, and can be installed  on [KernelSU](https://github.com/tiann/KernelSU).

This module cause battery drain really quick.

> It might be a DNS issue, check `/data/adb/xray/run/error.log`.

GUI support?

> No plan.

Why not store config files in Internal Storage?

> For privacy. Some apps may read your data, check [Storage Isolation](https://sr.rikka.app/guide/)

## Contact

- [Telegram](https://t.me/AsteriskFactory)

## Project X

Project X is a set of network tools that help you to build your own computer network. It secures your network connections and thus protects your privacy. See [Project X](https://github.com/XTLS/xray-core) for more information.

## XrayHelper

[XrayHelper](https://github.com/Asterisk4Magisk/XrayHelper) for Android, some scripts in Xray4Magisk rewritten with golang, provide arm64 and amd64 binary.

## License

[Mozilla Public License Version 2.0 (MPL)](https://raw.githubusercontent.com/XTLS/xray-core/master/LICENSE)
