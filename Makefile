JVMDIR = /usr/lib64/jvm
JAVA6 = $(JVMDIR)/jdk-1.6.0_32
AOSP_BRANCH = android-5.0.0_r2
ANDROID_X86_BRANCH = lollipop-x86
STUDIO_BRANCH = studio-1.1-release
LUNCH_VERSION = sdk_x86_64-user

all: repo .repo.ok $(LUNCH_VERSION) android-studio android-x86

studio gradle tools android-studio studio-install:
	@make -C android-studio BRANCH=$(STUDIO_BRANCH) JAVA6=$(JAVA6) $@

sdk: $(LUNCH_VERSION).sdk

android-x86:
	@make -C android-x86 BRANCH=$(ANDROID_X86_BRANCH)

repo repo_sync clean distclean .repo.ok .repo:
	@make -C android-studio BRANCH=$(STUDIO_BRANCH) JAVA6=$(JAVA6) $@
	@make -C aosp BRANCH=$(AOSP_BRANCH) LUNCH_VERSION=$(LUNCH_VERSION) $@
	@make -C android-x86 BRANCH=$(ANDROID_X86_BRANCH) $@

%.sdk:
	@make -C aosp BRANCH=$(AOSP_BRANCH) MAKE_TARGET=sdk $@

.PHONY: studio gradle tools android-studio studio-install clean sdk repo_sync repo_init repo .repo .repo.ok $(LUNCH_VERSION) android-x86 $(LUNCH_VERSION).sdk
