# Native TWRP for Samsung SM-T510 / gta3xlwifi

TWRP 3.7.1_12 / Android 12.1, ARM32 recovery with source-built ARM64 4.4 kernel.
The tested recovery reaches its menu automatically and supports touch, root ADB,
software recovery reboot and ROM installation. Samsung FBE data decryption is
unsupported: missing keystore services are reported while encrypted data stays
locked. No claim of general stability, MTP or backup/restore validation is made.

Includes the SM-T510 1200x1920 display, configfs USB, correct Android fs_mgr and
TWRP fstabs, libresetprop packaging and XZ ramdisk configuration. The compressed
ramdisk must stay below 16 MiB to avoid overlapping the bootloader's DTB address.
DECON display initialization must use the normal FBIOBLANK/UNBLANK sequence.
Recovery ADB has no authentication; the Android ROM has its separate policy.
TeamWin's recovery policy includes permissive domains even with global enforcing.

Clone at `device/samsung/gta3xlwifi` inside the separate TWRP checkout. Required
FBE-startup and library-relink platform fixes, pinned manifests, checked recovery
inputs and build/verification instructions are in:
https://github.com/oddhap/android_build_samsung_gta3xlwifi

Device reference audited: gta3xlwifi-dev/android_device_samsung_gta3xlwifi_twrp,
revision d74a521b1af73c8e9ee990aa763c6947d5eb3c55. This tree corrects that
reference's model, display geometry and boot header for the tested SM-T510.
New configuration is Apache-2.0; upstream and stock notices retain their terms.
