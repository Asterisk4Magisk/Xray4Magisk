#!/bin/sh

# check wifi is on
# settings get wifi-on

# check wifi is connected
# dumpsys connectivity | grep "WIFI" | grep "state:" | awk '{print $5}'

# check online ip
# ip route get 1.2.3.4 | awk '{print $9}'

lastIP6="2001:da8::666"

bypass() {
    if [ "$isChanged" = true ]; then
        iptables -w 100 -t mangle -D XRAY -d $lastIP/32 -j RETURN
        iptables -w 100 -t mangle -I XRAY -d $IP/32 -j RETURN
        lastIP=$IP
    fi
}

bypass6() {
    if [ "$isChanged6" = true ]; then
        ip6tables -w 100 -t mangle -D XRAY -d $lastIP6/128 -j RETURN
        ip6tables -w 100 -t mangle -I XRAY -d $IP6/128 -j RETURN
        lastIP6=$IP6
    fi
}

main() {
    IP=`ip route get 1.2.3.4 | awk '{print $9}'`
    if [ "${IP}" = "${lastIP}" ] ; then
        isChanged=false
    else
        isChanged=true
    fi
    bypass
    sleep 1
    if [ -f /data/adb/xray/ipv6 ] ; then
        IP6=`ip -6 route get 2001:da8::666 | awk '{print $13}'`
        if [ "${IP6}" = "" ] ; then
            IP6="2001:da8::666"
        fi
        sleep 1
        if [ "${IP6}" = "${lastIP6}" ] ; then
            isChanged6=false
        else
            isChanged6=true
        fi
        bypass6
    fi
    sleep 5
    main
}

main
