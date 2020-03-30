#!/sbin/sh
#####################
# V2ray Customization
#####################
SKIPUNZIP=1

# prepare v2ray execute environment
ui_print "- Prepare V2Ray execute environment."
mkdir -p /data/v2ray
mkdir -p /data/v2ray/run
mkdir -p $MODPATH/scripts
mkdir -p $MODPATH/system/bin
mkdir -p $MODPATH/system/etc
# download latest v2ray core from official link
ui_print "- Connect official V2Ray download link."
official_v2ray_link="https://github.com/v2ray/v2ray-core/releases"
latest_v2ray_version=`curl -k -s -I "${official_v2ray_link}/latest" | grep -i location | grep -o "tag.*" | grep -o "v[0-9.]*"`
if [ "${latest_v2ray_version}" = "" ] ; then
  ui_print "Error: Connect official V2Ray download link failed." 
  exit 1
fi
ui_print "- Download latest V2Ray core ${latest_v2ray_version}-${ARCH}"
case "${ARCH}" in
  arm)
    download_v2ray_link="${official_v2ray_link}/download/${latest_v2ray_version}/v2ray-linux-arm.zip"
    ;;
  arm64)
    download_v2ray_link="${official_v2ray_link}/download/${latest_v2ray_version}/v2ray-linux-arm64.zip"
    ;;
  x86)
    download_v2ray_link="${official_v2ray_link}/download/${latest_v2ray_version}/v2ray-linux-32.zip"
    ;;
  x64)
    download_v2ray_link="${official_v2ray_link}/download/${latest_v2ray_version}/v2ray-linux-64.zip"
    ;;
esac
download_v2ray_zip="/data/v2ray/run/v2ray-core.zip"
curl "${download_v2ray_link}" -k -L -o "${download_v2ray_zip}" >&2
if [ "$?" != "0" ] ; then
  ui_print "Error: Download V2Ray core failed."
  exit 1
fi
# install v2ray execute file
ui_print "- Install V2Ray core $ARCH execute files"
unzip -j -o "${download_v2ray_zip}" "geoip.dat" -d /data/v2ray >&2
unzip -j -o "${download_v2ray_zip}" "geosite.dat" -d /data/v2ray >&2
unzip -j -o "${download_v2ray_zip}" "v2ray" -d $MODPATH/system/bin >&2
unzip -j -o "${download_v2ray_zip}" "v2ctl" -d $MODPATH/system/bin >&2
unzip -j -o "${ZIPFILE}" 'v2ray/scripts/*' -d $MODPATH/scripts >&2
unzip -j -o "${ZIPFILE}" "v2ray/bin/$ARCH/v2ray-dns.keeper" -d $MODPATH/scripts >&2
unzip -j -o "${ZIPFILE}" 'service.sh' -d $MODPATH >&2
unzip -j -o "${ZIPFILE}" 'uninstall.sh' -d $MODPATH >&2
rm "${download_v2ray_zip}"
# copy v2ray data and config
ui_print "- Copy V2Ray config and data files"
[ -f /data/v2ray/softap.list ] || \
echo "softap0" > /data/v2ray/softap.list
[ -f /data/v2ray/resolv.conf ] || \
unzip -j -o "${ZIPFILE}" "v2ray/etc/resolv.conf" -d /data/v2ray >&2
unzip -j -o "${ZIPFILE}" "v2ray/etc/config.json.template" -d /data/v2ray >&2
[ -f /data/v2ray/config.json ] || \
cp /data/v2ray/config.json.template /data/v2ray/config.json
ln -s /data/v2ray/resolv.conf $MODPATH/system/etc/resolv.conf
# generate module.prop
ui_print "- Generate module.prop"
rm -rf $MODPATH/module.prop
touch $MODPATH/module.prop
echo "id=v2ray" > $MODPATH/module.prop
echo "name=V2ray for Android" >> $MODPATH/module.prop
echo -n "version=" >> $MODPATH/module.prop
echo ${latest_v2ray_version} >> $MODPATH/module.prop
echo "versionCode=20200326" >> $MODPATH/module.prop
echo "author=chendefine" >> $MODPATH/module.prop
echo "description=V2ray core with service scripts for Android" >> $MODPATH/module.prop

inet_uid="3003"
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm  $MODPATH/service.sh    0  0  0755
set_perm  $MODPATH/uninstall.sh    0  0  0755
set_perm  $MODPATH/scripts/start.sh    0  0  0755
set_perm  $MODPATH/scripts/v2ray.inotify    0  0  0755
set_perm  $MODPATH/scripts/v2ray.service    0  0  0755
set_perm  $MODPATH/scripts/v2ray.tproxy     0  0  0755
set_perm  $MODPATH/scripts/v2ray-dns.handle    0  0  0755
set_perm  $MODPATH/scripts/v2ray-dns.keeper    0  0  0755
set_perm  $MODPATH/scripts/v2ray-dns.service   0  0  0755
set_perm  $MODPATH/system/bin/v2ray  ${inet_uid}  ${inet_uid}  0755
set_perm  $MODPATH/system/bin/v2ctl  ${inet_uid}  ${inet_uid}  0755
set_perm  /data/v2ray                ${inet_uid}  ${inet_uid}  0755
