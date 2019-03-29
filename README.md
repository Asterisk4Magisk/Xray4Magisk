# V2ray Magisk Module

This is a v2ray module for Magisk, and includes binaries for arm, arm64, x86, x64.



## Included

* [V2Ray](<https://github.com/v2ray/v2ray-core>)
* [magisk-module-installer](https://github.com/topjohnwu/magisk-module-installer)



## Install

- You can download the release installer zip file and install it via the Magisk Manager App.



## Config

V2ray config file is store in `/data/v2ray/config.json` .

Please make sure the config is correct. You can do that by running a command `v2ray -test -config /data/v2ray/config.json`  in android terminal.



## Start/Stop service

- V2ray service is autorun on boot. If you don't want it run automatically, you can just add a file `/data/v2ray/no-autostart` .

- You can also start / stop manually by run the service script in `$MODDIR` . For example, in my environment , the script's absolute path is `/sbin/.magisk/img/v2ray/v2ray.service` . 

- So, if you want to start v2ray service, just run:

  `/sbin/.magisk/img/v2ray/v2ray.service start`

  or stop v2ray service:

  `/sbin/.magisk/img/v2ray/v2ray.service stop `

  or restart v2ray service:

  `/sbin/.magisk/img/v2ray/v2ray.service restart`



## Uninstall

1. Uninstall the module via Magisk Manager App.
2. Remove the directory with command `rm -rf /data/v2ray` .



## Project V

Project V is a set of network tools that help you to build your own computer network. It secures your network connections and thus protects your privacy. See [ProjectV website](https://www.v2ray.com/) for more information.



## License

[The MIT License (MIT)](https://raw.githubusercontent.com/v2ray/v2ray-core/master/LICENSE)