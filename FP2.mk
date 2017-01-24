TARGET_USES_QCOM_BSP := true

ifeq ($(TARGET_USES_QCOM_BSP), true)
# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
endif #TARGET_USES_QCOM_BSP

#TARGET_DISABLE_DASH := true
#TARGET_DISABLE_OMX_SECURE_TEST_APP := true

# media_profiles and media_codecs xmls for 8974
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/fairphone_devices/FP2/media/media_profiles_8974.xml:system/etc/media_profiles.xml \
                      device/fairphone_devices/FP2/media/media_codecs_8974.xml:system/etc/media_codecs.xml
endif  #TARGET_ENABLE_QC_AV_ENHANCEMENTS

ifeq ($(PROPRIETARY_BLOBS_EXIST),true)
PRODUCT_COPY_FILES += \
    device/fairphone_devices/FP2/apns-conf.xml:system/etc/apns-conf.xml
endif

$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := FP2
PRODUCT_DEVICE := FP2
PRODUCT_BRAND := Fairphone
PRODUCT_MANUFACTURER := Fairphone
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-fairphone

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/fairphone_devices/FP2/audio_policy.conf:system/etc/audio_policy.conf \
    device/fairphone_devices/FP2/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/fairphone_devices/FP2/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/fairphone_devices/FP2/mixer_paths_auxpcm.xml:system/etc/mixer_paths_auxpcm.xml


PRODUCT_PROPERTY_OVERRIDES += \
    ubuntu.wifi.supported=1

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcompostprocbundle

# Feature definition files for 8974
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml

#battery_monitor
PRODUCT_PACKAGES += \
    battery_monitor \
    battery_shutdown

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom

#wlan driver
PRODUCT_COPY_FILES += \
    device/fairphone_devices/FP2/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/fairphone_devices/FP2/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

PRODUCT_PACKAGES += wcnss_service

#ANT stack
PRODUCT_PACKAGES += \
        AntHalService \
        libantradio \
        ANTRadioService \
        antradio_app
TARGET_RELEASETOOLS_EXTENSIONS := device/fairphone_devices/FP2
ADD_RADIO_FILES := true

# Enable strict operation
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.strict_op_enable=false \
    persist.sys.usb.config=mtp

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.whitelist=/system/etc/whitelist_appops.xml

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1

PRODUCT_PACKAGES += \
    conn_init

PRODUCT_COPY_FILES += \
    device/fairphone_devices/FP2/whitelist_appops.xml:system/etc/whitelist_appops.xml


PRODUCT_BOOT_JARS += qcmediaplayer \
                     org.codeaurora.Performance \
                     vcard \
                     tcmiface
ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += WfdCommon
PRODUCT_BOOT_JARS += qcom.fmradio
PRODUCT_BOOT_JARS += security-bridge
PRODUCT_BOOT_JARS += qsb-port
PRODUCT_BOOT_JARS += oem-services
endif


PRODUCT_COPY_FILES += device/fairphone_devices/FP2/twrp.fstab:recovery/root/etc/twrp.fstab

PRODUCT_MODEL := FP2

# Ubuntu Overlay Files
PRODUCT_COPY_FILES += \
    device/fairphone_devices/FP2/ubuntu/adbd.conf:system/ubuntu/etc/init/adbd.conf \
    device/fairphone_devices/FP2/ubuntu/bluetooth-touch-FP2.conf:system/ubuntu/etc/init/bluetooth-touch-FP2.conf \
    device/fairphone_devices/FP2/ubuntu/FP2.conf:system/ubuntu/etc/ubuntu-touch-session.d/FP2.conf \
    device/fairphone_devices/FP2/ubuntu/set-brightness-fp2.conf:system/ubuntu/etc/set-brightness-fp2.conf \
    device/fairphone_devices/FP2/ubuntu/ubuntu-location-service.conf:system/ubuntu/etc/ubuntu-location-service.conf \
    device/fairphone_devices/FP2/ubuntu/70-FP2.rules:system/ubuntu/usr/lib/lxc-android-config/70-FP2.rules

# include an expanded selection of fonts for the SDK.
EXTENDED_FONT_FOOTPRINT := true


DEVICE_PACKAGE_OVERLAYS += device/fairphone_devices/FP2/overlay

# SuperUser
FP2_USE_APPOPS_SU := true
PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

# we don't have the calibration data so don't generate persist.img
FP2_SKIP_PERSIST_IMG := true
