#!/system/bin/sh

MODDIR=${0%/*}

start_proxy () {
  ${MODDIR}/xray.service start &> /data/xray/run/service.log && \
  if [ -f /data/xray/appid.list ] ; then
    ${MODDIR}/xray.tproxy enable &>> /data/xray/run/service.log &
  fi
}

until [ $(getprop sys.boot_completed) -eq 1 ]; do
  sleep 5
done

if [ ! -f /data/xray/manual ] ; then
  start_proxy
  inotifyd ${MODDIR}/xray.inotify ${MODDIR}/.. &>> /data/xray/run/service.log &
fi
