# SPDX-License-Identifier: Apache-2.0
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

PRODUCT_NAME := twrp_gta3xlwifi
PRODUCT_DEVICE := gta3xlwifi
PRODUCT_BRAND := samsung
PRODUCT_MANUFACTURER := samsung
PRODUCT_MODEL := SM-T510
PRODUCT_CHARACTERISTICS := tablet
PRODUCT_SHIPPING_API_LEVEL := 28

# These are recovery-only properties. The Android ROM product is separate.
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.hardware=exynos7904 \
    ro.adb.secure=0 \
    ro.adb.secure.recovery=0

PRODUCT_PACKAGES += resetprop
