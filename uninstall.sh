##########################################################################################
#
# Xray Magisk Module Uninstaller Script
#
##########################################################################################

remove_xray_data_dir() {
  rm -rf /data/adb/xray
}

remove_xray_data_dir
rm -rf /data/adb/service.d/xray4magisk_service.sh
