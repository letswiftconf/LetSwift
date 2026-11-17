// TEMP (Dynamic Type lab): reports how this WebKit handles -webkit-text-size-adjust percentages.
// Runs as a function body in the Home page (DT_LAB_WEB_JS) and returns JSON.
const out = {};
out.ua = navigator.userAgent;
out.viewport = [window.innerWidth, window.innerHeight, window.devicePixelRatio];
out.supports = CSS.supports('-webkit-text-size-adjust', '150%');
out.htmlAdjust = getComputedStyle(document.documentElement).webkitTextSizeAdjust;
out.bodyAdjust = getComputedStyle(document.body).webkitTextSizeAdjust;

const host = document.createElement('div');
host.style.cssText = 'position:absolute;left:0;top:0;width:300px;visibility:hidden;font:16px/normal sans-serif;';
document.body.appendChild(host);

function make(css, attributes) {
  const element = document.createElement('div');
  element.style.cssText = css;
  for (const name in (attributes || {})) element.setAttribute(name, attributes[name]);
  element.textContent = 'Text 가나다';
  host.appendChild(element);
  return element;
}
function child(parent, css) {
  const element = document.createElement('span');
  element.style.cssText = css;
  element.textContent = 'child 가나다';
  parent.appendChild(element);
  return element;
}
function info(element) {
  const style = getComputedStyle(element);
  const range = document.createRange();
  range.selectNodeContents(element);
  return {
    height: element.getBoundingClientRect().height,
    textWidth: range.getBoundingClientRect().width,
    fontSize: style.fontSize,
    adjust: style.webkitTextSizeAdjust,
    lineHeight: style.lineHeight,
  };
}

out.base = info(make('font-size:20px;'));
out.inline200 = info(make('font-size:20px;-webkit-text-size-adjust:200%;'));
const important = make('font-size:20px;');
important.style.setProperty('-webkit-text-size-adjust', '200%', 'important');
out.inlineImportant200 = info(important);
out.fixedLineHeight200 = info(make('font-size:20px;line-height:24px;-webkit-text-size-adjust:200%;'));
out.unitlessLineHeight200 = info(make('font-size:20px;line-height:1.2;-webkit-text-size-adjust:200%;'));

try {
  const sheet = new CSSStyleSheet();
  sheet.insertRule('[data-dtlab-probe="200"]{-webkit-text-size-adjust:200% !important}', 0);
  document.adoptedStyleSheets = [...document.adoptedStyleSheets, sheet];
  out.adoptedSheet200 = info(make('font-size:20px;', { 'data-dtlab-probe': '200' }));
} catch (error) {
  out.adoptedSheetError = String(error);
}

const parent = make('font-size:20px;-webkit-text-size-adjust:200%;');
out.childInherits = info(child(parent, ''));
out.childReset100 = info(child(parent, '-webkit-text-size-adjust:100%;'));
out.childHalfEmReset100 = info(child(parent, 'font-size:0.5em;-webkit-text-size-adjust:100%;'));
out.childHalfEmInherits = info(child(parent, 'font-size:0.5em;'));

host.remove();
return JSON.stringify(out);
