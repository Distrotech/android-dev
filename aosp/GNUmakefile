SDK_INSTALL_DIR = /opt/android

repo:
	@wget https://storage.googleapis.com/git-repo-downloads/repo && chmod 750 repo

repo_init: repo
	@./repo init -u https://android.googlesource.com/a/platform/manifest -b $(BRANCH)

repo_sync: repo_init
	@./repo sync -d && touch .repo.ok

sdk_x86_64-eng: buildspec-x86_64
	@$(MAKE) LUNCH_VERSION=$@ $(SDK_DIR).zip

.repo .repo.ok:
	@$(MAKE) BRANCH=${BRANCH} repo_sync

.ONESHELL:
buildspec-x86_64:
	@cat >buildspec.mk <<__EOF__
	TARGET_IS_64_BIT := true
	TARGET_SUPPORTS_64_BIT_APPS := true
	TARGET_SUPPORTS_32_BIT_APPS := true
	__EOF__

.ONESHELL:
$(SDK_DIR).zip:
	@. build/envsetup.sh
	@lunch $(LUNCH_VERSION)
	@$(MAKE) -f Makefile sdk

.ONESHELL:
clean:
	@. build/envsetup.sh
	@lunch $(LUNCH_VERSION)
	@$(MAKE) -f Makefile clean installclean clobber
	@rm -f buildspec.mk repo
	@rm -rf out

distclean: clean
	@rm -f .repo.ok

install:
	install -d $(DESTDIR)$(SDK_INSTALL_DIR)
	cp -r $(SDK_DIR)/* $(DESTDIR)$(SDK_INSTALL_DIR)/

.NOTPARALLEL:
%.sdk: .repo .repo.ok
	@$(MAKE) SDK_DIR=$(SDK_DIR) $(basename $@)

.PHONY: sdk clean buildspec-x86_64 distclean repo_init repo_sync install
.FEATURES: jobserver oneshell
