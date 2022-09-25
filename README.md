English | [简体中文](README_zh_CN.md)

# Xray4Magisk

A fork from [V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray)

This is a Magisk module for Xray/v2ray/sing-box, and includes binaries for arm, arm64, x86, x64.

## Disclaimer

I'm not responsible for bricked devices, dead SD cards, or burning your SoC.

**Make sure your profile does not cause traffic to loop back, otherwise it may cause your phone to constantly reboot.**

If you really don't know how to configure this module, you mignt need apps like v2rayNG, SagerNet(or AnXray) etc.

## Manager APP

[Xray4Magisk_Manager](https://github.com/whalechoi/Xray4Magisk_Manager)(WIP)

## Install

Download the module zip from [Release](https://github.com/Asterisk4Magisk/Xray4Magisk/releases) and install it via [Magisk](https://github.com/topjohnwu/Magisk) or [Xray4Magisk_Manager](https://github.com/whalechoi/Xray4Magisk_Manager).

### Auto installation

This module does not contain binaries such as [Xray-core](https://github.com/XTLS/Xray-core) or [sing-box](https://github.com/SagerNet/sing-box).

- Using Magisk to install.

  - You can select the core and rule files to be installed with the volume keys
  - You can customize the initial installation by placing the `xray.config` file in the `/sdcard` directory: (can be deleted after installation)

  ```
  core=
  asset=
  ```

  `core` is the core file, valid value: `custom`/`xray`/`v2ray`/`sagernet`/`sing-box`

  Value custom for custom, v2ray for [v2fly/v2ray-core](https://github.com/v2fly/v2ray-core), sagernet for [SagerNet/v2ray-core](https://github.com/SagerNet/v2ray-core)

  `asset` is rules files with the following valid values: `loyalsoldier/dat/customDat/db/customDb`

  loyalsoldier is [Loyalsoldier/v2ray-rules-dat](https://github.com/Loyalsoldier/v2ray-rules-dat), dat and db are the corresponding defaults, customDat and customDb are the corresponding customizations

  **xray.config has a higher priority than the volume selection installation**

  The upgrade installation defaults to the previous installation, or you can modify the `#Update` entry in `xray.config` in the `/data/adb/xray/` directory to determine the next installation, with the same valid values as above.

### Manual installation (custom core)

Download the core file for the corresponding architecture and package it in a zip archive, placing it in the `/sdcard/Download` directory along with the rules files (optional).

The naming convention for core files is as follows: (\* indicates arbitrary characters)

- xray ---> Xray-\*.zip
- v2ray/sagernet ---> v2ray-\*.zip
- sing-box ---> sing-box-\*.tar.gz

**Note: Check the CPU architecture of your device and select the correct zip file.**

For example, for sdm855 to download xray-core, download `Xray-android-arm64-v8a.zip`.

## Config

- The config file is stored in `/data/adb/xray/confs/*.json`
- Tip: The default config already sets the inbounds section to work with transparent proxy scripts. It is recommended that you only edit the `outbounds` section to add your proxy server, for advanced configurations please refer to the appropriate official documentation, such as [Xray](https://xtls.github.io/) and [sing-box](https://sing-box.sagernet.org/)
- The file `/data/adb/xray/appid.list` is used to select the APPs that require proxying. editing the `ignore_out.list` file allows you to ignore certain network exits, for example to enable not going through the proxy when connecting to WiFi.

## Usage

### Normal usage ( Default and Recommended )

#### Manage service start / stop

**The following core services are collectively referred to as Xray**

- Xray service is auto-run after system boot up by default.
- You can use Magisk Manager App to manage it. Starting the service may take a few seconds, stopping it may take effect immediately.

#### Select which App to proxy

- You can use [Xray4Magisk_Manager](https://github.com/whalechoi/Xray4Magisk_Manager)

- If you expect transparent proxy ( read Transparent proxy section for more detail ) for specific Apps, just write down these Apps' uid in file `/data/adb/xray/appid.list` .

  Each App's uid should separate by space or just one App's uid per line. ( for Android App's uid , you can search App's package name in file `/data/system/packages.list` , or you can look into some App like Shadowsocks. )

- If you expect all Apps proxy by xray with transparent proxy, just write `ALL` in file `/data/adb/xray/appid.list` .

- If you expect all Apps proxy by xray with transparent proxy EXCEPT specific Apps, write down `bypass` at the first line then these Apps' uid separated as above in file `/data/adb/xray/appid.list`.

- Transparent proxy won't take effect until the xray service start normally and file `/data/adb/xray/appid.list` is not empty.

### Multi-Core Switching

Modify the `#Settings` entry in `xray.config` in the `/data/adb/xray/` directory to determine the core and configuration files to use.

```
config=
custom=
```

Valid values for `config` are the full configuration file name, xray/v2ray defaults to `config.json` and sing-box defaults to `sing-config.json`.

`custom` is the core document to be used, with a valid value of `xray`/`v2ray`/`sing-box`

### Advanced usage ( for Debug and Develop only )

#### Enter manual mode

If you want to control xray by running command totally, just add a file `/data/adb/xray/manual`. In this situation, xray service won't start on boot automatically and you cann't manage service start/stop via Magisk Manager App.

#### Manage service start / stop

- xray service script is `$MODDIR/scripts/xray.service`.

- For example, in my environment ( Magisk-alpha version: 23001 )

  - Start service :

    `/data/adb/xray/scripts/xray.service start`

  - Stop service :

    `/data/adb/img/xray/scripts/xray.service stop`

#### Manage transparent proxy enable / disable

- Transparent proxy script is `/data/adb/xray/scripts/xray.tproxy`.

- For example, in my environment ( Magisk-alpha version: 23001 )

  - Enable Transparent proxy :

    `/data/adb/xray/scripts/xray.tproxy enable`

  - Disable Transparent proxy :

    `/data/adb/xray/scripts/xray.tproxy disable`

#### Bypass Transparent proxy when connecting to WLAN

TODO

#### Select which App to proxy, and which App to second proxy

TODO

#### Enable IPv6

To enable IPv6 proxy, execute `touch /data/adb/xray/ipv6`

To enable DNS AAAA record querying, edit `dns.json`, change `"queryStrategy"` from "UseIPv4" to "UseIP".

To enable local IPv6 out, edit `base.json`, find the first inbound with "freedom" tag, change its `"domainStrategy"` from "UseIPv4" to "UseIP".

To enable proxy IPv6 out, edit `proxy.json`, change its `"domainStrategy"` as what you do in `base.json`.

## Uninstall

1. Uninstall the module via Magisk Manager App.
2. You can clean xray data dir by running command `rm -rf /data/adb/xray && rm -rf /data/adb/service.d/xray4magisk_service.sh` .

## FAQ

No such file or directory?

> You might need Busybox for Android NDK

Error calling service activity?

> This module is designed to automatically turn on and off Flight mode, in order to clear DNS cache. However, this only work when SELinux is premissive. So just ignore this error message in `service.log`, and if you like, do turn on and off Flight mode manually.

Why I need turn on WIFI hotspot otherwise I cannot connect to Internet?
Why I cannot connect to proxy server while using **domain name**?

> It is a DNS issue. You need add `"sockopt": { "domainStrategy": "UseIP" }` to your proxy's `"streamSettings"`. By the way, this fix needs correct dns and routing configuration. If you don't know how to do, I suggest use IP address instead of domain name. Or use a Xray binary compiled with CGO enabled. Reference: [#12](https://github.com/CerteKim/Xray4Magisk/issues/12)

This module cause battery drain really quick.

> It might be a DNS issue, check `/data/adb/xray/run/error.log`.

GUI support?

> Not done yet.

Why not store config files in Internal Storage?

> For privacy. Some apps may read your data, check [Storage Isolation](https://sr.rikka.app/guide/)

## Contact

- [Telegram](https://t.me/AsteriskFactory)

## Project X

Project X is a set of network tools that help you to build your own computer network. It secures your network connections and thus protects your privacy. See [Project X](https://github.com/XTLS/xray-core) for more information.

## License

[Mozilla Public License Version 2.0 (MPL)](https://raw.githubusercontent.com/XTLS/xray-core/master/LICENSE)
