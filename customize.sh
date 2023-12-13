#####################
# xray Customization
#####################

SKIPUNZIP=1
ASH_STANDALONE=1
module_path="/data/adb/xray"

chooseport_legacy() {
    # Keycheck binary by someone755 @Github, idea for code below by Zappo @xda-developers
    # Calling it first time detects previous input. Calling it second time will do what we want
    [ "$1" ] && local delay=$1 || local delay=15
    local error=false
    while true; do
        timeout 0 ${TMPDIR}/keycheck
        timeout $delay ${TMPDIR}/keycheck
        local sel=$?
        if [ $sel -eq 42 ]; then
            return 0
        elif [ $sel -eq 41 ]; then
            return 1
        elif $error; then
            abort "- Volume key not detected!"
        else
            error=true
            ui_print "- Volume key not detected. Try again"
        fi
    done
}

chooseport() {
    # Original idea by chainfire and ianmacd @xda-developers
    [ "$1" ] && local delay=$1 || local delay=15
    local error=false
    while true; do
        local count=0
        while true; do
            timeout 1 /system/bin/getevent -lqc 1 2>&1 >$TMPDIR/events &
            sleep 0.5
            if ($(grep -q 'KEY_VOLUMEUP *DOWN' $TMPDIR/events)); then
                return 0
            elif ($(grep -q 'KEY_VOLUMEDOWN *DOWN' $TMPDIR/events)); then
                return 1
            fi
            count=$((count + 1))
            [ $count -gt 29 ] && break
        done
        if $error; then
            # abort "Volume key not detected!"
            ui_print "- Volume key not detected. Trying keycheck method"
            export chooseport=chooseport_legacy VKSEL=chooseport_legacy
            chooseport_legacy $delay
            return $?
        else
            error=true
            ui_print "- Volume key not detected. Try again"
        fi
    done
}

VKSEL=chooseport

installCore() {
    case "$1" in
    v2ray)
        sed -i 's/coreType: .*/coreType: v2ray/g' ${module_path}/xrayhelper.yml
        sed -i 's/corePath: .*/corePath: \/data\/adb\/xray\/bin\/v2ray/g' ${module_path}/xrayhelper.yml
        sed -i 's/coreConfig: .*/coreConfig: \/data\/adb\/xray\/v2ray.v5.json/g' ${module_path}/xrayhelper.yml
        ui_print "- Install geodata asset"
        ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update geodata
        ui_print "- Install v2ray core"
        ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update core
        ;;
    sing-box)
        sed -i 's/coreType: .*/coreType: sing-box/g' ${module_path}/xrayhelper.yml
        sed -i 's/corePath: .*/corePath: \/data\/adb\/xray\/bin\/sing-box/g' ${module_path}/xrayhelper.yml
        sed -i 's/coreConfig: .*/coreConfig: \/data\/adb\/xray\/singconfs\//g' ${module_path}/xrayhelper.yml
        ui_print "- Install geodata asset"
        ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update geodata
        ui_print "- Install sing-box core"
        ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update core
        ;;
    mihomo)
        sed -i 's/coreType: .*/coreType: mihomo/g' ${module_path}/xrayhelper.yml
        sed -i 's/corePath: .*/corePath: \/data\/adb\/xray\/bin\/mihomo/g' ${module_path}/xrayhelper.yml
        sed -i 's/coreConfig: .*/coreConfig: \/data\/adb\/xray\/mihomoconfs\//g' ${module_path}/xrayhelper.yml
        sed -i 's/template: .*/template: \/data\/adb\/xray\/mihomoconfs\/template\.yaml/g' ${module_path}/xrayhelper.yml
        ui_print "- Install yacd-meta"
        ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update yacd-meta
        ui_print "- Install mihomo(clash.meta) core"
        ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update core
        ;;
    xray)
        sed -i 's/coreType: .*/coreType: xray/g' ${module_path}/xrayhelper.yml
        sed -i 's/corePath: .*/corePath: \/data\/adb\/xray\/bin\/xray/g' ${module_path}/xrayhelper.yml
        sed -i 's/coreConfig: .*/coreConfig: \/data\/adb\/xray\/confs\//g' ${module_path}/xrayhelper.yml
        ui_print "- Install geodata asset"
        ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update geodata
        ui_print "- Install xray core"
        ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update core
        ;;
    skip)
        ui_print "- Skip core installation"
        ui_print "- You need install core and configure xrayhelper.yml after module installation"
        ;;
    *)
        installCore_VK
        ;;
    esac
}

installCore_VK() {
    ui_print
    ui_print "- Do you need install core online?"
    ui_print "* VOL+ = YES, VOL- = NO *"
    if $VKSEL; then
        ui_print
        ui_print "- Please select your core"
        ui_print "* VOL+ = xray/v2ray, VOL- = sing-box/mihomo(clash.meta) *"
        if $VKSEL; then
            ui_print
            ui_print "- Please select xray or v2ray"
            ui_print "* VOL+ = xray, VOL- = v2ray *"
            if $VKSEL; then
                installCore xray
            else
                installCore v2ray
            fi
        else
            ui_print
            ui_print "- Please select sing-box or mihomo(clash.meta)"
            ui_print "* VOL+ = sing-box, VOL- = mihomo(clash.meta) *"
            if $VKSEL; then
                installCore sing-box
            else
                installCore mihomo
            fi
        fi
    else
        installCore skip
    fi
}

installModule() {
    ui_print "- Install xrayhelper"
    mkdir -p ${module_path}/bin
    unzip -j -o "${ZIPFILE}" "xray/bin/${ARCH}/xrayhelper" -d ${module_path}/bin >&2
    set_perm ${module_path}/bin/xrayhelper 0 0 0755
    [ -d "/system/xbin" ] && local bin_dir="/system/xbin" || local bin_dir="/system/bin"
    mkdir -p ${MODPATH}${bin_dir}
    unzip -j -o "${ZIPFILE}" "xray/bin/${ARCH}/xrayhelper" -d ${MODPATH}${bin_dir} >&2
    set_perm ${MODPATH}${bin_dir}/xrayhelper 0 0 0755
    [ -f ${module_path}/xrayhelper.yml ] ||
        unzip -j -o "${ZIPFILE}" 'xray/etc/xrayhelper.yml' -d ${module_path} >&2

    ui_print "- Release configs"
    unzip -j -o "${ZIPFILE}" 'xray/etc/v2ray.v5.json' -d ${module_path} >&2
    if [ ! -d ${module_path}/confs ]; then
        mkdir -p ${module_path}/confs
        unzip -j -o "${ZIPFILE}" 'xray/etc/confs/proxy.json' -d ${module_path}/confs >&2
    fi
    unzip -j -o "${ZIPFILE}" 'xray/etc/confs/base.json' -d ${module_path}/confs >&2
    unzip -j -o "${ZIPFILE}" 'xray/etc/confs/dns.json' -d ${module_path}/confs >&2
    unzip -j -o "${ZIPFILE}" 'xray/etc/confs/policy.json' -d ${module_path}/confs >&2
    unzip -j -o "${ZIPFILE}" 'xray/etc/confs/routing.json' -d ${module_path}/confs >&2
    if [ ! -d ${module_path}/singconfs ]; then
        mkdir -p ${module_path}/singconfs
        unzip -j -o "${ZIPFILE}" 'xray/etc/singconfs/proxy.json' -d ${module_path}/singconfs >&2
    fi
    unzip -j -o "${ZIPFILE}" 'xray/etc/singconfs/base.json' -d ${module_path}/singconfs >&2
    unzip -j -o "${ZIPFILE}" 'xray/etc/singconfs/dns.json' -d ${module_path}/singconfs >&2
    unzip -j -o "${ZIPFILE}" 'xray/etc/singconfs/route.json' -d ${module_path}/singconfs >&2
    if [ ! -d ${module_path}/mihomoconfs ]; then
        mkdir -p ${module_path}/mihomoconfs
    fi
    unzip -j -o "${ZIPFILE}" 'xray/etc/mihomoconfs/template.yaml' -d ${module_path}/mihomoconfs >&2

    if [ -f /sdcard/xray4magisk.setup ]; then
        installCore $(head -1 /sdcard/xray4magisk.setup)
    else
        installCore_VK
    fi
    ui_print "- Release scripts"
    mkdir -p ${module_path}/run
    mkdir -p ${module_path}/scripts
    unzip -j -o "${ZIPFILE}" 'xray/scripts/*' -d ${module_path}/scripts >&2
    if [ ! -d /data/adb/service.d ]; then
        mkdir -p /data/adb/service.d
    fi
    unzip -j -o "${ZIPFILE}" 'xray4magisk_service.sh' -d /data/adb/service.d >&2
    unzip -j -o "${ZIPFILE}" 'uninstall.sh' -d $MODPATH >&2

    ui_print "- Set permission"
    set_perm /data/adb/service.d/xray4magisk_service.sh 0 0 0755
    set_perm $MODPATH/uninstall.sh 0 0 0755
    set_perm_recursive ${module_path}/scripts 0 0 0755 0755
    set_perm ${module_path} 0 0 0755
    unzip -j -o "${ZIPFILE}" "module.prop" -d $MODPATH >&2
}

main() {
    if [ ! $BOOTMODE ]; then
        abort "Error: Please install in Magisk Manager or KernelSU Manager"
    fi
    if [ ! -d ${module_path} ]; then
        mkdir -p ${module_path}
    fi
    unzip -j -o "${ZIPFILE}" "xray/bin/${ARCH}/keycheck" -d ${TMPDIR} >&2
    set_perm ${TMPDIR}/keycheck 0 0 0755
    installModule
}

main
