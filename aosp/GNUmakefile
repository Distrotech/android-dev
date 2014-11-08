repo:
	@wget https://storage.googleapis.com/git-repo-downloads/repo && chmod 750 repo

repo_init: repo
	@./repo init -u https://android.googlesource.com/a/platform/manifest -b $(BRANCH)

repo_sync: repo_init
	@./repo sync -d && touch .repo.ok

sdk_x86_64-user: buildspec-x86_64
	@make LUNCH_VERSION=$@ sdk

.repo .repo.ok:
	@make BRANCH=${BRANCH} repo_sync

.ONESHELL:
buildspec-x86_64:
	@cat >buildspec.mk <<__EOF__
	TARGET_IS_64_BIT := true
	TARGET_SUPPORTS_64_BIT_APPS := true
	TARGET_SUPPORTS_32_BIT_APPS := true
	__EOF__

.ONESHELL:
sdk:
	@. build/envsetup.sh
	@lunch $(LUNCH_VERSION)
	@make -f Makefile $@

.ONESHELL:
clean:
	@. build/envsetup.sh
	@lunch $(LUNCH_VERSION)
	@make -f Makefile clean installclean clobber
	@rm -f buildspec.mk repo
	@rm -rf out

distclean: clean
	@rm -f .repo.ok

%.sdk: .repo .repo.ok
	@make $(basename $@)

.PHONY: sdk clean buildspec-x86_64 distclean repo_init repo_sync sdk_x86_64-user sdk_x86_64-user.sdk
