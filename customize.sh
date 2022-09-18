#####################
# xray Customization
#####################

SKIPUNZIP=1
ASH_STANDALONE=1

module_path="/data/adb/xray"
config_file="${module_path}/confs/${config}"

# External Tools
chmod -R 0755 $MODPATH/common/addon/Volume-Key-Selector/tools

chooseport_legacy() {
  # Keycheck binary by someone755 @Github, idea for code below by Zappo @xda-developers
  # Calling it first time detects previous input. Calling it second time will do what we want
  [ "$1" ] && local delay=$1 || local delay=3
  local error=false
  while true; do
    timeout 0 $MODPATH/common/addon/Volume-Key-Selector/tools/$ARCH32/keycheck
    timeout $delay $MODPATH/common/addon/Volume-Key-Selector/tools/$ARCH32/keycheck
    local sel=$?
    if [ $sel -eq 42 ]; then
      return 0
    elif [ $sel -eq 41 ]; then
      return 1
    elif $error; then
      abort "Volume key not detected!"
    else
      error=true
      echo "Volume key not detected. Try again"
    fi
  done
}

chooseport() {
  # Original idea by chainfire and ianmacd @xda-developers
  [ "$1" ] && local delay=$1 || local delay=3
  local error=false
  while true; do
    local count=0
    while true; do
      timeout $delay /system/bin/getevent -lqc 1 2>&1 >$TMPDIR/events &
      sleep 0.5
      count=$((count + 1))
      if ($(grep -q 'KEY_VOLUMEUP *DOWN' $TMPDIR/events)); then
        return 0
      elif ($(grep -q 'KEY_VOLUMEDOWN *DOWN' $TMPDIR/events)); then
        return 1
      fi
      [ $count -gt 6 ] && break
    done
    if $error; then
      # abort "Volume key not detected!"
      echo "Volume key not detected. Trying keycheck method"
      export chooseport=chooseport_legacy VKSEL=chooseport_legacy
      chooseport_legacy $delay
      return $?
    else
      error=true
      echo "Volume key not detected. Try again"
    fi
  done
}

VKSEL=chooseport

# which custom core
whichCustom() {
  for i in $(ls -tr /sdcard/Download); do
    if [ $(echo $i | grep -e '^Xray-.*\.zip$') ]; then
      core="xray"
      ui_print "---Core selected as xray---"
      if [ ! $BOOTMODE ]; then
        asset="customDat"
      fi
      download_file=$i
      download_path="/sdcard/Download/${download_file}"
    elif [ $(echo $i | grep -e '^v2ray-.*\.zip$') ]; then
      core="v2ray"
      ui_print "---Core selected as v2ray---"
      if [ ! $BOOTMODE ]; then
        asset="customDat"
      fi
      download_file=$i
      download_path="/sdcard/Download/${download_file}"
    elif [ $(echo $i | grep -e '^sing-box-.*\.tar.gz$') ]; then
      core="sing-box"
      ui_print "---Core selected as sing-box---"
      if [ ! $BOOTMODE ]; then
        asset="customDb"
      fi
      download_file=$i
      download_path="/sdcard/Download/${download_file}"
    fi
  done
  if [ $core == "custom" ]; then
    ui_print "---Custom core not found---"
    abort
  fi
}

# select asset
selasset() {
  ui_print "---Please select your asset---"
  if [ $core == "sing-box" ]; then
    ui_print "VOL+ = default, VOL- = custom"
    if $VKSEL; then
      asset="db"
      ui_print "---Asset selected as default---"
    else
      asset="customDb"
      ui_print "---Asset selected as custom---"
    fi
  else
    ui_print "VOL+ = default, VOL- = loyalsoldier/custom"
    if $VKSEL; then
      asset="dat"
      ui_print "---Asset selected as default---"
    else
      ui_print "---Please select loyalsoldier or custom---"
      ui_print "VOL+ = loyalsoldier, VOL- = custom"
      if $VKSEL; then
        asset="loyalsoldier"
        ui_print "---Asset selected as loyalsoldier---"
      else
        asset="customDat"
        ui_print "---Asset selected as custom---"
      fi
    fi
  fi
}

# select core
selcore() {
  if [ ! $BOOTMODE ]; then
    core="custom"
    ui_print "---Work in offline mode, will use custom installation---"
    whichCustom
  else
    [ -f /sdcard/xray.config ] && source /sdcard/xray.config
    [ -f $module_path/xray.config ] && source $module_path/xray.config
    if [ ! $core ]; then
      ui_print "---Do you want a custom installation---"
      ui_print "(If you don't know, please choose NO)"
      ui_print "VOL+ = NO, VOL- = YES"
      if $VKSEL; then
        ui_print "---Please select your core---"
        ui_print "VOL+ = xray/v2ray, VOL- = sing-box"
        if $VKSEL; then
          ui_print "---Please select xray or v2ray---"
          ui_print "VOL+ = xray, VOL- = v2ray"
          if $VKSEL; then
            core="xray"
            ui_print "---Core selected as xray---"
            selasset
          else
            ui_print "---Please select v2fly or sagernet---"
            ui_print "VOL+ = v2fly, VOL- = sagernet"
            if $VKSEL; then
              core="v2fly"
              ui_print "---Core selected as v2ray(v2fly)---"
              selasset
            else
              core="sagernet"
              ui_print "---Core selected as v2ray(sagerNet)---"
              selasset
            fi
          fi
        else
          core="sing-box"
          ui_print "---Core selected as sing-box---"
          selasset
        fi
      else
        core="custom"
        ui_print "---Start custom installation---"
        whichCustom
        selasset
      fi
    else
      ui_print "---Core selected as $core---"
      ui_print "---Asset selected as $asset---"
    fi
  fi
}

# get version arg
whichArch() {
  ui_print "---Select arch---"
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
  v2ray | sagernet)
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
  ui_print "---Deploy assets---"
  mkdir -p ${module_path}/assets
  case "${asset}" in
  loyalsoldier)
    /data/adb/magisk/busybox wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat -O /sdcard/Download/geoip.dat >&2
    if [ "$?" != "0" ]; then
      ui_print "---Download err---"
      abort
    fi
    /data/adb/magisk/busybox wget https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat -O /sdcard/Download/geosite.dat >&2
    if [ "$?" != "0" ]; then
      ui_print "---Download err---"
      abort
    fi
    cp /sdcard/Download/geoip.dat ${module_path}/assets
    cp /sdcard/Download/geosite.dat ${module_path}/assets
    ;;
  dat)
    unzip -j -o "${download_path}" "geoip.dat" -d ${module_path}/assets >&2
    unzip -j -o "${download_path}" "geosite.dat" -d ${module_path}/assets >&2
    ;;
  db)
    /data/adb/magisk/busybox wget https://github.com/SagerNet/sing-geoip/releases/latest/download/geoip.db -O /sdcard/Download/geoip.db >&2
    if [ "$?" != "0" ]; then
      ui_print "---Download err---"
      abort
    fi
    /data/adb/magisk/busybox wget https://github.com/SagerNet/sing-geosite/releases/latest/download/geosite.db -O /sdcard/Download/geosite.db >&2
    if [ "$?" != "0" ]; then
      ui_print "---Download err---"
      abort
    fi
    cp /sdcard/Download/geoip.db ${module_path}/assets
    cp /sdcard/Download/geosite.db ${module_path}/assets
    ;;
  customDat)
    if [ -f /sdcard/Download/geoip.dat ] && [ -f /sdcard/Download/geosite.dat ]; then
      cp /sdcard/Download/geoip.dat ${module_path}/assets
      cp /sdcard/Download/geosite.dat ${module_path}/assets
    else
      ui_print "---Please put geoip.dat & geosite.dat in /sdcard/Download---"
      abort
    fi
    ;;
  customDb)
    if [ -f /sdcard/Download/geoip.db ] && [ -f /sdcard/Download/geosite.db ]; then
      cp /sdcard/Download/geoip.db ${module_path}/assets
      cp /sdcard/Download/geosite.db ${module_path}/assets
    else
      ui_print "---Please put geoip.db & geosite.db in /sdcard/Download---"
      abort
    fi
    ;;
  esac
}

# get core
whichCore() {
  ui_print "---Download core---"
  case "$core" in
  custom)
    latest_version=custom
    ;;
  xray)
    download_link="https://github.com/XTLS/Xray-core/releases"
    github_api="https://api.github.com/repos/XTLS/Xray-core/releases"
    latest_version=$(/data/adb/magisk/busybox wget -qO- ${github_api} | grep -m 1 "tag_name" | awk '{print $2}')
    latest_version=${latest_version:2:-2}
    whichArch
    download_file=${version}
    download_path="/sdcard/Download/${download_file}"
    /data/adb/magisk/busybox wget "${download_link}/download/v${latest_version}/${download_file}" -O "${download_path}" >&2
    if [ "$?" != "0" ]; then
      ui_print "---Download err---"
      abort
    fi
    ;;
  v2ray)
    download_link="https://github.com/v2fly/v2ray-core/releases"
    github_api="https://api.github.com/repos/v2fly/v2ray-core/releases"
    latest_version=$(/data/adb/magisk/busybox wget -qO- ${github_api} | grep -m 1 "tag_name" | awk '{print $2}')
    latest_version=${latest_version:2:-2}
    whichArch
    download_file=${version}
    download_path="/sdcard/Download/${download_file}"
    /data/adb/magisk/busybox wget "${download_link}/download/v${latest_version}/${download_file}" -O "${download_path}" >&2
    if [ "$?" != "0" ]; then
      ui_print "---Download err---"
      abort
    fi
    ;;
  sagernet)
    download_link="https://github.com/SagerNet/v2ray-core/releases"
    github_api="https://api.github.com/repos/SagerNet/v2ray-core/releases"
    latest_version=$(/data/adb/magisk/busybox wget -qO- ${github_api} | grep -m 1 "tag_name" | awk '{print $2}')
    latest_version=${latest_version:2:-2}
    whichArch
    download_file=${version}
    download_path="/sdcard/Download/${download_file}"
    /data/adb/magisk/busybox wget "${download_link}/download/v${latest_version}/${download_file}" -O "${download_path}" >&2
    if [ "$?" != "0" ]; then
      ui_print "---Download err---"
      abort
    fi
    ;;
  sing-box)
    if [ "asset" != "customDb" ]; then
      asset="db"
    fi
    download_link="https://github.com/SagerNet/sing-box/releases"
    github_api="https://api.github.com/repos/SagerNet/sing-box/releases"
    latest_version=$(/data/adb/magisk/busybox wget -qO- ${github_api} | grep -m 1 "tag_name" | awk '{print $2}')
    latest_version=${latest_version:2:-2}
    whichArch
    download_file="sing-box-${latest_version}-${version}.tar.gz"
    download_path="/sdcard/Download/${download_file}"
    /data/adb/magisk/busybox wget "${download_link}/download/v${latest_version}/${download_file}" -O "${download_path}" >&2
    if [ "$?" != "0" ]; then
      ui_print "---Download err---"
      abort
    fi
    ;;
  esac
}

# deploy core
core() {
  ui_print "---Deploy core---"
  mkdir -p ${module_path}/bin
  case "${core}" in
  xray)
    unzip -j -o "${download_path}" "xray" -d ${module_path}/bin/ >&2
    ;;
  v2ray | sagernet)
    unzip -j -o "${download_path}" "v2ray" -d ${module_path}/bin/ >&2
    ;;
  sing-box)
    tar --strip-components=1 -xvzf ${download_path} -C ${module_path}/bin/ >&2
    ;;
  esac
}

installModule() {
  ui_print "---Release script---"
  mkdir -p ${module_path}/run
  mkdir -p ${module_path}/confs
  mkdir -p ${module_path}/scripts
  unzip -j -o "${ZIPFILE}" 'xray/scripts/*' -d ${module_path}/scripts >&2
  if [ ! -d /data/adb/service.d ]; then
    mkdir -p /data/adb/service.d
  fi
  unzip -j -o "${ZIPFILE}" 'xray4magisk_service.sh' -d /data/adb/service.d >&2
  unzip -j -o "${ZIPFILE}" 'uninstall.sh' -d $MODPATH >&2
  set_perm ${module_path}/scripts/xray.service 0 0 0755

  [ -f ${module_path}/xray.config ] ||
    unzip -j -o "${ZIPFILE}" "xray/etc/xray.config" -d ${module_path} >&2
  [ -f ${config_file} ] ||
    unzip -j -o "${ZIPFILE}" "xray/etc/confs/*" -d ${module_path}/confs >&2
  [ -f ${module_path}/appid.list ] ||
    echo "ALL" >${module_path}/appid.list
  [ -f ${module_path}/ignore_out.list ] ||
    touch ${module_path}/ignore_out.list
  [ -f ${module_path}/ap.list ] ||
    [ "$(getprop ro.product.device)" = "rubens" ] && echo "ap+" >${module_path}/ap.list || echo "wlan+" >${module_path}/ap.list
  [ -f ${module_path}/ipv6 ] ||
    echo "enable" >${module_path}/ipv6

  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm /data/adb/service.d/xray4magisk_service.sh 0 0 0755
  set_perm $MODPATH/uninstall.sh 0 0 0755
  set_perm_recursive ${module_path}/scripts 0 0 0755 0755
  set_perm ${module_path} 0 0 0755
  set_perm_recursive ${module_path}/bin 0 0 0755 0755

  unzip -j -o "${ZIPFILE}" "module.prop" -d $MODPATH >&2
  echo -n "version=Module v2.0, Core " >>$MODPATH/module.prop
  echo "${core} ${latest_version}" >>$MODPATH/module.prop
  echo "versionCode=20220918" >>$MODPATH/module.prop
  echo "config="config.json"" >${module_path}/xray.config
  echo "custom=$core" >>${module_path}/xray.config
  echo "# Update" >>${module_path}/xray.config
  echo "core=$core" >>${module_path}/xray.config
  echo "asset=$asset" >>${module_path}/xray.config
}

main() {
  selcore
  whichCore
  core
  asset
  installModule
}

main
