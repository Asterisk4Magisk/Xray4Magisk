#####################
# xray Customization
#####################

SKIPUNZIP=1
ASH_STANDALONE=1

module_path="/data/adb/xray"

core="xray"
asset="loyalsoldier"

if [ $BOOTMODE ! = true ] ; then
  core="custom"
  asset="custom"
else
  [ -f /sdcard/sing.config ] && source /sdcard/sing.config
  [ -f ${module_path}/sing.config ] && source ${module_path}/sing.config
fi

config_file="${module_path}/confs/${config}"

whichCustom() {
  for i in $(ls /sdcard/Download); do
    if [ $(echo $i | grep '(^Xray-)*(\.zip$)') ]; then
      asset="customDat"
      return xray
    elif [ $(echo $i | grep -nE '(^v2ray-)*(\.zip$)') ]; then
      asset="customDat"
      return v2ray
    elif [ $(echo $i | grep -nE '(^sing-box-)*(\.tar\.gz$)' ) ]; then
      asset="customDb"
      return sing
    elif
      abort
    fi
  done
}

whichArch() {
  case "$1" in
    xray)
      case "${ARCH}" in
        arm)
          version="Xray-linux-arm32-v7a.zip"
        ;;
        arm64)
          version="Xray-android-arm64-v8a.zip"
        ;;
        x86)
          version="Xray-linux-32.zip"
        ;;
        x64)
          version="Xray-linux-64.zip"
        ;;
      esac
    ;;
    v2ray)
      case "${ARCH}" in
        arm)
          version="v2ray-linux-arm32-v7a.zip"
        ;;
        arm64)
          version="v2ray-android-arm64-v8a.zip"
        ;;
        x86)
          version="v2ray-linux-32.zip"
        ;;
        x64)
          version="v2ray-linux-64.zip"
        ;;
      esac
    ;;
    sing-box)
      case "${ARCH}" in
      arm)
        version="linux-armv7"
        ;;
      arm64)
        version="android-arm64"
        ;;
      x86)
        version=""
        ;;
      x64)
        version="android-amd64v3"
        ;;
    ;;
  esac
}

asset() {
  case "${asset}" in
    loyalsoldier)

    ;;
    dat)

    ;;
    db)
      /data/adb/magisk/busybox wget https://github.com/SagerNet/sing-geoip/releases/latest/download/geoip.db -O /sdcard/Download/geoip.db >&2
      if [ "$?" != "0" ] ; then
        ui_print "Download err"
        abort
      fi
      /data/adb/magisk/busybox wget https://github.com/SagerNet/sing-geosite/releases/latest/download/geosite.db -O /sdcard/Download/geosite.db >&2
      if [ "$?" != "0" ] ; then
        ui_print "Download err"
        abort
      fi
      cp /sdcard/Download/geoip.dat ${module_path}/assets
      cp /sdcard/Download/geosite.dat ${module_path}/assets
    ;;
    customDat)
      if [ -f /sdcard/Download/geoip.dat ] && [ -f /sdcard/Download/geosite.dat ] ; then
        cp /sdcard/Download/geoip.dat ${module_path}/assets
        cp /sdcard/Download/geosite.dat ${module_path}/assets
      else
        abort
      fi
    ;;
    customDb)
      if [ -f /sdcard/Download/geoip.db ] && [ -f /sdcard/Download/geosite.db ] ; then
        cp /sdcard/Download/geoip.db ${module_path}/assets
        cp /sdcard/Download/geosite.db ${module_path}/assets
      else
        abort
      fi
    ;;
  esac
}

if [ "${core}" = "custom" ]; then

fi