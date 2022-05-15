#!/bin/sh

# check wifi is on
# settings get wifi-on

# check wifi is connected
# dumpsys connectivity | grep "WIFI" | grep "state:" | awk '{print $5}'

# check online ip
# ip route get 1.2.3.4 | awk '{print $9}'

watch=`realpath $0`
scripts_dir=`dirname ${watch}`

lastIP="1.2.3.4"
lastIP6="::114:514:1919:810"

echo "" > /data/adb/xray/run/lastmobile
echo "" > /data/adb/xray/run/lastwifi

intranet=(0.0.0.0/8 10.0.0.0/8 100.64.0.0/10 127.0.0.0/8 169.254.0.0/16 172.16.0.0/12 192.0.0.0/24 192.0.2.0/24 192.88.99.0/24 192.168.0.0/16 198.51.100.0/24 203.0.113.0/24 224.0.0.0/4 240.0.0.0/4 255.255.255.255/32)
intranet6=(::/128 ::1/128 ::ffff:0:0/96 100::/64 64:ff9b::/96 2001::/32 2001:10::/28 2001:20::/28 2001:db8::/32 2002::/16 fc00::/7 fe80::/10 ff00::/8)

bypass() {
	local_ipv4_get=$(ip a | awk '$1~/inet$/{print $2}')
    local_ipv4=(${intranet[*]} ${local_ipv4_get[*]})
    rules_ipv4=$(iptables -w 100 -t mangle -nvL XRAY | grep "udp dpt" | awk '{print $9}')
 
    for rules_subnet in ${rules_ipv4[*]} ; do
		if  (iptables -w 100 -t mangle -C XRAY -d ${rules_subnet} ! -p udp -j RETURN > /dev/null 2>&1) ; then
           iptables -w 100 -t mangle -D XRAY -d ${rules_subnet} -p udp ! --dport 53 -j RETURN
           iptables -w 100 -t mangle -D XRAY -d ${rules_subnet} ! -p udp -j RETURN
		fi
    done

    for subnet in ${local_ipv4[*]} ; do
        if ! (iptables -w 100 -t mangle -C XRAY -d ${subnet} ! -p udp -j RETURN > /dev/null 2>&1) ; then
            iptables -w 100 -t mangle -I XRAY -d ${subnet} ! -p udp -j RETURN
            iptables -w 100 -t mangle -I XRAY -d ${subnet} -p udp ! --dport 53 -j RETURN
        fi
    done
}

bypass6() {
    local_ipv6_get=$(ip -6 a | awk '$1~/inet6$/{print $2}')
  	local_ipv6=(${intranet6[*]} ${local_ipv6_get[*]})
   	 rules_ipv6=$(ip6tables -w 100 -t mangle -nvL XRAY | grep "udp dpt" | awk '{print $8}')
	
    for rules_subnet6 in ${rules_ipv6[*]} ; do
		if  (ip6tables -w 100 -t mangle -C XRAY -d ${rules_subnet6} -p udp ! --dport 53 -j RETURN > /dev/null 2>&1) ; then
           ip6tables -w 100 -t mangle -D XRAY -d ${rules_subnet6} -p udp ! --dport 53 -j RETURN
           ip6tables -w 100 -t mangle -D XRAY -d ${rules_subnet6} ! -p udp -j RETURN
		fi
    done

 	for subnet6 in ${local_ipv6[*]} ; do
        if ! (ip6tables -w 100 -t mangle -C XRAY -d ${subnet6} -p udp ! --dport 53 -j RETURN > /dev/null 2>&1) ; then
            ip6tables -w 100 -t mangle -I XRAY -d ${subnet6} ! -p udp -j RETURN
            ip6tables -w 100 -t mangle -I XRAY -d ${subnet6} -p udp ! --dport 53 -j RETURN
        fi
    done 
}

main(){
	change=0

    wifistatus=$(dumpsys connectivity | grep "WIFI" | grep "state:" | awk -F ", " '{print $2}' | awk -F "=" '{print $2}' 2>&1)

    if test ! -z "${wifistatus}" ; then
        echo "" > /data/adb/xray/run/lastmobile
        if test ! "${wifistatus}" = "$(cat /data/adb/xray/run/lastwifi)" ; then
            change=$((${change} + 1))
            echo "${wifistatus}" > /data/adb/xray/run/lastwifi
		elif [ "$(ip route get 1.2.3.4 | awk '{print $5}' 2>&1)" != "wlan0"  ] ; then
			change=$((${change} + 1))
			echo "${wifistatus}" > /data/adb/xray/run/lastwifi
        fi
    else    
        echo "" > /data/adb/xray/run/lastwifi
    fi

    if [ "$(settings get global mobile_data 2>&1)" -eq 1 ] && [ -z "${wifistatus}" ] ; then
		echo "" > /data/adb/xray/run/lastwifi
		card1="$(settings get global mobile_data1 2>&1)"
		card2="$(settings get global mobile_data2 2>&1)"
		if [ "${card1}" = 1 ] ; then
			mobilestatus=1
        fi
		if [ "${card2}" = 1 ] ; then
			mobilestatus=2
        fi
	else
		mobilestatus=0
    fi

    sleep 1

    if test "${mobilestatus}" -ne 0 ; then
        if test ! "${mobilestatus}" = "$(cat /data/adb/xray/run/lastmobile)" ; then
            change=$((${change} + 1))
            echo "${mobilestatus}" > /data/adb/xray/run/lastmobile
        fi
    fi
	
    if test "${change}" -ne 0 ; then
    	bypass
    	bypass6
	fi
}

default(){
    /data/adb/magisk/busybox crond -c /data/adb/xray/run/

    touch /data/adb/xray/run/root
    chmod 0600 /data/adb/xray/run/root

    echo "*/1 * * * * ${scripts_dir}/watch.sh start" > /data/adb/xray/run/root
}


case "$1" in
  start)
    main
    ;;
  *)
    default
    ;;
esac
