#!/system/bin/sh

MODDIR=/data/adb/modules/xray4magisk
SCRIPTS_DIR=/data/adb/xray/scripts

start_proxy () {
  ${SCRIPTS_DIR}/xray.service start &> /data/adb/xray/run/service.log && \
  if [ -f /data/adb/xray/appid.list ] ; then
    ${MODDIR}/xray.tproxy enable &>> /data/adb/xray/run/service.log &
  fi
}

until [ $(getprop sys.boot_completed) -eq 1 ]; do
  sleep 5
done

if [ ! -f /data/adb/xray/manual ] ; then
  start_proxy
  inotifyd ${SCRIPTS_DIR}/xray.inotify ${MODDIR} &>> /data/adb/xray/run/service.log &
fi
