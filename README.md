# V2ray Magisk Module

This is a v2ray module for Magisk, and includes binaries for arm, arm64, x86, x64.



## Included

* [V2Ray core](<https://github.com/v2ray/v2ray-core>)
* [magisk-module-installer](https://github.com/topjohnwu/magisk-module-installer)

- V2Ray service script and Android transparent proxy iptables script



## Install

- You can download the release installer zip file and install it via the Magisk Manager App.



## Config

- V2ray config file is store in `/data/v2ray/config.json` .


- Please make sure the config is correct. You can check it by running a command :

   `export V2RAY_LOCATION_ASSET=/data/v2ray; v2ray -test -config /data/v2ray/config.json`  in android terminal.




## Start/Stop service

- V2ray service is autorun on boot. If you don't want it run automatically, you can just add a file `/data/v2ray/no-autostart` .

- You can start / stop manually by execute the service script in `$MODDIR/v2ray.service` . For example, in my environment , the script's absolute path is `/sbin/.magisk/img/v2ray/v2ray.service` .

- So, if you want to start v2ray service, just run:

  `/sbin/.magisk/img/v2ray/v2ray.service start`

  or stop v2ray service:

  `/sbin/.magisk/img/v2ray/v2ray.service stop `

  or restart v2ray service:

  `/sbin/.magisk/img/v2ray/v2ray.service restart`

## Transparent proxy

### Working principle

This module also contains a simple script that helping you to make transparent proxy via iptables. In fact , the script is just make some REDIRECT and TPROXY rules to redirect app's network into 65535 port in localhost. And 65535 port is listen by v2ray inbond with dokodemo-door protocol. In summarize, the App proxy network path is looks like :



**Android App** ( Browser, Google, Facebook, Twitter ... ... )

  &vArr;  ( TCP & UDP network protocol )

Android system **iptables**                          [ localhost inside ]

  &vArr;  ( REDIRECT & TPROXY iptables rules )

127.0.0.1:65535 [ Inbond ] ----- **V2Ray** ----- [ Outbond ]

​          ( Shadowsocks, Vmess )                                &vArr;

  [ Internet outside ]            ( SS, V2Ray)       **Proxy Server**

​       ( HTTP, TCP, ... other application protocol )   &vArr;

 ( Google, Facebook, Twitter ... ... )                 **App Server**



### Choose proxy target

- Select mode : You can write a list of App's uid into `/data/v2ray/appid.list` file so that the script would select these App's network proxy via V2Ray. Each App's uid should separate by space or just One App's uid per line.

- Global mode : You can write a single number "0" into `/data/v2ray/appid.list` file to make all App's network proxy via V2Ray.



### Enable/Disable proxy

- Only when the V2Ray service start normally on boot and  `/data/v2ray/appid.list` file is not empty, the transparent proxy iptables script can run automatically.

- Otherwise, you can execute iptables script in `$MODDIR/v2ray.redirect` . For example, in my environment:

  Enable transparent proxy:

  `/sbin/.magisk/img/v2ray/v2ray.redirect enable`

  Disable transparent proxy:

  `/sbin/.magisk/img/v2ray/v2ray.redirect disable`



## Uninstall

1. Uninstall the module via Magisk Manager App.
2. You can clean v2ray data dir by running command `rm -rf /data/v2ray` .



## Project V

Project V is a set of network tools that help you to build your own computer network. It secures your network connections and thus protects your privacy. See [ProjectV website](https://www.v2ray.com/) for more information.



## License

[The MIT License (MIT)](https://raw.githubusercontent.com/v2ray/v2ray-core/master/LICENSE)