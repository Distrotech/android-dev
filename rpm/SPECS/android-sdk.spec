Name: android-sdk
Epoch: 0
Version: 21
Release: 1
Summary: Android SDK
Group: Distrotech Linux Android SDK
License: Refer to sourcecode
URL: https://android.googlesource.com/
AutoReqProv: 1
Provides: libdl.so libjnigraphics.so liblog.so libstdc++.so

%define _topdir rpm
%define buildroot rpm/BUILDROOT

%define _arch x86_64
%global __strip /bin/true

%description
Android Core SDK Files

%install
find %{buildroot} -empty -type d -delete

%package docs
Group: Distrotech Linux Android SDK Documentation
Summary: Android SDK Documentation

%description docs
Android SDK Documentation

%package image
Group: Distrotech Linux Android SDK System Images
Summary: Android SDK System Images

%description image
Android SDK System Images

%package adt
Group: Distrotech Linux Android SDK ADT (Android Development Tools)
Summary: Android SDK ADT (Android Development Tools)
Provides: libGL.so.1 libX11.so.6 libXrender.so.1 libfontconfig.so.1 libfreetype.so.6

%description adt
Android SDK ADT (Android Development Tools)

%package studio
Group: Distrotech Linux Android Studio
Summary: Android Studio Development IDE

%description studio
Android Studio Development IDE

%package x86_iso
Group: Distrotech Linux Android x86 ISO
Summary: Android x86 ISO

%description x86_iso
Android x86 ISO

%files
/opt/android/add-ons
/opt/android/build-tools
/opt/android/documentation.html
/opt/android/extras
/opt/android/platforms
/opt/android/platform-tools
/opt/android/RELEASE_NOTES.html
/opt/android/samples
/opt/android/tests

%files docs
/opt/android/docs

%files image
/opt/android/system-images

%files adt
/opt/android/tools/

%files studio
/opt/android-studio/

%files x86_iso
/opt/android/android-x86/

