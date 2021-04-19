#!/system/bin/sh

MODDIR=/data/adb/modules/xray4magisk
if [ -n "$(magisk -v | grep lite)" ]; then
  MODDIR=/data/adb/lite_modules/xray4magisk
fi
SCRIPTS_DIR=/data/adb/xray/scripts

start_proxy () {
  ${SCRIPTS_DIR}/xray.service start &>> /data/adb/xray/run/service.log && \
  if [ -f /data/adb/xray/appid.list ] ; then
    ${SCRIPTS_DIR}/xray.tproxy enable &>> /data/adb/xray/run/service.log &
  fi
}

if [ ! -f /data/adb/xray/manual ] ; then
  echo -n "" > /data/adb/xray/run/service.log
  if [ ! -f ${MODDIR}/disable ] ; then
    start_proxy
  fi
  inotifyd ${SCRIPTS_DIR}/xray.inotify ${MODDIR} &>> /data/adb/xray/run/service.log &
fi
