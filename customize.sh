#!/system/bin/sh
# ---------------------------------------------------------
# Universal Camera Enabler for Samsung
# Developer: GueRapii & Gustavoppw (@randommodules)
# License: Restricted - Permission required for code reuse.
# ---------------------------------------------------------

ui_print "  _______________________________________________  "
ui_print " |                                               | "
ui_print " |      📸 Universal Camera Enabler v1.2 📸      | "
ui_print " |      ✨ Dynamic Patching for Samsung ✨       | "
ui_print " |_______________________________________________| "
ui_print " "
sleep 1

ui_print "🔍 Analyzing device environment..."
BRAND=$(getprop ro.product.brand)
if [ "$BRAND" != "samsung" ]; then
    ui_print " ❌ ERROR: Non-Samsung device detected."
    abort    " 🚫 This module is strictly for Samsung devices."
fi
sleep 1

CAM_XML="$MODPATH/system/cameradata/camera-feature.xml"
SYS_CAM_XML="/system/cameradata/camera-feature.xml"

ui_print "[*] Initializing dynamic system patching..."
mkdir -p "$(dirname "$CAM_XML")"

if [ -f "$SYS_CAM_XML" ]; then
    ui_print "[*] Cloning system camera-feature.xml..."
    cp -af "$SYS_CAM_XML" "$CAM_XML"
    sleep 1
else
    abort " [!] CRITICAL ERROR: System camera-feature file not found."
fi

patch_cam_feature() {
    local NAME=$1
    local FULL_LINE=$2

    if grep -q "name=\"$NAME\"" "$CAM_XML"; then
        return 0
    fi

    local NEW_LINE=""
    if [ -n "$FULL_LINE" ]; then
        NEW_LINE="$FULL_LINE"
    elif echo "$NAME" | grep -q "RESOLUTION_FEATURE_MAP"; then
        local TEMPLATE=$(grep "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_1920X1080\"" "$CAM_XML" | head -n 1)
        [ -z "$TEMPLATE" ] && return 1
        
        NEW_LINE=$(echo "$TEMPLATE" | sed "s/name=\"[^\"]*\"/name=\"$NAME\"/")
        NEW_LINE=$(echo "$NEW_LINE" | sed 's/value="[^"]*"/value="true"/')

        if echo "$NEW_LINE" | grep -q "supported-mode=\""; then
            if ! echo "$NEW_LINE" | grep -q "pro_video"; then
                NEW_LINE=$(echo "$NEW_LINE" | sed 's/supported-mode="\([^"]*\)"/supported-mode="\1,pro_video"/')
            fi
        fi
    fi

    [ -z "$NEW_LINE" ] && return 1

    local TO_DISABLE=""
    if echo "$NAME" | grep -qE "7680X4320|120FPS"; then
        TO_DISABLE="hdr10 super-vdis object-tracking seamless-zoom-support physical-zoom-supported external-storage-support"
    elif echo "$NAME" | grep -qE "3840X2160|1920X1080"; then
        TO_DISABLE="super-vdis object-tracking seamless-zoom-support"
    fi

    for attr in $TO_DISABLE; do
        NEW_LINE=$(echo "$NEW_LINE" | sed "s/ $attr=\"[^\"]*\"/ $attr=\"false\"/g")
    done

    sed -i "/<\/resources>/i \    $NEW_LINE" "$CAM_XML"
}

ui_print "🚀 Injecting resolutions and frame rates..."
sleep 1

# 8K Support (30fps & 24fps)
patch_cam_feature "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_7680X4320"
patch_cam_feature "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_7680X4320_24FPS"
patch_cam_feature "SUPPORT_PRO_VIDEO_8K" '<local name="SUPPORT_PRO_VIDEO_8K" value="true"/>'

# 4K Support (120fps, 60fps, 30fps)
patch_cam_feature "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_3840X2160_120FPS"
patch_cam_feature "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_3840X2160_60FPS"
patch_cam_feature "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_3840X2160_30FPS"
patch_cam_feature "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_3840X2160"
sleep 1

# 1080p Support (120fps, 60fps, 30fps)
patch_cam_feature "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_1920X1080_120FPS"
patch_cam_feature "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_1920X1080_60FPS"
patch_cam_feature "BACK_CAMCORDER_RESOLUTION_FEATURE_MAP_1920X1080"
sleep 1

ui_print "🌈 Enabling Global HDR Features..."
sleep 1
patch_cam_feature "SUPPORT_VIDEO_HDR" '<local name="SUPPORT_VIDEO_HDR" value="true"/>'
patch_cam_feature "SUPPORT_AUTO_HDR_MENU" '<local name="SUPPORT_AUTO_HDR_MENU" value="true"/>'

# Pro Video UI Flags
ui_print "🎬 Unlocking Pro Video UI Flags..."
patch_cam_feature "SUPPORT_PRO_VIDEO_WIDE_LENS_120FPS" '<local name="SUPPORT_PRO_VIDEO_WIDE_LENS_120FPS" value="true"/>'
patch_cam_feature "SUPPORT_PRO_VIDEO_WIDE_LENS_60FPS" '<local name="SUPPORT_PRO_VIDEO_WIDE_LENS_60FPS" value="true"/>'
sleep 1

ui_print "🔐 Optimizing file permissions..."
sleep 1
set_perm "$CAM_XML" 0 0 0644

ui_print "🔄 Auto-applying changes (Resetting Camera App)..."
am force-stop com.sec.android.app.camera >/dev/null 2>&1
pm clear com.sec.android.app.camera >/dev/null 2>&1
ui_print " ✅ Camera app has been reset."
sleep 1

ui_print " "
ui_print " 🎉 SUCCESS: Camera features have been enabled! "
ui_print " ⚠️ Note: Hardware limits still apply.        "
ui_print " 📲 Please reboot to apply changes.           "
ui_print " "