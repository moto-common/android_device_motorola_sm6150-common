# Copyright 2014 The Android Open Source Project
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

TARGET_ARCH_VARIANT := armv8-a
TARGET_2ND_ARCH_VARIANT := armv8-a

BOARD_KERNEL_BASE        := 0x00000000
BOARD_KERNEL_PAGESIZE    := 4096
BOARD_RAMDISK_OFFSET     := 0x01000000
BOARD_DTB_OFFSET         := 0x01f00000
BOARD_MKBOOTIMG_ARGS += --dtb_offset $(BOARD_DTB_OFFSET)

ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab_dynamic.qcom
else
TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab.qcom
endif

# Kernel
BOARD_KERNEL_CMDLINE += androidboot.usbcontroller=a600000.dwc3

# SELinux
BOARD_VENDOR_SEPOLICY_DIRS += $(PLATFORM_COMMON_PATH)/sepolicy_platform

# Boot Image Header
BOARD_BOOT_HEADER_VERSION ?= 2
BOARD_INCLUDE_DTB_IN_BOOTIMG := true

# Build a separate vendor.img
TARGET_COPY_OUT_VENDOR := vendor
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
# This platform has a metadata partition: declare this
# to create a mount point for it
BOARD_USES_METADATA_PARTITION := true
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_SUPER_PARTITION_SIZE := 9729736704
BOARD_SUPER_PARTITION_GROUPS := mot_dynamic_partitions

# Set error limit to SUPER_PARTITION_SIZE - 500MiB
BOARD_SUPER_PARTITION_ERROR_LIMIT := 9205448704

# DYNAMIC_PARTITIONS_SIZE = (SUPER_PARTITION_SIZE / 2) - 4MB
BOARD_MOT_DYNAMIC_PARTITIONS_SIZE := 4864868352
BOARD_MOT_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    product \
    vendor

# Slightly overprovision dynamic partitions with 50MiB to
# allow on-device file editing
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 52428800
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE := 52428800
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 52428800
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_PRODUCT := product
endif

# Android Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag

# DTBO Recovery
BOARD_INCLUDE_RECOVERY_DTBO := true

# USB
SOONG_CONFIG_MOTO_COMMON_USB_USB_CONTROLLER_NAME := 4e00000

include device/motorola/common/CommonConfig.mk
