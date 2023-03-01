# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Platform Path
PLATFORM_COMMON_PATH := device/motorola/sm6150-common

# Platform
SM6150 := sm6150
TARGET_KERNEL_VERSION := 4.14
PRODUCT_PLATFORM_MOT := true
TARGET_BOARD_PLATFORM := $(SM6150)

# Rootdir Path
MOTOROLA_ROOT := $(PLATFORM_COMMON_PATH)/rootdir

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(PLATFORM_COMMON_PATH)/overlay

# Dynamic Partitions: Enable DP
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# A/B support
AB_OTA_UPDATER := true
PRODUCT_SHIPPING_API_LEVEL := 29

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    system \
    vendor \
    vbmeta

ifneq ($(TARGET_USES_LEGACY_AB),true)
AB_OTA_PARTITIONS += \
    product
endif
ifeq ($(TARGET_HAS_VBMETA_SYSTEM),true)
AB_OTA_PARTITIONS += \
    vbmeta_system
endif

# Audio
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml

# Qualcomm WiFi Overlay
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(MOTOROLA_ROOT)/vendor/etc/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf

# Qualcomm WiFi Configuration
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# Platform specific init
ifneq ($(TARGET_USES_LEGACY_AB),true)
ifeq ($(TARGET_COPY_OUT_SYSTEM_EXT),system_ext)
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/fstab_system_ext.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom
else
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/fstab.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom
endif
else
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/fstab_legacy.qcom:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.qcom
endif

# QCOM Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.qcom.bluetooth.soc=cherokee

# Gatekeeper
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.gatekeeper.disable_spu=true

# Power
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/powerhint.json:$(TARGET_COPY_OUT_VENDOR)/etc/powerhint.json

PRODUCT_USES_PIXEL_POWER_HAL := true

# Telephony
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.default_network=10,10

# Camera
TARGET_USES_64BIT_CAMERA := true

$(call inherit-product, device/motorola/common/common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, vendor/motorola/sm6150-common/sm6150-common-vendor.mk)
