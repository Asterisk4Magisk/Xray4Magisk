#!/system/bin/sh

MODDIR=${0%/*}

(
until [ $(getprop sys.boot_completed) -eq 1 ] ; do
  sleep 5
done
/data/adb/scripts/start.sh
)&
