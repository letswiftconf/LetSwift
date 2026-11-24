#!/bin/bash
# TEMP (Dynamic Type lab): builds the app into private simulators and screenshots every
# screen at several text sizes, before and after the Dynamic Type changes.
# Removed before merging.
#
#   run.sh doctor                 Xcode, simulator runtimes, free disk space
#   run.sh sims                   create the lab simulators (LetSwift-DTLab-*)
#   run.sh build <before|after>   build the iOS and watch apps (before = develop + this harness)
#   run.sh shots <before|after> [device...]
#                                 install that build and capture its screenshots
#   run.sh probe <js file> [iphone|ipad] [url]
#                                 run a script in the Home web view of the installed build
#   run.sh sheets                 before/after contact sheets (out/sheets)
#   run.sh cleanup                delete the lab simulators, worktree and build output
set -uo pipefail

LAB="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(dirname "$LAB")"
OUT="$LAB/out"
BASE="1f454b0" # 2026/develop_10 when the lab was written
PREFIX="LetSwift-DTLab"
IOS_BUNDLE="kr.codesquad.jk.letswift"
WATCH_BUNDLE="kr.codesquad.jk.letswift.watchkitapp"
SITE="${DT_LAB_SITE:-https://letswift.kr}"
MIN_FREE_GB=8

IOS_SIZES="large extra-extra-extra-large accessibility-large accessibility-extra-extra-extra-large"
IPAD_SIZES="large extra-extra-extra-large accessibility-extra-extra-extra-large"
SMALL_SIZES="extra-extra-extra-large accessibility-extra-extra-extra-large"
# Extra large is the text size that 44 mm and larger watches start with.
WATCH_SIZES="large extra-large extra-extra-extra-large accessibility-medium accessibility-extra-large"

die() { echo "error: $*" >&2; exit 1; }

free_gb() { df -g "$LAB" | awk 'NR==2 { print $4 }'; }

check_disk() {
    local free; free="$(free_gb)"
    [ "$free" -ge "$MIN_FREE_GB" ] || die "only ${free}GB free; the lab needs ${MIN_FREE_GB}GB"
}

# simctl size name -> index in DynamicTypeSize.allCases
size_index() {
    case "$1" in
        extra-small) echo 0 ;; small) echo 1 ;; medium) echo 2 ;; large) echo 3 ;;
        extra-large) echo 4 ;; extra-extra-large) echo 5 ;; extra-extra-extra-large) echo 6 ;;
        accessibility-medium) echo 7 ;; accessibility-large) echo 8 ;; accessibility-extra-large) echo 9 ;;
        accessibility-extra-extra-large) echo 10 ;; accessibility-extra-extra-extra-large) echo 11 ;;
    esac
}

# simctl size name -> short label
size_label() {
    case "$1" in
        large) echo "L" ;; extra-large) echo "xL" ;; extra-extra-extra-large) echo "xxxL" ;;
        accessibility-medium) echo "AX1" ;; accessibility-large) echo "AX2" ;;
        accessibility-extra-large) echo "AX3" ;; accessibility-extra-extra-extra-large) echo "AX5" ;;
        *) echo "$1" ;;
    esac
}

# MARK: - Simulators

udid_of() {
    xcrun simctl list devices -j | /usr/bin/python3 -c '
import json, sys
for devices in json.load(sys.stdin)["devices"].values():
    for device in devices:
        if device["name"] == sys.argv[1] and device.get("isAvailable", True):
            print(device["udid"])
            sys.exit(0)
' "$1"
}

# pick_type <iOS|watchOS> <device type name or part of one>...  ->  "<device type id> <runtime id>"
pick_type() {
    xcrun simctl list -j runtimes | /usr/bin/python3 -c '
import json, sys
platform, wanted = sys.argv[1], sys.argv[2:]
runtimes = [r for r in json.load(sys.stdin)["runtimes"]
            if r.get("isAvailable") and r.get("platform", r["name"].split()[0]) == platform]
if not runtimes:
    sys.exit(1)
runtime = max(runtimes, key=lambda r: [int(p) for p in r["version"].split(".")])
types = runtime.get("supportedDeviceTypes", [])
for match in (lambda name, want: name == want, lambda name, want: want in name):
    for want in wanted:
        for device_type in types:
            if match(device_type["name"], want):
                print(device_type["identifier"], runtime["identifier"])
                sys.exit(0)
sys.exit(2)
' "$@"
}

# make_sim <name> <iOS|watchOS> <device type preference>...
make_sim() {
    local name="$PREFIX-$1"; shift
    if [ -n "$(udid_of "$name")" ]; then echo "$name: exists"; return 0; fi
    local picked; picked="$(pick_type "$@")" || { echo "$name: no matching device type or runtime ($*)"; return 0; }
    # shellcheck disable=SC2086
    xcrun simctl create "$name" $picked >/dev/null || die "could not create $name"
    echo "$name: created ($picked)"
}

cmd_sims() {
    make_sim iPhone iOS "iPhone 17" "iPhone 17 Pro" "iPhone 16" "iPhone 16 Pro" "iPhone"
    make_sim iPhoneSmall iOS "iPhone SE (3rd generation)" "iPhone 16e" "iPhone 13 mini"
    make_sim iPad iOS "iPad Pro 11-inch (M5)" "iPad Pro 11-inch (M4)" "iPad Air 11-inch (M3)" "iPad (A16)" "iPad Pro 11" "iPad"
    make_sim WatchSmall watchOS "(40mm)" "(41mm)" "(42mm)"
    make_sim WatchLarge watchOS "(49mm)" "(46mm)" "(45mm)"
    xcrun simctl list devices | grep "$PREFIX"
}

boot() {
    local udid="$1"
    xcrun simctl bootstatus "$udid" -b >/dev/null 2>&1 || die "could not boot $udid"
}

# MARK: - Build

tree_of() {
    case "$1" in
        after) echo "$ROOT" ;;
        before) echo "$LAB/.before" ;;
        *) die "label must be before or after" ;;
    esac
}

# The develop branch as it was, plus the lab harness.
prepare_before_tree() {
    local tree="$LAB/.before"
    if [ ! -d "$tree" ]; then
        git -C "$ROOT" worktree add --detach "$tree" "$BASE" >/dev/null || die "could not create the before worktree"
    fi
    git -C "$tree" checkout -q --detach "$BASE" && git -C "$tree" checkout -q -- . || die "could not reset the before worktree"
    cp "$ROOT/LetSwift/Models/Previous/DynamicTypeLab.swift" "$tree/LetSwift/Models/Previous/"
    cp "$ROOT/LetSwift-watchOS/DynamicTypeLab.swift" "$tree/LetSwift-watchOS/"
    cp "$ROOT/LetSwift/LetSwiftApp.swift" "$tree/LetSwift/"
    cp "$ROOT/LetSwift-watchOS/Application/LetSwift_watchOSApp.swift" "$tree/LetSwift-watchOS/Application/"
    cp "$LAB/before/WebsiteView.swift" "$tree/LetSwift/Views/Website/"
}

# build_scheme <label> <scheme> <destination>
build_scheme() {
    local label="$1" scheme="$2" destination="$3"
    local log="$LAB/build-$label-${scheme// /_}.log"
    echo "building $scheme ($label) -> $log"
    xcodebuild -project "$(tree_of "$label")/LetSwift.xcodeproj" -scheme "$scheme" -configuration Debug \
        -destination "$destination" -derivedDataPath "$LAB/.dd-$label" \
        -clonedSourcePackagesDirPath "$LAB/.dd-packages" \
        -skipPackagePluginValidation -skipMacroValidation COMPILER_INDEX_STORE_ENABLE=NO build >"$log" 2>&1
    local status=$?
    grep -E "error:|warning: .*(DynamicType|Website|Video|ListItem|AppIcon|Session|Timetable|EventView|MoreView)|BUILD (SUCCEEDED|FAILED)" "$log" | sort -u | tail -40
    return $status
}

cmd_build() {
    local label="${1:-}"
    tree_of "$label" >/dev/null
    check_disk
    [ "$label" = before ] && prepare_before_tree
    local phone watch
    phone="$(udid_of "$PREFIX-iPhone")"; [ -n "$phone" ] || die "run '$0 sims' first"
    build_scheme "$label" LetSwift "platform=iOS Simulator,id=$phone" || die "iOS build failed"
    watch="$(udid_of "$PREFIX-WatchLarge")"
    if [ -n "$watch" ]; then
        build_scheme "$label" LetSwift-watchOS "platform=watchOS Simulator,id=$watch" || die "watch build failed"
    else
        echo "no watch simulator: skipping the watch build"
    fi
}

app_path() { # <label> <iphonesimulator|watchsimulator>
    find "$LAB/.dd-$1/Build/Products/Debug-$2" -maxdepth 1 -name "*.app" 2>/dev/null | head -1
}

# MARK: - Screenshots

LANGUAGE="ko"

# launch <udid> <bundle id> NAME=value...   (each pair becomes an environment variable of the app)
launch() {
    local udid="$1" bundle="$2"; shift 2
    local vars=("SIMCTL_CHILD_DT_LAB=1") pair
    for pair in "$@"; do vars+=("SIMCTL_CHILD_$pair"); done
    env "${vars[@]}" xcrun simctl launch --terminate-running-process "$udid" "$bundle" \
        -AppleLanguages "($LANGUAGE)" >/dev/null || echo "  launch failed: $*"
}

snap() { # <udid> <png>
    xcrun simctl io "$1" screenshot --type=png "$2" >/dev/null 2>&1 || echo "  screenshot failed: $2"
}

# native <udid> <dir> <name> <size> <screen> [scroll]
native() {
    local udid="$1" dir="$2" name="$3" size="$4" screen="$5" scroll="${6:-0}"
    launch "$udid" "$IOS_BUNDLE" "DT_LAB_SCREEN=$screen" "DT_LAB_SCROLL=$scroll"
    if [ "$scroll" = 0 ]; then sleep 4; else sleep 6; fi
    snap "$udid" "$dir/$name@$size.png"
}

# What the page looks like to WebKit, as JSON: whether the text size script runs, the size of body text,
# the page's width and how wide its content is (wider means it scrolls sideways), and how many boxes limit their text.
FACTS="const root = document.documentElement;
return JSON.stringify({
    script: !!window.__letswiftTextSize,
    body: getComputedStyle(document.body).fontSize,
    width: root.clientWidth,
    content: root.scrollWidth,
    limited: document.querySelectorAll('[data-letswift-app-text-limited]').length,
    sheets: document.adoptedStyleSheets.length
});"

# web <udid> <dir> <name> <size> <url> <script>   (the script scrolls; the facts are added to <dir>/web-facts.txt)
web() {
    local udid="$1" dir="$2" name="$3" size="$4" url="$5" script="$6"
    local result; result="$(xcrun simctl get_app_container "$udid" "$IOS_BUNDLE" data)/Documents/dtlab-web.txt"
    rm -f "$result"
    launch "$udid" "$IOS_BUNDLE" "DT_LAB_SCREEN=home" "DT_LAB_WEB_URL=$url" "DT_LAB_WEB_JS=$script
$FACTS"
    local waited=0
    while [ ! -f "$result" ] && [ "$waited" -lt 60 ]; do sleep 1; waited=$((waited + 1)); done
    local facts=""; [ -f "$result" ] && facts="$(cat "$result")"
    case "$facts" in
        "{"*) echo "$name@$size $facts" >> "$dir/web-facts.txt" ;;
        "") echo "  $name@$size: the page did not settle" ;;
        *) echo "  $name@$size: $facts" ;;
    esac
    sleep 2
    snap "$udid" "$dir/$name@$size.png"
}

scroll_to() { # <css selector>
    echo "const el = document.querySelector('$1'); if (!el) { return 'missing $1'; }
el.scrollIntoView({ block: 'start', behavior: 'instant' });
await new Promise(resolve => setTimeout(resolve, 800));"
}

SCROLL_TOP=""
SCROLL_END="window.scrollTo(0, document.documentElement.scrollHeight);
await new Promise(resolve => setTimeout(resolve, 800));"

# web_report <dir>   (prints the pages that scroll sideways, and where the text size script did not run)
web_report() {
    [ -f "$1/web-facts.txt" ] || return 0
    python3 - "$1/web-facts.txt" <<'PY'
import json, sys
problems = 0
for line in open(sys.argv[1]):
    name, _, facts = line.strip().partition(" ")
    facts = json.loads(facts)
    notes = []
    if facts["content"] > facts["width"]:
        notes.append("scrolls sideways (%s wide in %s)" % (facts["content"], facts["width"]))
    if not name.endswith("@large") and not facts["script"]:
        notes.append("text size script not running")
    if notes:
        problems += 1
        print("  %s: %s  %s" % (name, ", ".join(notes), json.dumps(facts)))
print("  web pages: %s" % ("%d with problems" % problems if problems else "no sideways scrolling"), "(facts: %s)" % sys.argv[1])
PY
}

# install <udid> <bundle id> <app>
install() {
    xcrun simctl uninstall "$1" "$2" >/dev/null 2>&1
    xcrun simctl install "$1" "$3" || die "could not install $3"
}

# ios_shots <label> <device> <sizes> <web: all|some|none>
ios_shots() {
    local label="$1" device="$2" sizes="$3" pages="$4"
    local udid; udid="$(udid_of "$PREFIX-$device")"
    [ -n "$udid" ] || { echo "$device: no simulator, skipped"; return 0; }
    local app; app="$(app_path "$label" iphonesimulator)"
    [ -n "$app" ] || die "no $label build; run '$0 build $label'"
    local dir="$OUT/$label/$device"
    rm -rf "$dir"; mkdir -p "$dir"
    echo "$device ($label)"
    boot "$udid"
    xcrun simctl status_bar "$udid" override --time "9:41" --batteryState charged --batteryLevel 100 --wifiBars 3 --cellularBars 4 >/dev/null 2>&1
    install "$udid" "$IOS_BUNDLE" "$app"
    local size
    for size in $sizes; do
        xcrun simctl ui "$udid" content_size "$size" || die "could not set the text size on $device"
        echo "  $size"
        LANGUAGE="ko"
        native "$udid" "$dir" videos "$size" videos
        native "$udid" "$dir" videos-mid "$size" videos 0.5
        native "$udid" "$dir" detail "$size" detail
        native "$udid" "$dir" detail-end "$size" detail 1
        native "$udid" "$dir" more "$size" more
        native "$udid" "$dir" more-end "$size" more 1
        native "$udid" "$dir" appicon "$size" appicon
        LANGUAGE="en"
        native "$udid" "$dir" en-videos "$size" videos
        native "$udid" "$dir" en-detail-end "$size" detail 1
        native "$udid" "$dir" en-more "$size" more
        native "$udid" "$dir" en-more-end "$size" more 1
        LANGUAGE="ko"
        # The web page ignores the text size before the change: one size is enough there.
        if [ "$pages" = none ] || { [ "$label" = before ] && [ "$size" != large ]; }; then continue; fi
        web "$udid" "$dir" web-home "$size" "$SITE" "$SCROLL_TOP"
        web "$udid" "$dir" web-program "$size" "$SITE/2026/" "$(scroll_to '#program')"
        web "$udid" "$dir" web-speakers "$size" "$SITE/2026/" "$(scroll_to '#speakers')"
        [ "$pages" = some ] && continue
        web "$udid" "$dir" web-about "$size" "$SITE/2026/" "$(scroll_to '#about')"
        web "$udid" "$dir" web-location "$size" "$SITE/2026/" "$(scroll_to '#location')"
        web "$udid" "$dir" web-history "$size" "$SITE/2026/" "$(scroll_to '#history')"
        web "$udid" "$dir" web-app "$size" "$SITE/2026/" "$(scroll_to '#app')"
        web "$udid" "$dir" web-opensource "$size" "$SITE/2026/" "$(scroll_to '#opensource')"
        web "$udid" "$dir" web-coc "$size" "$SITE/2026/" "$(scroll_to '#coc')"
        web "$udid" "$dir" web-end "$size" "$SITE/2026/" "$SCROLL_END"
        web "$udid" "$dir" web-conduct "$size" "$SITE/2026/CodeOfConduct/" "$SCROLL_TOP"
        web "$udid" "$dir" web-2025 "$size" "$SITE/2025/" "$SCROLL_TOP"
        web "$udid" "$dir" web-2025-mid "$size" "$SITE/2025/" "window.scrollTo(0, window.innerHeight * 2);
await new Promise(resolve => setTimeout(resolve, 800));"
    done
    web_report "$dir"
    xcrun simctl ui "$udid" content_size large
    xcrun simctl shutdown "$udid" >/dev/null 2>&1
}

# watch_shots <label> <device>
watch_shots() {
    local label="$1" device="$2"
    local udid; udid="$(udid_of "$PREFIX-$device")"
    [ -n "$udid" ] || { echo "$device: no simulator, skipped"; return 0; }
    local app; app="$(app_path "$label" watchsimulator)"
    [ -n "$app" ] || { echo "$device: no $label watch build, skipped"; return 0; }
    local dir="$OUT/$label/$device"
    rm -rf "$dir"; mkdir -p "$dir"
    echo "$device ($label)"
    boot "$udid"
    install "$udid" "$WATCH_BUNDLE" "$app"
    LANGUAGE="ko"
    local size screen
    for size in $WATCH_SIZES; do
        # The system setting where simctl supports it; the app-level override covers the rest.
        xcrun simctl ui "$udid" content_size "$size" >/dev/null 2>&1 || echo "  (simctl cannot set the text size on $device; using the override)"
        echo "  $size"
        for screen in event timetable session; do
            launch "$udid" "$WATCH_BUNDLE" "DT_LAB_SCREEN=$screen" "DT_LAB_TEXT_SIZE=$(size_index "$size")"
            sleep 4
            snap "$udid" "$dir/$screen@$size.png"
            launch "$udid" "$WATCH_BUNDLE" "DT_LAB_SCREEN=$screen" "DT_LAB_TEXT_SIZE=$(size_index "$size")" "DT_LAB_SCROLL=bottom"
            sleep 4
            snap "$udid" "$dir/$screen-end@$size.png"
        done
    done
    xcrun simctl ui "$udid" content_size large >/dev/null 2>&1
    xcrun simctl shutdown "$udid" >/dev/null 2>&1
}

cmd_shots() {
    local label="${1:-}"; shift
    tree_of "$label" >/dev/null
    local devices="${*:-iPhone iPhoneSmall iPad WatchSmall WatchLarge}" device
    for device in $devices; do
        case "$device" in
            iPhone) ios_shots "$label" iPhone "$IOS_SIZES" all ;;
            iPhoneSmall) ios_shots "$label" iPhoneSmall "$SMALL_SIZES" none ;;
            iPad) ios_shots "$label" iPad "$IPAD_SIZES" some ;;
            WatchSmall | WatchLarge) watch_shots "$label" "$device" ;;
            *) die "unknown device $device" ;;
        esac
    done
    echo "screenshots: $OUT/$label"
}

# MARK: - Web probe

cmd_probe() {
    local file="${1:-}" device="iPhone" url="${3:-$SITE/2026/}"
    [ -f "$file" ] || die "usage: $0 probe <js file> [iphone|ipad] [url]"
    [ "${2:-iphone}" = ipad ] && device="iPad"
    local udid; udid="$(udid_of "$PREFIX-$device")"
    [ -n "$udid" ] || die "run '$0 sims' first"
    boot "$udid"
    if ! xcrun simctl get_app_container "$udid" "$IOS_BUNDLE" data >/dev/null 2>&1; then
        local app; app="$(app_path after iphonesimulator)"
        [ -n "$app" ] || app="$(app_path before iphonesimulator)"
        [ -n "$app" ] || die "no build to install"
        install "$udid" "$IOS_BUNDLE" "$app"
    fi
    local result; result="$(xcrun simctl get_app_container "$udid" "$IOS_BUNDLE" data)/Documents/dtlab-web.txt"
    rm -f "$result"
    launch "$udid" "$IOS_BUNDLE" "DT_LAB_SCREEN=home" "DT_LAB_WEB_URL=$url" "DT_LAB_WEB_JS=$(cat "$file")"
    local waited=0
    while [ ! -f "$result" ] && [ "$waited" -lt 90 ]; do sleep 1; waited=$((waited + 1)); done
    [ -f "$result" ] || die "no result after 90 seconds"
    cat "$result"; echo
}

# MARK: - Contact sheets

cmd_sheets() {
    mkdir -p "$LAB/.bin" "$OUT/sheets"
    if [ ! -x "$LAB/.bin/sheet" ] || [ "$LAB/sheet.swift" -nt "$LAB/.bin/sheet" ]; then
        xcrun swiftc -O -o "$LAB/.bin/sheet" "$LAB/sheet.swift" || die "could not build the sheet tool"
    fi
    local device name size args width columns
    for device in iPhone iPhoneSmall iPad WatchSmall WatchLarge; do
        [ -d "$OUT/before/$device" ] || [ -d "$OUT/after/$device" ] || continue
        case "$device" in
            iPhone) sizes="$IOS_SIZES"; width=340 ;;
            iPhoneSmall) sizes="$SMALL_SIZES"; width=340 ;;
            iPad) sizes="$IPAD_SIZES"; width=460 ;;
            *) sizes="$WATCH_SIZES"; width=300 ;;
        esac
        # Every screen name captured on this device, for either label.
        for name in $(ls "$OUT"/*/"$device" 2>/dev/null | sed -n 's/@.*\.png$//p' | sort -u); do
            args=()
            columns=0
            case "$name" in
                web-*)
                    # One "before" (the page ignored the text size), then "after" at each size.
                    args+=("before" "$OUT/before/$device/$name@large.png"); columns=1
                    if [ -d "$OUT/after/$device" ]; then
                        for size in $sizes; do
                            args+=("after $(size_label "$size")" "$OUT/after/$device/$name@$size.png"); columns=$((columns + 1))
                        done
                    fi
                    ;;
                *)
                    for label in before after; do
                        [ -d "$OUT/$label/$device" ] || continue
                        columns=0
                        for size in $sizes; do
                            args+=("$label $(size_label "$size")" "$OUT/$label/$device/$name@$size.png"); columns=$((columns + 1))
                        done
                    done
                    ;;
            esac
            "$LAB/.bin/sheet" "$OUT/sheets/$device-$name.jpg" "$width" "$columns" "${args[@]}"
        done
    done
    ls "$OUT/sheets" | wc -l | awk '{ print $1 " sheets in '"$OUT/sheets"'" }'
}

# MARK: - Housekeeping

cmd_doctor() {
    xcodebuild -version
    xcrun simctl list runtimes | grep -v "^==" || true
    echo "free disk: $(free_gb)GB"
    xcrun simctl list devices | grep "$PREFIX" || echo "no lab simulators yet"
}

cmd_cleanup() {
    local name udid
    for name in iPhone iPhoneSmall iPad WatchSmall WatchLarge; do
        udid="$(udid_of "$PREFIX-$name")"
        [ -n "$udid" ] || continue
        xcrun simctl shutdown "$udid" >/dev/null 2>&1
        xcrun simctl delete "$udid" && echo "deleted $PREFIX-$name"
    done
    [ -d "$LAB/.before" ] && git -C "$ROOT" worktree remove --force "$LAB/.before"
    rm -rf "$LAB"/.dd-* "$LAB/.bin" "$LAB"/build-*.log
    echo "kept the screenshots in $OUT"
}

command="${1:-}"
[ $# -gt 0 ] && shift
case "$command" in
    doctor) cmd_doctor ;;
    sims) cmd_sims ;;
    build) cmd_build "$@" ;;
    shots) cmd_shots "$@" ;;
    probe) cmd_probe "$@" ;;
    sheets) cmd_sheets ;;
    cleanup) cmd_cleanup ;;
    *) sed -n '2,15p' "$0"; exit 64 ;;
esac
