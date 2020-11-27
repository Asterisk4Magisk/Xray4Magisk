#!/system/bin/sh

MODDIR=${0%/*}

start_proxy () {
  ${MODDIR}/xray.service start &> /data/xray/run/service.log && \
  if [ -f /data/xray/appid.list ] || [ -f /data/xray/softap.list ] ; then
    ${MODDIR}/xray.tproxy enable &>> /data/xray/run/service.log && \
    if [ -f /data/xray/dnscrypt-proxy/dnscrypt-proxy.toml ] ; then
      ${MODDIR}/dnscrypt-proxy.service enable &>> /data/xray/run/service.log &
    fi
  fi
}
if [ ! -f /data/xray/manual ] ; then
  start_proxy
  inotifyd ${MODDIR}/xray.inotify ${MODDIR}/.. &>> /data/xray/run/service.log &
fi
