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
    local_ipv4=$(ip a | awk '$1~/inet$/{print $2}')
    rules_ipv4=$(iptables -w 100 -t mangle -nvL XRAY_LOCAL | grep "udp dpt" | awk '{print $9}')
 
    for rules_subnet in ${rules_ipv4[*]} ; do
        iptables -w 100 -t mangle -D XRAY_LOCAL -d ${rules_subnet} -p udp ! --dport 53 -j RETURN
        iptables -w 100 -t mangle -D XRAY_LOCAL -d ${rules_subnet} ! -p udp -j RETURN
    done

    for subnet in ${local_ipv4[*]} ; do
        iptables -w 100 -t mangle -I XRAY_LOCAL -d ${subnet} ! -p udp -j RETURN
        iptables -w 100 -t mangle -I XRAY_LOCAL -d ${subnet} -p udp ! --dport 53 -j RETURN
    done
}

bypass6() {
  	local_ipv6=$(ip -6 a | awk '$1~/inet6$/{print $2}' | grep '^2')
   	rules_ipv6=$(ip6tables -w 100 -t mangle -nvL XRAY_LOCAL | grep "udp dpt" | awk '{print $8}')
	
    for rules_subnet6 in ${rules_ipv6[*]} ; do
        ip6tables -w 100 -t mangle -D XRAY_LOCAL -d ${rules_subnet6} -p udp ! --dport 53 -j RETURN
        ip6tables -w 100 -t mangle -D XRAY_LOCAL -d ${rules_subnet6} ! -p udp -j RETURN
    done

 	for subnet6 in ${local_ipv6[*]} ; do
        ip6tables -w 100 -t mangle -I XRAY_LOCAL -d ${subnet6} ! -p udp -j RETURN
        ip6tables -w 100 -t mangle -I XRAY_LOCAL -d ${subnet6} -p udp ! --dport 53 -j RETURN
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

    echo "* * * * * ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; ${scripts_dir}/watch.sh start ; sleep 5 ; " > /data/adb/xray/run/root
}


case "$1" in
  start)
    main
    ;;
  *)
    default
    ;;
esac
