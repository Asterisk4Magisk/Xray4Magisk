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
        timeout $delay /system/bin/getevent -lqc 1 2>&1 >$TMPDIR/events &
        while true; do
            count=$((count + 1))
            if ($(grep -q 'KEY_VOLUMEUP *DOWN' $TMPDIR/events)); then
                return 0
            elif ($(grep -q 'KEY_VOLUMEDOWN *DOWN' $TMPDIR/events)); then
                return 1
            fi
            [ $count -gt 29 ] && break
            sleep 0.5
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

selectCore() {
    case "$1" in
    v2ray)
        sed -i 's/coreType: .*/coreType: v2ray/g' ${module_path}/xrayhelper.yml
        sed -i 's/corePath: .*/corePath: \/data\/adb\/xray\/bin\/v2ray/g' ${module_path}/xrayhelper.yml
        sed -i 's/coreConfig: .*/coreConfig: \/data\/adb\/xray\/v2ray.v5.json/g' ${module_path}/xrayhelper.yml
        ;;
    sing-box)
        sed -i 's/coreType: .*/coreType: sing-box/g' ${module_path}/xrayhelper.yml
        sed -i 's/corePath: .*/corePath: \/data\/adb\/xray\/bin\/sing-box/g' ${module_path}/xrayhelper.yml
        sed -i 's/coreConfig: .*/coreConfig: \/data\/adb\/xray\/singconfs\//g' ${module_path}/xrayhelper.yml
        ;;
    clash)
        sed -i 's/coreType: .*/coreType: clash/g' ${module_path}/xrayhelper.yml
        sed -i 's/corePath: .*/corePath: \/data\/adb\/xray\/bin\/clash/g' ${module_path}/xrayhelper.yml
        sed -i 's/coreConfig: .*/coreConfig: \/data\/adb\/xray\/clashconfs\//g' ${module_path}/xrayhelper.yml
        sed -i 's/template: .*/template: \/data\/adb\/xray\/clashconfs\/template\.yaml/g' ${module_path}/xrayhelper.yml
        ;;
    clash.meta)
        sed -i 's/coreType: .*/coreType: clash\.meta/g' ${module_path}/xrayhelper.yml
        sed -i 's/corePath: .*/corePath: \/data\/adb\/xray\/bin\/clash\.meta/g' ${module_path}/xrayhelper.yml
        sed -i 's/coreConfig: .*/coreConfig: \/data\/adb\/xray\/clashmetaconfs\//g' ${module_path}/xrayhelper.yml
        sed -i 's/template: .*/template: \/data\/adb\/xray\/clashmetaconfs\/template\.yaml/g' ${module_path}/xrayhelper.yml
        ;;
    *)
        sed -i 's/coreType: .*/coreType: xray/g' ${module_path}/xrayhelper.yml
        sed -i 's/corePath: .*/corePath: \/data\/adb\/xray\/bin\/xray/g' ${module_path}/xrayhelper.yml
        sed -i 's/coreConfig: .*/coreConfig: \/data\/adb\/xray\/confs\//g' ${module_path}/xrayhelper.yml
        ;;
    esac
}

installCore() {
    ui_print
    ui_print "- Do you need install core online?"
    ui_print "* VOL+ = YES, VOL- = NO *"
    if $VKSEL; then
        ui_print
        ui_print "- Please select your core"
        ui_print "* VOL+ = xray/v2ray/sing-box, VOL- = clash/clash.meta *"
        if $VKSEL; then
            ui_print
            ui_print "- Please select xray/v2ray or sing-box"
            ui_print "* VOL+ = xray/v2ray, VOL- = sing-box *"
            if $VKSEL; then
                ui_print
                ui_print "- Please select xray or v2ray"
                ui_print "* VOL+ = xray, VOL- = v2ray *"
                if $VKSEL; then
                    selectCore xray
                    ui_print "- Install geodata asset"
                    ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update geodata
                    ui_print "- Install xray core"
                    ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update core
                else
                    selectCore v2ray
                    ui_print "- Install geodata asset"
                    ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update geodata
                    ui_print "- Install v2ray core"
                    ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update core
                fi
            else
                selectCore sing-box
                ui_print "- Install geodata asset"
                ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update geodata
                ui_print "- Install sing-box core"
                ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update core
            fi
        else
            ui_print
            ui_print "- Please select clash or clash.meta"
            ui_print "* VOL+ = clash, VOL- = clash.meta *"
            if $VKSEL; then
                selectCore clash
                ui_print "- Install clash core"
                ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update core
            else
                selectCore clash.meta
                ui_print "- Install clash.meta core"
                ${module_path}/bin/xrayhelper -c ${module_path}/xrayhelper.yml update core
            fi
        fi
    else
        ui_print "- Skip core installation"
        ui_print "- You need install core and configure xrayhelper.yml after module installation"
    fi
}

installModule() {
    ui_print "- Install xrayhelper"
    mkdir -p ${module_path}/bin
    unzip -j -o "${ZIPFILE}" "xray/bin/${ARCH}/xrayhelper" -d ${module_path}/bin >&2
    set_perm ${module_path}/bin/xrayhelper 0 0 0755
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
    if [ ! -d ${module_path}/clashconfs ]; then
        mkdir -p ${module_path}/clashconfs
    fi
    unzip -j -o "${ZIPFILE}" 'xray/etc/clashconfs/template.yaml' -d ${module_path}/clashconfs >&2
    if [ ! -d ${module_path}/clashmetaconfs ]; then
        mkdir -p ${module_path}/clashmetaconfs
    fi
    unzip -j -o "${ZIPFILE}" 'xray/etc/clashmetaconfs/template.yaml' -d ${module_path}/clashmetaconfs >&2

    installCore
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
