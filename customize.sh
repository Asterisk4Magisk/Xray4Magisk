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
  [ -f /sdcard/xray.config ] && source /sdcard/xray.config
  [ -f $module_path/xray.config ] && source $module_path/xray.config
fi

config_file="${module_path}/confs/${config}"

# get asset type and core type
whichCustom() {
  ui_print whichCustom
  for i in $(ls -tr /sdcard/Download); do
    if [ $(echo $i | grep '(^Xray-)*(\.zip$)') ]; then
      asset="customDat"
      core="xray"
      download_file=$i
      download_path="/sdcard/Download/${download_file}"
    elif [ $(echo $i | grep -nE '(^v2ray-)*(\.zip$)') ]; then
      asset="customDat"
      core="v2ray"
      download_file=$i
      download_path="/sdcard/Download/${download_file}"
    elif [ $(echo $i | grep -nE '(^sing-box-)*(\.tar\.gz$)' ) ]; then
      asset="customDb"
      core="sing-box"
      download_file=$i
      download_path="/sdcard/Download/${download_file}"
    else
      abort
    fi
  done
}

# get version arg
whichArch() {
  ui_print whichArch
  case "${core}" in
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
      esac
    ;;
  esac
}

# deploy assets
asset() {
  ui_print deployAssets
  mkdir -p ${module_path}/assets
  case "${asset}" in
    loyalsoldier)
      /data/adb/magisk/busybox wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O /sdcard/Download/geoip.dat >&2
      if [ "$?" != "0" ] ; then
        ui_print "Download err"
        abort
      fi
      /data/adb/magisk/busybox wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O /sdcard/Download/geosite.dat >&2
      if [ "$?" != "0" ] ; then
        ui_print "Download err"
        abort
      fi
      cp /sdcard/Download/geoip.db ${module_path}/assets
        cp /sdcard/Download/geosite.db ${module_path}/assets
    ;;
    dat)
      unzip -j -o "${download_path}" "geoip.dat" -d ${module_path}/assets >&2
      unzip -j -o "${download_path}" "geosite.dat" -d ${module_path}/assets >&2
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

whichCore() {
  ui_print whichCore
  case "$core" in
    custom)
      whichCustom
    ;;
    xray)
      download_link="https://github.com/XTLS/Xray-core/releases"
      github_api="https://api.github.com/repos/XTLS/Xray-core/releases"
      latest_version=`/data/adb/magisk/busybox wget -qO- ${github_api} | grep -m 1 "tag_name" | awk '{print $2}'`
      latest_version=${latest_version:2:-2}
      whichArch
      download_file=${version}
      download_path="/sdcard/Download/${download_file}"
      /data/adb/magisk/busybox wget "${download_link}/download/v${latest_version}/${download_file}" -O "${download_path}" >&2
      if [ "$?" != "0" ] ; then
        ui_print "Download err"
        abort
      fi
    ;;
    v2ray)
      download_link="https://github.com/v2fly/v2ray-core/releases"
      github_api="https://api.github.com/repos/v2fly/v2ray-core/releases"
      latest_version=`/data/adb/magisk/busybox wget -qO- ${github_api} | grep -m 1 "tag_name" | awk '{print $2}'`
      latest_version=${latest_version:2:-2}
      whichArch
      download_file=${version}
      download_path="/sdcard/Download/${download_file}"
      /data/adb/magisk/busybox wget "${download_link}/download/v${latest_version}/${download_file}" -O "${download_path}" >&2
      if [ "$?" != "0" ] ; then
        ui_print "Download err"
        abort
      fi
    ;;
    sing-box)
      download_link="https://github.com/SagerNet/sing-box/releases"
      github_api="https://api.github.com/repos/SagerNet/sing-box/releases"
      latest_version=`/data/adb/magisk/busybox wget -qO- ${github_api} | grep -m 1 "tag_name" | awk '{print $2}'`
      latest_version=${latest_version:2:-2}
      whichArch
      download_file="sing-box-${latest_version}-${version}.tar.gz"
      download_path="/sdcard/Download/${download_file}"
      /data/adb/magisk/busybox wget "${download_link}/download/v${latest_version}/${download_file}" -O "${download_path}" >&2
      if [ "$?" != "0" ] ; then
        ui_print "Download err"
        abort
      fi
    ;;
  esac
}

# deploy core
core() {
  ui_print deployCore
  mkdir -p ${module_path}/bin
  case "${core}" in
    xray)
      unzip -j -o "${download_path}" "xray" -d ${module_path}/bin/ >&2
    ;;
    v2ray)
      unzip -j -o "${download_path}" "v2ray" -d ${module_path}/bin/ >&2
    ;;
    sing-box)
      tar --strip-components=1 -xvzf ${download_path} -C ${module_path}/bin/ >&2
    ;;
  esac
}

installModule() {
  ui_print installModule
  mkdir -p ${module_path}/run
  mkdir -p ${module_path}/confs
  mkdir -p ${module_path}/scripts
  unzip -j -o "${ZIPFILE}" 'xray/scripts/*' -d ${module_path}/scripts >&2
  if [ ! -d /data/adb/service.d ] ; then
    mkdir -p /data/adb/service.d
  fi
  unzip -j -o "${ZIPFILE}" 'xray4magisk_service.sh' -d /data/adb/service.d >&2
  unzip -j -o "${ZIPFILE}" 'uninstall.sh' -d $MODPATH >&2
  set_perm  ${module_path}/scripts/xray.service    0  0  0755

  [ -f ${module_path}/xray.config ] || \
  unzip -j -o "${ZIPFILE}" "xray/etc/xray.config" -d ${module_path}>&2
  [ -f ${config_file} ] || \
  unzip -j -o "${ZIPFILE}" "xray/etc/confs/*" -d ${module_path}/confs >&2
  [ -f ${module_path}/appid.list ] || \
  echo "ALL" > ${module_path}/appid.list
  [ -f ${module_path}/ignore_out.list ] || \
  touch ${module_path}/ignore_out.list
  [ -f ${module_path}/ap.list ] || \
  [ "$(getprop ro.product.device)" = "rubens" ] && echo "ap+" > ${module_path}/ap.list || echo "wlan+" > ${module_path}/ap.list
  [ -f ${module_path}/ipv6 ] || \
  echo "enable" > ${module_path}/ipv6

  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm  /data/adb/service.d/xray4magisk_service.sh    0  0  0755
  set_perm  $MODPATH/uninstall.sh                         0  0  0755
  set_perm_recursive  ${module_path}/scripts              0  0  0755
  set_perm  ${module_path}                                0  0  0755
  set_perm_recursive  ${module_path}/bin                  0  0  0755

  unzip -j -o "${ZIPFILE}" "module.prop" -d $MODPATH >&2
  echo -n "version=Module v0.1, Core " >> $MODPATH/module.prop
  echo "${core} ${latest_version}" >> $MODPATH/module.prop
  echo "versionCode=20220916" >> $MODPATH/module.prop
}

main() {
  whichCore
  core
  asset
  installModule
}

main
