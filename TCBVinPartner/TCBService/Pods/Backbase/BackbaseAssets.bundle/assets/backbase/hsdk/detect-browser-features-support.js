/**
 * Name: detect-browser-features-support
 * Description: Detects what features the current browser supports
 * Version: 1.6.0
 * SHA-1: 23e5fafdff9b05b8001376b64322a2d6fbfb06ee
 */
this.BrowserFeaturesSupport=function(){"use strict";function isFunction(arg){return typeof arg==="function"}function isDOM4Supported(){var testElement=document.createElement("div");var isClassListSupported="classList"in testElement;var isEventComposedPathSupported="composedPath"in Event.prototype;var isGetRootNodeSupported=isFunction(Element.prototype.getRootNode);return isClassListSupported&&isEventComposedPathSupported&&isGetRootNodeSupported}function isES2017Supported(){return isFunction(String.prototype.padStart)&&isFunction(Object.entries)&&isFunction(Object.values)}function isIntlSupported(){return"Intl"in window}function isWebComponentsSupported(){var ElementProto=Element.prototype;var isCustomElementsSupported="customElements"in window;var isShadowDOMSupported="attachShadow"in ElementProto&&"getRootNode"in ElementProto;return isCustomElementsSupported&&isShadowDOMSupported}var detectBrowserFeaturesSupport={dom4:isDOM4Supported(),es2015:isES2017Supported(),intl:isIntlSupported(),webComponents:isWebComponentsSupported()};return detectBrowserFeaturesSupport}();
