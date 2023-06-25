#!/system/bin/sh

MODDIR=/data/adb/modules/xray4magisk
SCRIPTS_DIR=/data/adb/xray/scripts
XRAYHELPER=/data/adb/xray/bin/xrayhelper
XRAYHELPER_CONF=/data/adb/xray/xrayhelper.yml

start_proxy() {
    ${XRAYHELPER} &>>/data/adb/xray/run/helper.log
    ${XRAYHELPER} -c ${XRAYHELPER_CONF} service start &>>/data/adb/xray/run/helper.log &&
        ${XRAYHELPER} -c ${XRAYHELPER_CONF} proxy enable &>>/data/adb/xray/run/helper.log &
}

if [ ! -f /data/adb/xray/manual ]; then
    echo -n "" >/data/adb/xray/run/helper.log
    rm -rf /data/adb/xray/run/core.pid
    rm -rf /data/adb/xray/run/tun2socks.pid
    if [ ! -f ${MODDIR}/disable ]; then
        start_proxy
    fi
    inotifyd ${SCRIPTS_DIR}/xray.inotify ${MODDIR} &>>/data/adb/xray/run/helper.log &
fi
