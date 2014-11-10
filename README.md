android-dev
===========

Developer tools for android includes x86_64 SDK/ADT/Android Studio/Android X86

This repository consists only of make files.

To build SDK/ADT/Studio/android-x86 ISO
make -j<Number of CPU cores>

To install SDK/ADT/Studio
make install

To build SDK
make -j<Number of CPU cores> sdk

To build ADT/Studio
make -j<Number of CPU cores> android-studio

To build x86 lollipop (android-x86/out/target/product/x86/android_x86.iso)
make -j<Number of CPU cores> android-x86

To remove build directories
make clean

To remove build directories and update / checkout repositories on next build
make distclean
