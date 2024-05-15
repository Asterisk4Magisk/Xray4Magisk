English | [简体中文](README_zh_CN.md)

# Xray4Magisk

~~A fork from [V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray)~~

This is a Magisk module for Xray/V2ray/Sing-box/Mihomo(Clash.Meta), and includes xrayhelper binaries for arm64, x64.

## Disclaimer

I'm not responsible for bricked devices, dead SD cards, or burning your SoC.

**Make sure your config file does not cause traffic to loop back, otherwise it may cause your phone to constantly reboot.**

If you really don't know how to configure this module, you mignt need apps like v2rayNG, SagerNet(or AnXray), ClashMeta For Android etc.

## Install

Download the module zip from [Release](https://github.com/Asterisk4Magisk/Xray4Magisk/releases) and install it via [Magisk](https://github.com/topjohnwu/Magisk)

This module does not contain binaries such as [Xray-core](https://github.com/XTLS/Xray-core), When installing, the relevant files are downloaded automatically. If your network has poor access to Github, please consider using a network proxy or choose not install core online.

If your device don't have volume keys, you can create file `/sdcard/xray4magisk.setup`, first line of the file will determine the core type, `xray` for Xray, `v2ray` for V2ray, `sing-box` for Sing-box and `mihomo` for Mihomo(Clash.Meta), any other content will skip core installation; second line of the file will control whether to overwrite old config files, `keep` will preserve them, otherwise will be overwritten.

## Config

- The xrayhelper config file is stored in `/data/adb/xray/xrayhelper.yml`
- The xray config file is stored in `/data/adb/xray/confs/*.json`
- The v2ray config file is stored in `/data/adb/xray/v2ray.v5.json`
- The sing-box config file is stored in `/data/adb/xray/singconfs/*.json`
- The mihomo(clash.meta) template config file is stored in `/data/adb/xray/mihomoconfs/template.yaml`

Tip: The default config already sets the inbounds section to work with transparent proxy scripts. It is recommended that use xrayhelper to manage your proxy server, for advanced configurations please refer to the appropriate official documentation, such as [Xray](https://xtls.github.io/), [V2ray](https://www.v2fly.org/), [Sing-box](https://sing-box.sagernet.org/), [Mihomo](https://wiki.metacubex.one/)

## Usage

[Quick Start](quickstart.md)

### Manage service start / stop

**The following core services are collectively referred to as Xray**

- Xray service is auto-run after system boot up by default.
- You can use Magisk Manager App to manage it. Starting the service may take a few seconds, stopping it may take effect immediately.

### Config xrayhelper in Termux

- Install Termux :

    [Termux on Github](https://github.com/termux/termux-app/releases)
- Config alias (bash)：

    `echo "alias xrayhelper=\"su -c /data/adb/xray/bin/xrayhelper\"" >> ~/.bashrc && source ~/.bashrc`

### Example usage of xrayhelper
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

### More things about module configuration

XrayHelper is used in version 3.0 and above, for more detailed configuration please refer to [XrayHelper](https://github.com/Asterisk4Magisk/XrayHelper/blob/master/README.md)

## Debug and Develop

### Enter manual mode

If you want to control xray by running command totally, just add a file `/data/adb/xray/manual`. In this situation, xray service won't start on boot automatically and you cann't manage service start/stop via Magisk Manager App.

### Print verbose log

Just add the option `-v` or `--verbose` when you using xrayhelper

## Uninstall

1. Uninstall the module via Magisk Manager App.
2. You can clean xray data dir by running command `rm -rf /data/adb/xray && rm -rf /data/adb/service.d/xray4magisk_service.sh` .

## FAQ

What is the difference between 3.0 and previous version?

> Rewritten with Golang, implements some functions that are difficult to implement with shell scripts, does not depend on BusyBox, and can be installed on [KernelSU](https://github.com/tiann/KernelSU).

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

[XrayHelper](https://github.com/Asterisk4Magisk/XrayHelper), A unified proxy helper for  Android, some scripts in Xray4Magisk rewritten with golang, provide arm64 and amd64 binary.

## License

[Mozilla Public License Version 2.0 (MPL)](https://raw.githubusercontent.com/XTLS/xray-core/master/LICENSE)
