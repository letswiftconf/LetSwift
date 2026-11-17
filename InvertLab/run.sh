#!/bin/bash
# TEMPORARY helper for the Smart Invert simulator checks. Lives only on the thread branch; not for merge.
#
#   InvertLab/run.sh sim                # create + boot the private "LetSwift-InvertLab" simulator, print its UDID
#   InvertLab/run.sh build              # build the Debug app for that simulator into InvertLab/.dd
#   InvertLab/run.sh invert on|off      # toggle Smart Invert on that simulator
#   InvertLab/run.sh shots [modes...]   # install, capture every mode x appearance x invert, build side-by-side sheets
#   InvertLab/run.sh cleanup            # delete the private simulator
#
# Environment: LAB_DEVICE_TYPE, LAB_RUNTIME (simulator choice), LAB_WAIT, LAB_WEB_WAIT (seconds before a screenshot),
# LAB_SETTLE (seconds after switching appearance or invert), LAB_APPEARANCES ("light", "dark" or "light dark").
set -uo pipefail
cd "$(dirname "$0")/.."
ROOT="$PWD"
LAB="$ROOT/InvertLab"
DD="$LAB/.dd"
OUT="$LAB/out"
SIM_NAME="LetSwift-InvertLab"
BUNDLE="kr.codesquad.jk.letswift"
ALL_MODES=(lab lab2 lab3 lab4 home web-ignore videos detail more appicon)

udid() {
  xcrun simctl list devices | grep -F "$SIM_NAME (" | head -1 | sed -E 's/^[^(]*\(([0-9A-Fa-f-]{36})\).*$/\1/'
}

need_udid() {
  UDID="$(udid)"
  [ -n "$UDID" ] || { echo "No $SIM_NAME simulator. Run: $0 sim" >&2; exit 1; }
}

cmd_sim() {
  UDID="$(udid)"
  if [ -z "$UDID" ]; then
    local devtype runtime
    devtype="${LAB_DEVICE_TYPE:-$(xcrun simctl list devicetypes | grep -E '^iPhone [0-9]+ Pro \(' | sort -t' ' -k2,2n | tail -1 | sed -E 's/^.*\((com\.apple[^)]*)\).*$/\1/')}"
    runtime="${LAB_RUNTIME:-$(xcrun simctl list runtimes | grep -E '^iOS ' | grep -v -i unavailable | tail -1 | sed -E 's/^.* (com\.apple\.CoreSimulator\.SimRuntime\.[^ ]*).*$/\1/')}"
    echo "Creating $SIM_NAME: $devtype on $runtime" >&2
    UDID="$(xcrun simctl create "$SIM_NAME" "$devtype" "$runtime")" || exit 1
  fi
  xcrun simctl boot "$UDID" 2>/dev/null
  xcrun simctl bootstatus "$UDID" >/dev/null 2>&1
  echo "$UDID"
}

cmd_build() {
  need_udid
  xcodebuild -project "$ROOT/LetSwift.xcodeproj" -scheme LetSwift -configuration Debug \
    -destination "platform=iOS Simulator,id=$UDID" -derivedDataPath "$DD" \
    build 2>&1 | grep -E 'error:|BUILD (SUCCEEDED|FAILED)' | tail -60
}

# Smart Invert through the simulator's accessibility defaults. This is a guess: confirm on a screenshot
# (the lab header prints env.invert, and swatches S1 must look inverted) and fix it here if it does nothing.
set_invert() { # on|off
  local value=NO
  [ "$1" = on ] && value=YES
  xcrun simctl spawn "$UDID" defaults write com.apple.Accessibility InvertColorsEnabled -bool "$value"
  xcrun simctl spawn "$UDID" notifyutil -p com.apple.accessibility.cache.invert.colors >/dev/null 2>&1 || true
}

cmd_invert() {
  need_udid
  set_invert "${1:-off}"
}

cmd_shots() {
  need_udid
  local app="$DD/Build/Products/Debug-iphonesimulator/LetSwift.app"
  [ -d "$app" ] || { echo "No build at $app. Run: $0 build" >&2; exit 1; }
  xcrun simctl install "$UDID" "$app" || exit 1
  local modes=("$@")
  [ ${#modes[@]} -gt 0 ] || modes=("${ALL_MODES[@]}")
  mkdir -p "$OUT/raw" "$OUT/sheets"

  local appearance invert mode shot failed=0
  local appearances=(${LAB_APPEARANCES:-light dark})
  for appearance in "${appearances[@]}"; do
    xcrun simctl terminate "$UDID" "$BUNDLE" >/dev/null 2>&1
    xcrun simctl ui "$UDID" appearance "$appearance"
    for invert in off on; do
      xcrun simctl terminate "$UDID" "$BUNDLE" >/dev/null 2>&1
      set_invert "$invert"
      sleep "${LAB_SETTLE:-4}"
      for mode in "${modes[@]}"; do
        xcrun simctl terminate "$UDID" "$BUNDLE" >/dev/null 2>&1
        SIMCTL_CHILD_INVERT_LAB="$mode" xcrun simctl launch "$UDID" "$BUNDLE" >/dev/null
        case "$mode" in
          home|web-ignore) sleep "${LAB_WEB_WAIT:-12}" ;;
          *) sleep "${LAB_WAIT:-6}" ;;
        esac
        shot="$OUT/raw/${mode}__${appearance}__invert-${invert}.png"
        rm -f "$shot"
        xcrun simctl io "$UDID" screenshot "$shot" >/dev/null 2>&1
        if [ -s "$shot" ]; then
          echo "captured ${mode} ${appearance} invert-${invert}"
        else
          echo "FAILED ${mode} ${appearance} invert-${invert} (free: $(df -h "$OUT" | awk 'NR==2 {print $4}'))" >&2
          failed=$((failed + 1))
        fi
      done
    done
  done
  xcrun simctl terminate "$UDID" "$BUNDLE" >/dev/null 2>&1
  set_invert off
  xcrun simctl ui "$UDID" appearance light

  # Side-by-side sheets: left = Smart Invert off, right = on.
  [ -x "$LAB/.montage" ] || swiftc -O "$LAB/montage.swift" -o "$LAB/.montage" || exit 1
  for mode in "${modes[@]}"; do
    for appearance in "${appearances[@]}"; do
      "$LAB/.montage" "$OUT/sheets/${mode}__${appearance}.jpg" 700 \
        "$OUT/raw/${mode}__${appearance}__invert-off.png" \
        "$OUT/raw/${mode}__${appearance}__invert-on.png"
    done
  done
  ls -l "$OUT/sheets"
  [ "$failed" -eq 0 ] || { echo "$failed screenshots failed" >&2; return 1; }
}

cmd_cleanup() {
  UDID="$(udid)"
  [ -n "$UDID" ] && xcrun simctl shutdown "$UDID" 2>/dev/null
  [ -n "$UDID" ] && xcrun simctl delete "$UDID"
  echo "deleted ${UDID:-nothing}"
}

case "${1:-}" in
  sim) cmd_sim ;;
  build) cmd_build ;;
  invert) shift; cmd_invert "$@" ;;
  shots) shift; cmd_shots "$@" ;;
  cleanup) cmd_cleanup ;;
  *) sed -n '2,10p' "$0"; exit 2 ;;
esac
