INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_DEVICE_IP = 172.19.208.48
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 12.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AlertSpringBoard

AlertSpringBoard_FILES = Tweak.xm
AlertSpringBoard_CFLAGS = -fobjc-arc
AlertSpringBoard_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
include $(THEOS_MAKE_PATH)/aggregate.mk
