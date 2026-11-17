//
//  WebTextSize.js
//  LetSwift
//
//  Makes the text of a web page follow the system text size (Dynamic Type), which web pages don't do by themselves.
//
//  This file is one function expression. WebTextSize.swift appends the call, `(extra, hosts);`, and runs the result
//  in the page: at the start of every document, and again whenever the text size changes.
//  - extra: how many px larger than the page's own (smaller, when negative) body-size text gets. 0 undoes everything.
//  - hosts: the page is left alone unless its host is one of these, or a subdomain of one. null allows every page.
//
//  How it works:
//  - A style sheet of its own repeats every rule of the page that sets a font size, with the size replaced
//    (see `overrides`). Sizes relative to the parent element's are left alone: they follow their parent.
//  - Small text grows by the whole amount and large text by less, like the native text styles (see `growth`).
//  - Where larger text no longer fits a box that the page gave a fixed size, the text in that box grows only
//    as far as it fits (see `fit`).
//

(function (extra, hosts) {
    "use strict";

    // Only our own pages: other sites keep their layout.
    if (hosts && !hosts.some(function (host) {
        return location.hostname === host || location.hostname.endsWith("." + host);
    })) { return; }

    var KEY = "__letswiftTextSize";
    if (window[KEY]) { window[KEY].apply(extra); return; }
    if (!extra) { return; } // Default text size: the page stays as it is.

    // Text up to FULL px grows by the whole amount and text from NONE px up keeps its size,
    // so headlines and body text meet at the top like the native text styles do.
    var FULL = 22, NONE = 60;
    // Smaller text sizes never shrink text below FLOOR px.
    var FLOOR = 11;
    // Text in bars that stay on screen (sticky or fixed) grows by BAR px at most, like native bars keep their size.
    var BAR = 6;
    // How precisely text is fitted to a box that is too small for it (STEPS halvings), and how many levels of
    // such boxes inside one another are looked at (ROUNDS).
    var STEPS = 5, ROUNDS = 8;
    // An element marked with LIMITED takes only the part FIT (0...1) of the growth, counted from its own size BASE (see `fit`).
    var FIT = "--letswift-app-text-fit";
    var BASE = "--letswift-app-text-base";
    var LIMITED = "data-letswift-app-text-limited";

    var sheet = new CSSStyleSheet();
    var current = 0;         // px added to body-size text right now
    var styleState = "";     // the page's style sheets the overrides were built from
    var layoutState = "";    // the page content `fit` last ran for
    var limited = [];        // elements marked with LIMITED
    var inlineSizes = new WeakMap();
    var timer = 0, lastRun = 0, pending = false;

    // MARK: - Sizes

    /// A CSS length: how much text of the size `base` (a CSS length too) changes.
    function growth(base) {
        var slope = current / (NONE - FULL);
        var change = "(" + NONE + "px - (" + base + ")) * " + slope;
        return (current > 0
            ? "clamp(0px, " + change + ", " + current + "px)"
            : "clamp(" + current + "px, " + change + ", 0px)") + " * var(" + FIT + ", 1)";
    }

    function resized(base) {
        var size = "calc(" + base + " + " + growth(base) + ")";
        return current > 0 ? size : "max(" + size + ", min(" + base + ", " + FLOOR + "px))";
    }

    var KEYWORDS = {
        "xx-small": "9px", "x-small": "10px", "small": "13px", "medium": "16px",
        "large": "18px", "x-large": "24px", "xx-large": "32px", "xxx-large": "48px"
    };

    /// The font size to resize, or null for one to leave alone: a size relative to the parent's
    /// (which already follows its parent), a keyword like `inherit`, or zero (hidden text).
    function absoluteSize(value, relativeToRoot) {
        var size = value.trim(), lower = size.toLowerCase();
        if (KEYWORDS[lower]) { return KEYWORDS[lower]; }
        if (!size || /^[a-z-]+$/.test(lower) || /^[+-]?0*\.?0+[a-z%]*$/.test(lower)) { return null; }
        if (/(\d|\.)(em|ex|ch|cap|ic|lh|%)(?![a-z])/.test(lower) && !relativeToRoot) { return null; }
        return size;
    }

    function matches(element, selector) {
        try { return !!element && !!selector && element.matches(selector); } catch (error) { return false; }
    }

    function priority(style, property) {
        return style.getPropertyPriority(property) ? " !important;" : ";";
    }

    // MARK: - Style sheet overrides

    /// The declarations that replace the font size (and a fixed line height) among `style`, the declarations
    /// of a style rule. `selector` is the rule's selector, or null for a rule nested in another one.
    function declarations(style, selector) {
        var css = "", base = null;
        var size = style.getPropertyValue("font-size");
        // The root element keeps its size, so `rem` lengths stay what the page expects.
        if (size && !matches(document.documentElement, selector)) {
            base = absoluteSize(size, matches(document.body, selector));
            if (base) { css += "font-size:" + resized(base) + priority(style, "font-size"); }
        }
        var lineHeight = style.getPropertyValue("line-height").trim();
        if (current > 0 && /^[\d.]+(px|rem|pt|pc|in|cm|mm|q)$/i.test(lineHeight) && parseFloat(lineHeight) > 0) {
            // A fixed line height grows with its text (assumed to be two thirds of it when the rule doesn't say).
            css += "line-height:calc(" + lineHeight + " + " + growth(base || lineHeight + " / 1.5") + ")"
                + priority(style, "line-height");
        }
        return css;
    }

    /// Mirrors `rules`, keeping only the overrides: the same selectors inside the same @media, @layer, ... blocks,
    /// so each override wins over exactly the declaration it replaces. `selector` is the selector of the style rule
    /// around `rules`: undefined when there is none, null when that rule is nested itself.
    function overrides(rules, selector) {
        var css = "";
        for (var index = 0; index < rules.length; index++) {
            var rule = rules[index], kind = Object.prototype.toString.call(rule), inner;
            if (kind === "[object CSSStyleRule]") {
                // Only a rule that isn't nested says by itself which elements it matches.
                var own = selector === undefined ? rule.selectorText : null;
                inner = declarations(rule.style, own)
                    + (rule.cssRules && rule.cssRules.length ? overrides(rule.cssRules, own) : "");
                if (inner) { css += rule.selectorText + "{" + inner + "}"; }
            } else if (kind === "[object CSSNestedDeclarations]") {
                // Declarations that follow a nested rule belong to the rule around them.
                css += declarations(rule.style, selector);
            } else if (/^\[object CSS(Media|Supports|Container|LayerBlock|Scope)Rule\]$/.test(kind)) {
                inner = overrides(rule.cssRules, selector);
                if (inner) { css += rule.cssText.slice(0, rule.cssText.indexOf("{")) + "{" + inner + "}"; }
            } else if (kind === "[object CSSImportRule]") {
                try {
                    inner = inMedia(rule.media, overrides(rule.styleSheet.cssRules));
                    // `layerName` is null for an import without a layer, and "" for a layer without a name.
                    css += inner && typeof rule.layerName === "string" ? "@layer " + rule.layerName + "{" + inner + "}" : inner;
                } catch (error) { /* A style sheet that can't be read. */ }
            }
        }
        return css;
    }

    function inMedia(media, css) {
        var query = media && media.mediaText;
        return css && query && query !== "all" ? "@media " + query + "{" + css + "}" : css;
    }

    function pageSheets() {
        return Array.prototype.slice.call(document.styleSheets)
            .concat(Array.prototype.slice.call(document.adoptedStyleSheets))
            .filter(function (other) { return other !== sheet; });
    }

    function readStyleState() {
        return pageSheets().map(function (other) {
            var count = -1;
            try { count = other.cssRules.length; } catch (error) { /* another site's style sheet */ }
            return (other.href || "") + ":" + count + ":" + other.disabled;
        }).join("|") + (document.body ? "" : "|no body");
    }

    function rebuild() {
        styleState = readStyleState();
        var css = "";
        if (current) {
            // Text that takes the browser's default size inherits it from the body.
            css = "body{font-size:" + resized("1rem") + "}";
            if (current > 0) {
                css += "[" + LIMITED + "]{font-size:" + resized("var(" + BASE + ")") + " !important}";
            }
            pageSheets().forEach(function (other) {
                if (other.disabled) { return; }
                try { css += inMedia(other.media, overrides(other.cssRules)); } catch (error) { /* another site's style sheet */ }
            });
        }
        sheet.replaceSync(css);
        // Adopted style sheets come after all of the page's own, so equal selectors resolve in our favor.
        if (Array.prototype.indexOf.call(document.adoptedStyleSheets, sheet) < 0) {
            document.adoptedStyleSheets = Array.prototype.slice.call(document.adoptedStyleSheets).concat([sheet]);
        }
    }

    // MARK: - Inline sizes

    /// Font sizes set in `style` attributes, which no style sheet rule can override.
    function resizeInline() {
        var elements = document.querySelectorAll("[style*='font-size']");
        for (var index = 0; index < elements.length; index++) {
            var element = elements[index];
            if (element === document.documentElement || element.namespaceURI !== "http://www.w3.org/1999/xhtml") { continue; }
            var record = inlineSizes.get(element);
            var value = element.style.getPropertyValue("font-size");
            var ours = record && value === record.applied;
            if (ours && record.extra === current) { continue; }
            // A value that isn't ours is the page's own: either new, or changed since we replaced it.
            var original = ours ? record.original : value;
            var base = current ? absoluteSize(original, element === document.body) : null;
            element.style.setProperty("font-size", base ? resized(base) : original, element.style.getPropertyPriority("font-size"));
            inlineSizes.set(element, { original: original, applied: element.style.getPropertyValue("font-size"), extra: current });
        }
    }

    // MARK: - Fit

    /// How far content spills out of a box: [across, down].
    function spill(element) {
        // Boxes with no size (inline or collapsed) hold nothing in, and the page itself scrolls down.
        var scrollsDown = element === document.documentElement || element === document.body;
        return [
            element.clientWidth > 0 ? element.scrollWidth - element.clientWidth : 0,
            element.clientHeight > 0 && !scrollsDown ? element.scrollHeight - element.clientHeight : 0
        ];
    }

    /// Where larger text no longer fits a box it used to fit (a button of fixed height, a table cell of
    /// fixed width, a line that can't wrap), the text inside takes only as much of the growth as does fit.
    function fit() {
        limited.forEach(function (element) {
            element.removeAttribute(LIMITED);
            element.style.removeProperty(FIT);
            element.style.removeProperty(BASE);
        });
        limited = [];
        if (current <= 0 || !document.body) { return; }

        var root = document.documentElement;
        var elements = [root, document.body].concat(Array.prototype.slice.call(document.body.querySelectorAll("*")));

        // The page at its own sizes: what already spills, each font size, and the bars.
        root.style.setProperty(FIT, "0");
        var before = [], sizes = [], bars = [];
        elements.forEach(function (element, index) {
            var style = getComputedStyle(element);
            before.push(spill(element));
            sizes.push(style.fontSize);
            if (index > 1 && /sticky|fixed/.test(style.position)) { bars.push(index); }
        });
        root.style.removeProperty(FIT);

        var parts = []; // The part of the growth each limited element settled on, by itself.

        /// Limits the text in a box to `part` of the growth, including boxes inside it that were limited less.
        function limit(index, part) {
            var element = elements[index];
            if (limited.indexOf(element) < 0) {
                limited.push(element);
                if (element !== root) {
                    // The element's own font size now follows FIT too, also when it only inherited one.
                    element.style.setProperty(BASE, sizes[index]);
                    element.setAttribute(LIMITED, "");
                }
            }
            parts[limited.indexOf(element)] = part;
            limited.forEach(function (other, position) {
                if (other === element || element.contains(other)) {
                    other.style.setProperty(FIT, String(Math.min(parts[position], part)));
                }
            });
        }

        function spills(index) {
            var now = spill(elements[index]), was = before[index];
            if (was[0] <= 1 && now[0] > 1) { return true; }
            if (was[1] > 1 || now[1] <= 1) { return false; }
            // Tall glyphs poke out of tight lines a little more as they grow: that isn't a box too small.
            return now[1] > 1 + parseFloat(getComputedStyle(elements[index]).fontSize) / 10;
        }

        /// The part of the growth the text in a box takes right now.
        function part(index) {
            var value = parseFloat(getComputedStyle(elements[index]).getPropertyValue(FIT));
            return value <= 1 ? value : 1;
        }

        /// Text that fits its box only by running into the padding at its sides.
        function crowds(index) {
            var element = elements[index], style = getComputedStyle(element);
            var range = document.createRange();
            range.selectNodeContents(element);
            var content = range.getBoundingClientRect(), box = element.getBoundingClientRect();
            return content.width > 0 && (
                content.left < box.left + parseFloat(style.borderLeftWidth) + parseFloat(style.paddingLeft) - 1 ||
                content.right > box.right - parseFloat(style.borderRightWidth) - parseFloat(style.paddingRight) + 1
            );
        }

        if (current > BAR) {
            bars.forEach(function (index) { limit(index, BAR / current); });
        }

        var tight = [];
        for (var index = 0; index < elements.length; index++) {
            if (spills(index)) { tight.push(index); }
        }
        // Innermost boxes first, so a fix stays as local as possible. Boxes that don't hold one another are
        // searched together: every step changes all of them and then measures all of them, in one layout.
        for (var round = 0; round < ROUNDS && tight.length; round++) {
            // In document order a box comes right before the boxes inside it.
            var targets = tight.filter(function (target, position) {
                return position + 1 === tight.length || !elements[target].contains(elements[tight[position + 1]]);
            });
            var low = targets.map(function () { return 0; });
            var high = targets.map(part); // Never more than what a box around it allows.
            for (var step = 0; step < STEPS; step++) {
                targets.forEach(function (target, position) {
                    limit(target, (low[position] + high[position]) / 2);
                });
                targets.forEach(function (target, position) {
                    var middle = (low[position] + high[position]) / 2;
                    if (spills(target) || crowds(target)) { high[position] = middle; } else { low[position] = middle; }
                });
            }
            targets.forEach(function (target, position) {
                limit(target, low[position]);
                // What it settled on now also holds for the boxes inside it.
                limited.forEach(function (other, place) {
                    if (elements[target].contains(other)) { parts[place] = Math.min(parts[place], low[position]); }
                });
            });
            // What's left: boxes around the ones just searched, and boxes whose neighbors took the room they had found.
            tight = tight.filter(function (target) { return part(target) > 0 && spills(target); });
        }
    }

    // MARK: - Updates

    function update(force) {
        timer = 0;
        pending = false;
        lastRun = Date.now();
        if (readStyleState() !== styleState) {
            rebuild();
            force = true;
        }
        resizeInline();
        if (force || readLayoutState() !== layoutState) {
            fit();
            layoutState = readLayoutState();
        }
        observer.takeRecords(); // Our own changes don't count.
    }

    /// Changes when the page gets new content or a new size. (Cheap, unlike `fit`.)
    function readLayoutState() {
        var root = document.documentElement, body = document.body;
        return document.getElementsByTagName("*").length + ":" + (body ? body.textContent.length : 0) + ":"
            + window.innerWidth + ":" + (root ? root.scrollHeight : 0);
    }

    /// Runs `update` now when the page has been quiet, and otherwise once shortly after.
    function schedule(force) {
        pending = pending || force;
        if (timer) { return; }
        var wait = 250 - (Date.now() - lastRun);
        if (wait <= 0) {
            update(pending);
        } else {
            timer = setTimeout(function () { update(pending); }, wait);
        }
    }

    function hasElement(nodes) {
        for (var index = 0; index < nodes.length; index++) {
            if (nodes[index].nodeType === 1) { return true; }
        }
        return false;
    }

    var observer = new MutationObserver(function (records) {
        if (!current) { return; }
        // New elements and class changes can change the layout; new text alone only when its length changes.
        schedule(records.some(function (record) {
            return record.type === "attributes" || hasElement(record.addedNodes) || hasElement(record.removedNodes);
        }));
    });
    observer.observe(document, {
        childList: true, subtree: true, characterData: true,
        attributes: true, attributeFilter: ["class", "hidden", "open"]
    });

    function refresh() {
        if (current) { schedule(true); }
    }
    document.addEventListener("DOMContentLoaded", refresh);
    // Style sheets and images, which don't bubble: `update` sees a new style sheet or a page that changed its height.
    document.addEventListener("load", function () {
        if (current) { schedule(false); }
    }, true);
    window.addEventListener("load", refresh);
    window.addEventListener("resize", refresh);
    if (document.fonts && document.fonts.addEventListener) {
        document.fonts.addEventListener("loadingdone", refresh);
    }

    window[KEY] = {
        apply: function (value) {
            value = Number(value) || 0;
            if (value === current) { return; }
            current = value;
            rebuild();
            update(true);
        }
    };
    window[KEY].apply(extra);
})
