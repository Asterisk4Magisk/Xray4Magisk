#!/system/bin/sh
# Do NOT assume where your module will be located.
# ALWAYS use $MODDIR if you need to know where this script
# and module is placed.
# This will make sure your module will still work
# if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in late_start service mode

if [ ! -f /data/v2ray/manual ] ; then
  $MODDIR/scripts/v2ray.service start &> /data/v2ray/run/service.log && \
  if [ -f /data/v2ray/appid.list ] || [ -f /data/v2ray/softap.list ] ; then
    $MODDIR/scripts/v2ray.tproxy enable &>> /data/v2ray/run/service.log
    [ -f "$MODDIR/scripts/v2ray-dns.keeper" ] && $MODDIR/scripts/v2ray-dns.service start &>> /data/v2ray/run/service.log &
  fi
fi

inotifyd $MODDIR/scripts/v2ray.inotify $MODDIR &>> /data/v2ray/run/service.log &
