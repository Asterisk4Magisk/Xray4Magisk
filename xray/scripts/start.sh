#!/system/bin/sh

MOD_DIR=/data/adb/modules/xray4magisk
NET_DIR=/data/misc/net
SCRIPTS_DIR=/data/adb/xray/scripts
XRAYHELPER=/data/adb/xray/bin/xrayhelper
XRAYHELPER_CONF=/data/adb/xray/xrayhelper.yml

start_proxy() {
    ${XRAYHELPER} -c ${XRAYHELPER_CONF} service start &>>/data/adb/xray/run/helper.log &&
        ${XRAYHELPER} -c ${XRAYHELPER_CONF} proxy enable &>>/data/adb/xray/run/helper.log &
}

rm -rf /data/adb/xray/run/core.pid
rm -rf /data/adb/xray/run/adghome.pid
rm -rf /data/adb/xray/run/tun2socks.pid
if [ ! -f /data/adb/xray/manual ]; then
    ${XRAYHELPER} >/data/adb/xray/run/helper.log
    if [ ! -f ${MOD_DIR}/disable ]; then
        start_proxy
        sleep 5
    fi
    inotifyd ${SCRIPTS_DIR}/xray.inotify ${MOD_DIR} &>>/data/adb/xray/run/helper.log &
    # inotifyd ${SCRIPTS_DIR}/net.inotify ${NET_DIR} &>>/data/adb/xray/run/helper.log &
fi
