# webrtc-ios-build

This is build helper tool for [webrtc_ios](https://webrtc.org/native-code/ios/).

This script generate headers (.h) and many fat static libraries (.a).
Each libraries contain armv7 and arm64 for device, i386 and x86_64 for simulator.

# Usage

First, download webrtc_ios source code following [official instructions](https://webrtc.org/native-code/development/).

You have 2 options whether bitcode embedding is enable or not (in xcode, its repesents as `ENABLE_BITCODE` setting).

## Enabling bitcode

This tool enable embedding bitcode default.

Unfortunately chromium team may not support bitcode now,
I need little hack to gyp in webrtc source repository.

- [Disable ENABLE_BITCODE for iOS 9.](https://groups.google.com/a/chromium.org/forum/#!topic/chromium-reviews/MEca51xoey8)

I think my hack is not stable, but I want.
Because Apple recommend us to support bitcode.
So this mode is default.

## Disabling bitcode

To disable bitcode, append `--disable-bitcode` option to command described below.

This mode does not modify webrtc source repository. (Because this is their default)

--

Open this repository in terminal and run script.

```
$ ./webrtc-ios-build.rb --webrtc <webrtc_dir> [--disable-bitcode]
```

`webrtc_dir` is webrtc_ios root directory in which you run `fetch webrtc_ios` (not `src`).

`--disable-bitcode` indicates to disable bitcode embedding.

After long time build finish, 
you can get header files in `out/include` and 
a lot of static libraries such as `out/lib/lib*.a`.

# Example

`example/AppRTCDemo/AppRTCDemo.xcodeproj` is example xcode project I made to build googles example webrtc application source code with library this tool built.
Original source is `webrtc_ios/src/webrtc/examples/objc/AppRTCDemo` without xcode project.

# Other functions

You can clean outputs.

```
$ ./webrtc-ios-build.rb clean
```



