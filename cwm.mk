LOCAL_PATH := device/samsung/janice

DEVICE_DISABLE_F2FS := true

# CyanogenMod CWM
BOARD_CUSTOM_GRAPHICS := ../../../device/samsung/janice/recovery/graphics.cpp
RECOVERY_FSTAB_VERSION := 2

# Init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/device_tunables.rc:root/device_tunables.rc \
    $(LOCAL_PATH)/rootdir/init.kernel.rc:root/init.kernel.rc \
    $(LOCAL_PATH)/rootdir/init.samsungjanice.rc:root/init.samsungjanice.rc \
    $(LOCAL_PATH)/rootdirnew/init.recovery.samsungjanice.rc:root/init.recovery.samsungjanice.rc \
    $(LOCAL_PATH)/rootdir/ueventd.samsungjanice.rc:root/ueventd.samsungjanice.rc \
    $(LOCAL_PATH)/rootdir/init.samsungjanice.usb.rc:root/init.samsungjanice.usb.rc

ifeq ($(DEVICE_DISABLE_F2FS),true)
# fstab
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/fstab.samsungjanice:root/fstab.samsungjanice
endif
