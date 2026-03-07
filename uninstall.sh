#!/system/bin/sh

ui_print "🔄 Reverting camera settings to system default..."
sleep 1
am force-stop com.sec.android.app.camera >/dev/null 2>&1
pm clear com.sec.android.app.camera >/dev/null 2>&1
ui_print "✅ Camera data cleared successfully."
sleep 1