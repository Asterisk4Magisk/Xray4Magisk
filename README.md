# Xray Magisk Module
A fork of [V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray)
This is a Xray module for Magisk, and includes binaries for arm, arm64, x86, x64.



## Included

* [Xray-core](<https://github.com/XTLS/Xray-core>)
* [magisk-module-installer](https://github.com/topjohnwu/magisk-module-installer)

- XRay service script and Android transparent proxy iptables script



## Install

You can download the release installer zip file and install it via the Magisk Manager App.

### Manual download Xray-core
Download the correct CPU Architecture Xray-core zip file and put it in `/sdcard/Download`.

such as "Xray-android-arm64-v8a.zip"


## Config

- Xray config file is store in `/data/adb/xray/confs/`.
- proxy config is `/data/adb/xray/confs/proxy.json`.

- Tips: Please notice that the default configuration has already set inbounds section to cooperate work with transparent proxy script. It is recommended that you only edit the first element of outbounds section to your proxy server and edit file `/data/adb/xray/appid.list` to select which App to proxy.



## Usage

### Normal usage ( Default and Recommended )

#### Manage service start / stop

- xray service is auto-run after system boot up by default.
- You can start or stop xray service by simply turn on or turn off the module via Magisk Manager App. Start service may wait about 10 second and stop service may take effect immediately.



#### Select which App to proxy

- If you expect transparent proxy ( read Transparent proxy section for more detail ) for specific Apps, just write down these Apps' uid in file `/data/adb/xray/appid.list` . 

  Each App's uid should separate by space or just one App's uid per line. ( for Android App's uid , you can search App's package name in file `/data/system/packages.list` , or you can look into some App like Shadowsocks. )

- If you expect all Apps proxy by xray with transparent proxy, just write `ALL` in file `/data/adb/xray/appid.list` .

- If you expect all Apps proxy by xray with transparent proxy EXCEPT specific Apps, write down `bypass` at the first line then these Apps' uid separated as above in file `/data/adb/xray/appid.list`. 

- Transparent proxy won't take effect until the xray service start normally and file `/data/adb/xray/appid.list` is not empty.


### Advanced usage ( for Debug and Develop only )

#### Enter manual mode

If you want to control xray by running command totally, just add a file `/data/adb/xray/manual`.  In this situation, xray service won't start on boot automatically and you cann't manage service start/stop via Magisk Manager App. 



#### Manage service start / stop

- xray service script is `$MODDIR/scripts/xray.service`.

- For example, in my environment ( Magisk version: 18100 ; Magisk Manager version v7.1.1 )

  - Start service : 

    `/sbin/.magisk/img/xray/scripts/xray.service start`

  - Stop service :

    `/sbin/.magisk/img/xray/scripts/xray.service stop`



#### Manage transparent proxy enable / disable

- Transparent proxy script is `$MODDIR/scripts/xray.tproxy`.

- For example, in my environment ( Magisk version: 18100 ; Magisk Manager version v7.1.1 )

  - Enable Transparent proxy : 

    `/sbin/.magisk/img/xray/scripts/xray.tproxy enable`

  - Disable Transparent proxy :

    `/sbin/.magisk/img/xray/scripts/xray.tproxy disable`


## Uninstall

1. Uninstall the module via Magisk Manager App.
2. You can clean xray data dir by running command `rm -rf /data/adb/xray` .



## Project X

Project X is a set of network tools that help you to build your own computer network. It secures your network connections and thus protects your privacy. See [Project X](https://github.com/XTLS/xray-core) for more information.



## License

[The MIT License (MIT)](https://raw.githubusercontent.com/XTLS/xray-core/master/LICENSE)
