LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

commonSources := \
	diskconfig.c \
	diskutils.c \
	write_lst.c \
	config_mbr.c

include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(commonSources)
LOCAL_MODULE := libdiskconfig
LOCAL_MODULE_TAGS := optional
LOCAL_SYSTEM_SHARED_LIBRARIES := libcutils liblog libc
LOCAL_CFLAGS := -Werror
# aliasing rule violation in config_mbr.c, not critical
LOCAL_CFLAGS += -fno-strict-aliasing
include $(BUILD_SHARED_LIBRARY)

ifeq ($(HOST_OS),linux)
include $(CLEAR_VARS)
LOCAL_SRC_FILES := $(commonSources)
LOCAL_MODULE := libdiskconfig_host
LOCAL_MODULE_TAGS := optional
LOCAL_CFLAGS := -g -W -Wall -Werror -D_LARGEFILE64_SOURCE
# aliasing rule violation in config_mbr.c, not critical
LOCAL_CFLAGS += -fno-strict-aliasing
include $(BUILD_HOST_STATIC_LIBRARY)
endif # HOST_OS == linux
