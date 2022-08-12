LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := fstab.$(TARGET_DEVICE)
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
LOCAL_SRC_FILES    := vendor/etc/fstab_dynamic.qcom
else
LOCAL_SRC_FILES := vendor/etc/fstab.qcom
endif
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_STEM := fstab.qcom
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/etc
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ramdisk-fstab.$(TARGET_DEVICE)
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
LOCAL_SRC_FILES    := vendor/etc/fstab_dynamic.qcom
else
LOCAL_SRC_FILES := vendor/etc/fstab.qcom
endif
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_STEM := fstab.qcom
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_RAMDISK_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := vendor-fstab.$(TARGET_DEVICE)
ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
LOCAL_SRC_FILES    := vendor/etc/fstab_dynamic.qcom
else
LOCAL_SRC_FILES := vendor/etc/fstab.qcom
endif
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_STEM := fstab.qcom
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_VENDOR_RAMDISK_OUT)/first_stage_ramdisk
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := init.sm6150
LOCAL_SRC_FILES := vendor/etc/init/init.sm6150.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_STEM := init.sm6150
LOCAL_MODULE_SUFFIX := .rc
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/etc/init
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ueventd
LOCAL_SRC_FILES := vendor/ueventd.rc
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_STEM := ueventd
LOCAL_MODULE_SUFFIX := .rc
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)
include $(BUILD_PREBUILT)
