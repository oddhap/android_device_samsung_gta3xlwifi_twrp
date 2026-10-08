# PIN-free recovery fix and validation

The complete source patch is [patches/system-vold-complete.patch](patches/system-vold-complete.patch).
It is relative to TeamWin vold `a164ba05c5fef288059774a776b2e6e1119957cf`,
and includes all previous FBE port changes plus the PIN-free fixes.

[Detailed cause, fix, device validation and reproduction tools](https://github.com/oddhap/android_build_samsung_gta3xlwifi/blob/lineage-21.0-arm64/TWRP_PINFREE.md).

[Download the physically tested image and installation instructions](https://github.com/oddhap/android_build_samsung_gta3xlwifi/releases/tag/lineage-21.0-arm64-beta-20261007).

The image was tested with encrypted user 0 on SM-T510 / LineageOS 21:
automatic CE unlock without PIN, storage locked before PIN verification,
correct PIN unlock, CE read/write, stable recovery and return to ARM64 Android.
Other devices, firmware bases and password types are outside this test scope.
