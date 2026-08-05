#!/bin/bash
# =====================================================================
# 从 zbar 源码编译 iOS 模拟器切片（arm64 + x86_64）的 libzbar.a
#
# 背景：
#   原版 ZBarSDK 自带的 libzbar.a 的 arm64/x86_64 切片是按"真机"目标编译的
#   （对象仅有 LC_VERSION_MIN_IPHONEOS，无 LC_BUILD_VERSION 平台标记）。
#   新版链接器（ld_prime / ld64）拒绝把这类对象链入模拟器目标，报：
#     "building for iOS Simulator, but linking in object file built for iOS"
#   因此按 SDK 条件切换：设备用 ZBarSDK/libzbar.a，模拟器用本脚本产出的
#   ZBarSimSDK/libzbar.a。
#
# 注意：
#   * 应用实际仅用到照片解码子集（ZBarReaderController / ZBarSymbol），
#     故排除了纯设备类 ZBarCaptureReader、ZBarReaderViewController、
#     ZBarReaderViewImpl_Capture，以及引用其具体实现类的 ZBarReaderView。
#   * 需要先取得 zbar 源码（例如 git clone --depth 1 https://github.com/zbar/zbar.git），
#     并通过 SRC 指定源码路径。
# 用法：  SRC=/path/to/zbar-src ./build_sim.sh
# =====================================================================
set -u

SRC=${SRC:-/tmp/zbar-src}
OUT=${OUT:-/tmp/zbar_out}
SDK=$(xcrun --sdk iphonesimulator --show-sdk-path)
echo "SRC=$SRC  OUT=$OUT"
test -f "$SRC/iphone/include/prefix.pch" || { echo "ERROR: zbar source not found at $SRC"; exit 1; }

# 模拟器目标下，ZBarCaptureReader / ZBarReaderViewController / ZBarReaderViewImpl_Capture
# 因 TARGET_IPHONE_SIMULATOR 排除了捕获相关 ivar 而无法编译（纯设备类），故排除。
# 应用实际仅用到照片解码子集（ZBarReaderController / ZBarSymbol）。
OBJC_SOURCES=(
  "$SRC/iphone/ZBarCVImage.m"
  "$SRC/iphone/ZBarCameraSimulator.m"
  "$SRC/iphone/ZBarHelpController.m"
  "$SRC/iphone/ZBarImage.m"
  "$SRC/iphone/ZBarImageScanner.m"
  "$SRC/iphone/ZBarReaderController.m"
  "$SRC/iphone/ZBarSymbol.m"
)

C_SOURCES=(
  "$SRC/zbar/qrcode/bch15_5.c"
  "$SRC/zbar/qrcode/binarize.c"
  "$SRC/zbar/decoder/codabar.c"
  "$SRC/zbar/decoder/code128.c"
  "$SRC/zbar/decoder/code39.c"
  "$SRC/zbar/decoder/code93.c"
  "$SRC/zbar/config.c"
  "$SRC/zbar/decoder/databar.c"
  "$SRC/zbar/decoder.c"
  "$SRC/zbar/decoder/ean.c"
  "$SRC/zbar/error.c"
  "$SRC/zbar/decoder/i25.c"
  "$SRC/zbar/image.c"
  "$SRC/zbar/img_scanner.c"
  "$SRC/zbar/qrcode/isaac.c"
  "$SRC/zbar/decoder/qr_finder.c"
  "$SRC/zbar/qrcode/qrdec.c"
  "$SRC/zbar/qrcode/qrdectxt.c"
  "$SRC/zbar/refcnt.c"
  "$SRC/zbar/qrcode/rs.c"
  "$SRC/zbar/scanner.c"
  "$SRC/zbar/symbol.c"
  "$SRC/zbar/qrcode/util.c"
)

INCS=(
  -I"$SRC/zbar"
  -I"$SRC/zbar/qrcode"
  -I"$SRC/zbar/decoder"
  -I"$SRC/iphone/include"
  -I"$SRC/include"
  -DHAVE_CONFIG_H
)

CFLAGS=(
  -O2
  -Wno-deprecated-declarations
  -Wno-shift-op-parentheses
  -Wno-unused-parameter
  -Wno-parentheses-equality
  -Wno-objc-method-access
)

build_arch() {
  local arch=$1
  local target=$2
  local objdir=$OUT/obj-$arch
  rm -rf "$objdir"; mkdir -p "$objdir"

  for src in "${OBJC_SOURCES[@]}"; do
    local obj="$objdir/$(basename "${src%.m}").o"
    xcrun clang -c -fno-objc-arc -include "$SRC/iphone/include/prefix.pch" -target "$target" -isysroot "$SDK" "${CFLAGS[@]}" "${INCS[@]}" \
      "$src" -o "$obj" || { echo "FAIL $arch: $src"; return 1; }
  done

  for src in "${C_SOURCES[@]}"; do
    local obj="$objdir/$(basename "${src%.c}").o"
    xcrun clang -c -target "$target" -isysroot "$SDK" "${CFLAGS[@]}" "${INCS[@]}" \
      "$src" -o "$obj" || { echo "FAIL $arch: $src"; return 1; }
  done

  # 归档为静态库（先删除旧归档，避免残留上一次的成员）
  rm -f "$OUT/libzbar-$arch.a"
  ar rcs "$OUT/libzbar-$arch.a" "$objdir"/*.o
  echo "OK   $arch -> $OUT/libzbar-$arch.a"
}

build_arch arm64sim arm64-apple-ios12.0-simulator || exit 1
build_arch x86sim   x86_64-apple-ios12.0-simulator || exit 1

# 合并模拟器切片
lipo -create "$OUT/libzbar-arm64sim.a" "$OUT/libzbar-x86sim.a" -output "$OUT/libzbar-sim.a"
echo "--- libzbar-sim.a ---"
lipo -info "$OUT/libzbar-sim.a"
