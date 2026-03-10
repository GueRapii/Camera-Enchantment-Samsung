# 📸 Universal Camera Enabler for Samsung

A Magisk Module designed to dynamically patch Samsung's camera configuration to unlock advanced features and resolutions that might be hidden or disabled by default.

## ✨ Features

This module performs dynamic patching on `camera-feature.xml` to enable:

*   **🎥 Video Resolutions:**
    *   **8K Support:** 8K @ 30fps & 24fps.
    *   **4K Support:** 4K @ 120fps, 60fps, and 30fps.
    *   **FHD Support:** 1080p @ 120fps and 60fps.
*   **🎬 Pro Video Enhancements:**
    *   Unlocks Pro Video UI flags.
    *   Enables Wide Lens support for 120fps/60fps in Pro Video mode.
    *   Enables `SUPPORT_PRO_VIDEO_8K`.
*   **🌈 HDR Features:**
    *   Global Video HDR support.
    *   Auto HDR Menu activation.
*   **🛠️ Smart Patching:**
    *   Clones your system's original XML to ensure compatibility.
    *   Automatically disables conflicting features (like VDIS or Object Tracking) on high-bandwidth modes (8K/120FPS) to prevent crashes.

## ⚠️ Requirements

*   **Device:** Samsung (Strictly enforced via `ro.product.brand` check).
*   **Root:** Magisk or KernelSU installed.
*   **OS:** Android-based Samsung OneUI.

## 🚀 Installation

1.  Download the module zip.
2.  Install via Magisk App / KernelSU.
3.  Reboot your device.
4.  **Note:** The module automatically clears Camera app data during installation to apply new configurations.

## 💬 Support & Community

Join our Telegram channel for updates or contact the developers directly:

[![Telegram Channel](https://img.shields.io/badge/Telegram-Channel-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/randommodules)
[![GueRapii](https://img.shields.io/badge/Chat-GueRapii-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/GueRapii)
[![Gustavoppw](https://img.shields.io/badge/Chat-Gustavoppw-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/Gustavoppw)

## ⚠️ Disclaimer

**Hardware Limits Apply.** This module unlocks software flags. If your device's ISP (Image Signal Processor) or Sensor does not physically support 8K or 120FPS, the options may appear but fail to record or cause the camera app to crash. Use with caution.

## 🛠️ Uninstallation

Simply remove the module via Magisk and reboot. The `uninstall.sh` script will ensure your camera settings are reverted and data is cleared to restore default behavior.

## 📜 License

Copyright © 2026 GueRapii & Gustavoppw (@randommodules).
This module is free to use. However, **copying, redistributing, or using this code in other scripts requires explicit permission** from the developer and must include proper attribution.

---
*Developed with ✨ for Samsung Power Users.*