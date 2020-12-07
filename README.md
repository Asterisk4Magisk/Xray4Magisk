# Xray Magisk Module
A fork of [V2ray for Android](https://github.com/Magisk-Modules-Repo/v2ray)
This is a Xray module for Magisk, and includes binaries for arm, arm64, x86, x64.



## Included

* [XRay core](<https://github.com/XTLS/Xray-core>)
* [dnscrypt-proxy](<https://github.com/DNSCrypt/dnscrypt-proxy>)
* [magisk-module-installer](https://github.com/topjohnwu/magisk-module-installer)

- XRay service script and Android transparent proxy iptables script



## Install

You can download the release installer zip file and install it via the Magisk Manager App.

### Manual download Xray-core
Download the correct CPU Architecture Xray-core zip file and put it in the same folder where you place Xray4Magisk.zip.

such as "Xray-linux-arm64-v8a.zip"


### Custom Xray-core
Put any Xray-core.zip in the same folder where you place Xray4Magisk.zip.


## Config

- Xray config file is store in `/data/xray/config.json` .

- Please make sure the config is correct. You can check it by running a command :

   `export xray_LOCATION_ASSET=/data/xray; xray -test -config /data/xray/config.json`  in android terminal or ssh.

- dnscrypt-proxy config file is store in `/data/xray/dnscrypt-proxy/` folder, you can update cn domains list via running the shell script `update-rules.sh` or if you dislike the default rules, you can edit them by yourself. ( If you want to disable dnscrypt-proxy, just delete the config file `/data/xray/dnscrypt-proxy/dnscrypt-proxy.toml` )

- Tips: Please notice that the default configuration has already set inbounds section to cooperate work with transparent proxy script. It is recommended that you only edit the first element of outbounds section to your proxy server and edit file `/data/xray/appid.list` to select which App to proxy.



## Usage

### Normal usage ( Default and Recommended )

#### Manage service start / stop

- xray service is auto-run after system boot up by default.
- You can start or stop xray service by simply turn on or turn off the module via Magisk Manager App. Start service may wait about 10 second and stop service may take effect immediately.



#### Select which App to proxy

- If you expect transparent proxy ( read Transparent proxy section for more detail ) for specific Apps, just write down these Apps' uid in file `/data/xray/appid.list` . 

  Each App's uid should separate by space or just one App's uid per line. ( for Android App's uid , you can search App's package name in file `/data/system/packages.list` , or you can look into some App like Shadowsocks. )

- If you expect all Apps proxy by xray with transparent proxy, just write `ALL` in file `/data/xray/appid.list` .

- If you expect all Apps proxy by xray with transparent proxy EXCEPT specific Apps, write down `bypass` at the first line then these Apps' uid separated as above in file `/data/xray/appid.list`. 

- Transparent proxy won't take effect until the xray service start normally and file `/data/xray/appid.list` is not empty.



#### Share transparent proxy to WiFi guest or USB guest

- Transparent proxy is share to WiFi guest by default.
- If you don't want to share proxy to WiFi guest or USB guest, delete the file `/data/xray/softap.list` or empty it.
- For most situation, Android WiFi hotspot subnet is `192.168.43.0/24`, and USB subnet is `192.168.42.0/24`. If your device is not conform to it , please write down the subnet you want proxy in `/data/xray/softap.list`. ( You can run command `ip addr` to search the subnet )



### Advanced usage ( for Debug and Develop only )

#### Enter manual mode

If you want to control xray by running command totally, just add a file `/data/xray/manual`.  In this situation, xray service won't start on boot automatically and you cann't manage service start/stop via Magisk Manager App. 



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



## Transparent proxy

### What is "Transparent proxy"

> "A 'transparent proxy' is a proxy that does not modify the request or response beyond what is required for proxy authentication and identification". "A 'non-transparent proxy' is a proxy that modifies the request or response in order to provide some added service to the user agent, such as group annotation services, media type transformation, protocol reduction, or anonymity filtering".
>
> ​                                -- [Transparent proxy explanation in Wikipedia](https://en.wikipedia.org/wiki/Proxy_server#Transparent_proxy)



### Working principle

This module also contains a simple script that helping you to make transparent proxy via iptables. In fact , the script is just make some REDIRECT and TPROXY rules to redirect app's network into 65535 port in localhost. And 65535 port is listen by xray inbond with dokodemo-door protocol. In summarize, the App proxy network path is looks like :



**Android App** ( Google, Facebook, Twitter ... )

  &vArr;  ( TCP & UDP network protocol )

Android system **iptables**      [ localhost inside ]

  &vArr;  ( REDIRECT & TPROXY iptables rules )

[ 127.0.0.1:65535 Inbond ] -- **xray** -- [ Outbond ]

  &vArr;  ( Shadowsocks, Vmess )

**Proxy Server** ( SS, xray)   [ Internet outside ]             

  &vArr; ( HTTP, TCP, ... other application protocol ) 

**App Server** ( Google, Facebook, Twitter ... )



## Uninstall

1. Uninstall the module via Magisk Manager App.
2. You can clean xray data dir by running command `rm -rf /data/xray` .



## Project X

Project X is a set of network tools that help you to build your own computer network. It secures your network connections and thus protects your privacy. See [Project X](https://github.com/XTLS/xray-core) for more information.



## License

[The MIT License (MIT)](https://raw.githubusercontent.com/XTLS/xray-core/master/LICENSE)
