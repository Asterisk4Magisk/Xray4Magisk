English | [简体中文](README_zh_CN.md)

# Xray4Magisk
A fork of [V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray)

This is a Xray module for Magisk, and includes binaries for arm, arm64, x86, x64.



## Disclaimer
I'm not responsible for bricked devices, dead SD cards, or burning your SoC.

Make sure you are not going to loopback traffic again and again. It might cause your phone reset, then bootloop.

If you really don't know how to configure this module, you mignt need apps like v2rayNG, SagerNet(or AnXray) etc.



# Manager APP
[Xray4Magisk_Manager](https://github.com/whalechoi/Xray4Magisk_Manager)(WIP)



## Install

You can download the release installer zip file and install it via the Magisk Manager App.

### Download Xray binary: Auto
NOTE: This module doesn't contain Xray-core binary. Instead, the installation process download the latest binary file from Xray's github releases.

### Download Xray binary: Manual
Download the Xray-core zip file and put it in `/sdcard/Download`.

NOTICE: It is important to check your device's CPU Architecture, and select the correct .zip file.  
For example, for sdm855, we choose "Xray-android-arm64-v8a.zip".



## Config

- Xray config files are store in `/data/adb/xray/confs/*.json`.
- proxy config is `/data/adb/xray/confs/proxy.json`.

- Tips: Please notice that the default configuration has already set inbounds section to cooperate work with transparent proxy script. It is recommended that you only edit the `proxy.json` to your proxy server and edit file `/data/adb/xray/appid.list` to select which App to proxy. Edit file `ignore_out.list` can help you to ignore some OUTPUT interfaces.



## Usage

### Normal usage ( Default and Recommended )

#### Manage service start / stop

- Xray service is auto-run after system boot up by default.
- You can use Magisk Manager App to manage it. Be patient to wait it take effect (about 3 second).
- Check out [Manage service start / stop
](https://github.com/Asterisk4Magisk/Xray4Magisk#manage-service-start--stop-1) and [Manage transparent proxy enable / disable](https://github.com/Asterisk4Magisk/Xray4Magisk#manage-transparent-proxy-enable--disable)


#### Select which App to proxy

- Use [Xray4Magisk_Manager](https://github.com/whalechoi/Xray4Magisk_Manager)
- Check out [Select which UID to proxy](https://github.com/Asterisk4Magisk/Xray4Magisk#select-which-uid-to-proxy)


### Advanced usage ( for Debug and Develop only )

#### Enter manual mode

If you want to control xray by running command totally, just add a file `/data/adb/xray/manual`.  In this situation, xray service won't start on boot automatically and you cann't manage service start/stop via Magisk Manager App. 


#### Select which UID to proxy

- If you expect transparent proxy ( read Transparent proxy section for more detail ) for specific Apps, just write down these Apps' uid in file `/data/adb/xray/appid.list` . 

  Each App's uid should separate by space or just one App's uid per line. ( for Android App's uid , you can search App's package name in file `/data/system/packages.list` , or you can look into some App like Shadowsocks. )

- If you expect all Apps proxy by xray with transparent proxy, just write `ALL` in file `/data/adb/xray/appid.list` .

- If you expect all Apps proxy by xray with transparent proxy EXCEPT specific Apps, write down `bypass` at the first line then these Apps' uid separated as above in file `/data/adb/xray/appid.list`. 

- Transparent proxy won't take effect until the xray service start normally and file `/data/adb/xray/appid.list` is not empty.


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
For best compatibility, this module disable IPv6 by default.

To enable IPv6 proxy, execute `touch /data/adb/xray/ipv6`

To enable DNS AAAA record querying, edit `dns.json`, change `"queryStrategy"` from "UseIPv4" to "UseIP".

To enable local IPv6 out, edit `base.json`, find the first inbound with "freedom" tag, change its `"domainStrategy"` from "UseIPv4" to "UseIP".

To enable proxy IPv6 out, edit `proxy.json`, change its `"domainStrategy"` as what you do in `base.json`.


#### Use v2ray instead of xray
Rename v2ray to xray then replace `/data/adb/xray/bin/xray` with it.



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
