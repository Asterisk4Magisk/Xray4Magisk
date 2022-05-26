#####################
# xray Customization
#####################

SKIPUNZIP=1
ASH_STANDALONE=1

if [ $BOOTMODE ! = true ] ; then
  abort "Error: Please install in Magisk Manager"
fi

# migrate old configuration
if [ -d "/data/xray" ]; then
  ui_print "- Old configuration detected, migrating."
  if [ -d "/data/adb/xray" ]; then
    abort "Please remove \"/data/adb/xray\" first!"
  fi
  mv /data/xray/ /data/adb/xray/
fi

# prepare xray execute environment
ui_print "- Prepare xray execute environment."
mkdir -p /data/adb/xray
mkdir -p /data/adb/xray/run
mkdir -p /data/adb/xray/bin
mkdir -p /data/adb/xray/confs
mkdir -p /data/adb/xray/scripts

download_xray_zip="/data/adb/xray/run/xray-core.zip"
custom="/sdcard/Download/Xray-core.zip"

if [ -f "${custom}" ]; then
  cp "${custom}" "${download_xray_zip}"
  ui_print "Info: Custom Xray-core found, starting installer"
  latest_xray_version=custom
else
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
  ui_print "Using version: ${version}"
  if [ -f /sdcard/Download/"${version}" ]; then
    cp /sdcard/Download/"${version}" "${download_xray_zip}"
    ui_print "Info: Xray-core already downloaded, starting installer"
    latest_xray_version=custom
  else
    # download latest xray core from official link
    ui_print "- Connect official xray download link."

    official_xray_link="https://github.com/XTLS/Xray-core/releases"

    if [ -x "$(which wget)" ] ; then
      latest_xray_version=`wget -qO- https://api.github.com/repos/XTLS/Xray-core/releases | grep -m 1 "tag_name" | grep -o "v[0-9.]*"`
    elif [ -x "$(which curl)" ]; then
      latest_xray_version=`curl -ks https://api.github.com/repos/XTLS/Xray-core/releases | grep -m 1 "tag_name" | grep -o "v[0-9.]*"`
    elif [ -x "/data/adb/magisk/busybox" ] ; then
      latest_xray_version=`/data/adb/magisk/busybox wget -qO- https://api.github.com/repos/XTLS/Xray-core/releases | grep -m 1 "tag_name" | grep -o "v[0-9.]*"`
    else
      ui_print "Error: Could not find curl or wget, please install one."
      abort
    fi

    if [ "${latest_xray_version}" = "" ] ; then
      ui_print "Error: Connect official xray download link failed." 
      ui_print "Tips: You can download xray core manually,"
      ui_print "      and put it in /sdcard/Download"
      abort
    fi
    ui_print "- Download latest xray core ${latest_xray_version}-${ARCH}"

    if [ -x "$(which wget)" ] ; then
      wget "${official_xray_link}/download/${latest_xray_version}/${version}" -O "${download_xray_zip}" >&2
    elif [ -x "$(which curl)" ]; then
      curl "${official_xray_link}/download/${latest_xray_version}/${version}" -kLo "${download_xray_zip}" >&2
    elif [ -x "/data/adb/magisk/busybox" ] ; then
      /data/adb/magisk/busybox wget "${official_xray_link}/download/${latest_xray_version}/${version}" -O "${download_xray_zip}" >&2
    else
      ui_print "Error: Could not find curl or wget, please install one."
      abort
    fi

    if [ "$?" != "0" ] ; then
      ui_print "Error: Download xray core failed."
      ui_print "Tips: You can download xray core manually,"
      ui_print "      and put it in /sdcard/Download"
      abort
    fi
  fi
fi

# install scripts
unzip -j -o "${ZIPFILE}" 'xray/scripts/*' -d /data/adb/xray/scripts >&2
if [ ! -d /data/adb/service.d ] ; then
  mkdir -p /data/adb/service.d
fi
unzip -j -o "${ZIPFILE}" 'xray4magisk_service.sh' -d /data/adb/service.d >&2
unzip -j -o "${ZIPFILE}" 'uninstall.sh' -d $MODPATH >&2
set_perm  /data/adb/xray/scripts/xray.service    0  0  0755

# stop service
/data/adb/xray/scripts/xray.service stop

# install xray execute file
ui_print "- Install xray core $ARCH execute files"
unzip -j -o "${download_xray_zip}" "geoip.dat" -d /data/adb/xray >&2
unzip -j -o "${download_xray_zip}" "geosite.dat" -d /data/adb/xray >&2
unzip -j -o "${download_xray_zip}" "xray" -d /data/adb/xray/bin >&2
rm "${download_xray_zip}"

# start service
/data/adb/xray/scripts/xray.service start

# copy xray data and config
ui_print "- Copy xray config and data files"
[ -f /data/adb/xray/confs/proxy.json ] || \
unzip -j -o "${ZIPFILE}" "xray/etc/confs/*" -d /data/adb/xray/confs >&2
[ -f /data/adb/xray/appid.list ] || \
echo "ALL" > /data/adb/xray/appid.list
[ -f /data/adb/xray/ignore_out.list ] || \
touch /data/adb/xray/ignore_out.list
[ -f /data/adb/xray/ap.list ] || \
echo "wlan+" > /data/adb/xray/ap.list
[ -f /data/adb/xray/ipv6 ] || \
echo "enable" > /data/adb/xray/ipv6


# generate module.prop
ui_print "- Generate module.prop"
rm -rf $MODPATH/module.prop
touch $MODPATH/module.prop
echo "id=xray4magisk" > $MODPATH/module.prop
echo "name=Xray4Magisk" >> $MODPATH/module.prop
echo -n "version=Module v1.6.0, Core " >> $MODPATH/module.prop
echo ${latest_xray_version} >> $MODPATH/module.prop
echo "versionCode=20220526" >> $MODPATH/module.prop
echo "author=Asterisk4Magisk" >> $MODPATH/module.prop
echo "description=xray core with service scripts for Android" >> $MODPATH/module.prop

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm  /data/adb/service.d/xray4magisk_service.sh    0  0  0755
set_perm  $MODPATH/uninstall.sh                         0  0  0755
set_perm_recursive  /data/adb/xray/scripts              0  0  0755
set_perm  /data/adb/xray                                0  0  0755
set_perm_recursive  /data/adb/xray/bin                  0  0  0755
