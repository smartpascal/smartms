!function(){"use strict";var e=function(){var e=function(e){var a=this,t=0;for(t=0;t<e.length;t++)
a[t]=e[t];return a.length=e.length,this},a=function(a,t){var n=[],r=0;if(a&&!t&&a instanceof e)
return a;if(a)
if("string"==typeof a){var i,s,o=a.trim();if(o.indexOf("<")>=0&&o.indexOf(">")>=0){var l="div";for(0===o.indexOf("<li")&&(l="ul"),0===o.indexOf("<tr")&&(l="tbody"),(0===o.indexOf("<td")||0===o.indexOf("<th"))&&(l="tr"),0===o.indexOf("<tbody")&&(l="table"),0===o.indexOf("<option")&&(l="select"),s=document.createElement(l),s.innerHTML=a,r=0;r<s.childNodes.length;r++)
n.push(s.childNodes[r])}else
for(i=t||"#"!==a[0]||a.match(/[ .<>:~]/)?(t||document).querySelectorAll(a):[document.getElementById(a.split("#")[1])],r=0;r<i.length;r++)
i[r]&&n.push(i[r])}else if(a.nodeType||a===window||a===document)
n.push(a);else if(a.length>0&&a[0].nodeType)
for(r=0;r<a.length;r++)
n.push(a[r]);return new e(n)};e.prototype={addClass:function(e){if("undefined"==typeof e)
return this;for(var a=e.split(" "),t=0;t<a.length;t++)
for(var n=0;n<this.length;n++)"undefined"!=typeof this[n].classList&&this[n].classList.add(a[t]);return this},removeClass:function(e){for(var a=e.split(" "),t=0;t<a.length;t++)
for(var n=0;n<this.length;n++)"undefined"!=typeof this[n].classList&&this[n].classList.remove(a[t]);return this},hasClass:function(e){return this[0]?this[0].classList.contains(e):!1},toggleClass:function(e){for(var a=e.split(" "),t=0;t<a.length;t++)
for(var n=0;n<this.length;n++)"undefined"!=typeof this[n].classList&&this[n].classList.toggle(a[t]);return this},attr:function(e,a){if(1===arguments.length&&"string"==typeof e)
return this[0]?this[0].getAttribute(e):void 0;for(var t=0;t<this.length;t++)
if(2===arguments.length)
this[t].setAttribute(e,a);else
for(var n in e)
this[t][n]=e[n],this[t].setAttribute(n,e[n]);return this},removeAttr:function(e){for(var a=0;a<this.length;a++)
this[a].removeAttribute(e);return this},prop:function(e,a){if(1===arguments.length&&"string"==typeof e)
return this[0]?this[0][e]:void 0;for(var t=0;t<this.length;t++)
if(2===arguments.length)
this[t][e]=a;else
for(var n in e)
this[t][n]=e[n];return this},data:function(e,a){if("undefined"!=typeof a){for(var t=0;t<this.length;t++){var n=this[t];n.dom7ElementDataStorage||(n.dom7ElementDataStorage={}),n.dom7ElementDataStorage[e]=a}
return this}
if(this[0]){if(this[0].dom7ElementDataStorage&&e in this[0].dom7ElementDataStorage)
return this[0].dom7ElementDataStorage[e];var r=this[0].getAttribute("data-"+e);return r?r:void 0}},removeData:function(e){for(var a=0;a<this.length;a++){var t=this[a];t.dom7ElementDataStorage&&t.dom7ElementDataStorage[e]&&(t.dom7ElementDataStorage[e]=null,delete t.dom7ElementDataStorage[e])}},dataset:function(){var e=this[0];if(e){var t={};if(e.dataset)
for(var n in e.dataset)
t[n]=e.dataset[n];else
for(var r=0;r<e.attributes.length;r++){var i=e.attributes[r];i.name.indexOf("data-")>=0&&(t[a.toCamelCase(i.name.split("data-")[1])]=i.value)}
for(var s in t)"false"===t[s]?t[s]=!1:"true"===t[s]?t[s]=!0:parseFloat(t[s])===1*t[s]&&(t[s]=1*t[s]);return t}},val:function(e){if("undefined"==typeof e)
return this[0]?this[0].value:void 0;for(var a=0;a<this.length;a++)
this[a].value=e;return this},transform:function(e){for(var a=0;a<this.length;a++){var t=this[a].style;t.webkitTransform=t.MsTransform=t.msTransform=t.MozTransform=t.OTransform=t.transform=e}
return this},transition:function(e){"string"!=typeof e&&(e+="ms");for(var a=0;a<this.length;a++){var t=this[a].style;t.webkitTransitionDuration=t.MsTransitionDuration=t.msTransitionDuration=t.MozTransitionDuration=t.OTransitionDuration=t.transitionDuration=e}
return this},on:function(e,t,n,r){function i(e){var r=e.target;if(a(r).is(t))
n.call(r,e);else
for(var i=a(r).parents(),s=0;s<i.length;s++)
a(i[s]).is(t)&&n.call(i[s],e)}
var s,o,l=e.split(" ");for(s=0;s<this.length;s++)
if("function"==typeof t||t===!1)
for("function"==typeof t&&(n=arguments[1],r=arguments[2]||!1),o=0;o<l.length;o++)
this[s].addEventListener(l[o],n,r);else
for(o=0;o<l.length;o++)
this[s].dom7LiveListeners||(this[s].dom7LiveListeners=[]),this[s].dom7LiveListeners.push({listener:n,liveListener:i}),this[s].addEventListener(l[o],i,r);return this},off:function(e,a,t,n){for(var r=e.split(" "),i=0;i<r.length;i++)
for(var s=0;s<this.length;s++)
if("function"==typeof a||a===!1)"function"==typeof a&&(t=arguments[1],n=arguments[2]||!1),this[s].removeEventListener(r[i],t,n);else if(this[s].dom7LiveListeners)
for(var o=0;o<this[s].dom7LiveListeners.length;o++)
this[s].dom7LiveListeners[o].listener===t&&this[s].removeEventListener(r[i],this[s].dom7LiveListeners[o].liveListener,n);return this},once:function(e,a,t,n){function r(s){t.call(s.target,s),i.off(e,a,r,n)}
var i=this;return"function"==typeof a&&(t=arguments[1],n=arguments[2],a=!1),i.on(e,a,r,n)},trigger:function(e,a){for(var t=e.split(" "),n=0;n<t.length;n++)
for(var r=0;r<this.length;r++){var i;try{i=new CustomEvent(t[n],{detail:a,bubbles:!0,cancelable:!0})}catch(s){i=document.createEvent("Event"),i.initEvent(t[n],!0,!0),i.detail=a}
this[r].dispatchEvent(i)}
return this},transitionEnd:function(e){function a(i){if(i.target===this)
for(e.call(this,i),t=0;t<n.length;t++)
r.off(n[t],a)}
var t,n=["webkitTransitionEnd","transitionend","oTransitionEnd","MSTransitionEnd","msTransitionEnd"],r=this;if(e)
for(t=0;t<n.length;t++)
r.on(n[t],a);return this},animationEnd:function(e){function a(i){for(e(i),t=0;t<n.length;t++)
r.off(n[t],a)}
var t,n=["webkitAnimationEnd","OAnimationEnd","MSAnimationEnd","animationend"],r=this;if(e)
for(t=0;t<n.length;t++)
r.on(n[t],a);return this},width:function(){return this[0]===window?window.innerWidth:this.length>0?parseFloat(this.css("width")):null},outerWidth:function(e){if(this.length>0){if(e){var a=this.styles();return this[0].offsetWidth+parseFloat(a.getPropertyValue("margin-right"))+parseFloat(a.getPropertyValue("margin-left"))}
return this[0].offsetWidth}
return null},height:function(){return this[0]===window?window.innerHeight:this.length>0?parseFloat(this.css("height")):null},outerHeight:function(e){if(this.length>0){if(e){var a=this.styles();return this[0].offsetHeight+parseFloat(a.getPropertyValue("margin-top"))+parseFloat(a.getPropertyValue("margin-bottom"))}
return this[0].offsetHeight}
return null},offset:function(){if(this.length>0){var e=this[0],a=e.getBoundingClientRect(),t=document.body,n=e.clientTop||t.clientTop||0,r=e.clientLeft||t.clientLeft||0,i=window.pageYOffset||e.scrollTop,s=window.pageXOffset||e.scrollLeft;return{top:a.top+i-n,left:a.left+s-r}}
return null},hide:function(){for(var e=0;e<this.length;e++)
this[e].style.display="none";return this},show:function(){for(var e=0;e<this.length;e++)
this[e].style.display="block";return this},styles:function(){return this[0]?window.getComputedStyle(this[0],null):void 0},css:function(e,a){var t;if(1===arguments.length){if("string"!=typeof e){for(t=0;t<this.length;t++)
for(var n in e)
this[t].style[n]=e[n];return this}
if(this[0])
return window.getComputedStyle(this[0],null).getPropertyValue(e)}
if(2===arguments.length&&"string"==typeof e){for(t=0;t<this.length;t++)
this[t].style[e]=a;return this}
return this},each:function(e){for(var a=0;a<this.length;a++)
e.call(this[a],a,this[a]);return this},filter:function(a){for(var t=[],n=this,r=0;r<n.length;r++)
a.call(n[r],r,n[r])&&t.push(n[r]);return new e(t)},html:function(e){if("undefined"==typeof e)
return this[0]?this[0].innerHTML:void 0;for(var a=0;a<this.length;a++)
this[a].innerHTML=e;return this},text:function(e){if("undefined"==typeof e)
return this[0]?this[0].textContent.trim():null;for(var a=0;a<this.length;a++)
this[a].textContent=e},is:function(t){if(!this[0]||"undefined"==typeof t)
return!1;var n,r;if("string"==typeof t){var i=this[0];if(i===document)
return t===document;if(i===window)
return t===window;if(i.matches)
return i.matches(t);if(i.webkitMatchesSelector)
return i.webkitMatchesSelector(t);if(i.mozMatchesSelector)
return i.mozMatchesSelector(t);if(i.msMatchesSelector)
return i.msMatchesSelector(t);for(n=a(t),r=0;r<n.length;r++)
if(n[r]===this[0])
return!0;return!1}
if(t===document)
return this[0]===document;if(t===window)
return this[0]===window;if(t.nodeType||t instanceof e){for(n=t.nodeType?[t]:t,r=0;r<n.length;r++)
if(n[r]===this[0])
return!0;return!1}
return!1},indexOf:function(e){for(var a=0;a<this.length;a++)
if(this[a]===e)
return a},index:function(){if(this[0]){for(var e=this[0],a=0;null!==(e=e.previousSibling);)
1===e.nodeType&&a++;return a}},eq:function(a){if("undefined"==typeof a)
return this;var t,n=this.length;return a>n-1?new e([]):0>a?(t=n+a,new e(0>t?[]:[this[t]])):new e([this[a]])},append:function(a){var t,n;for(t=0;t<this.length;t++)
if("string"==typeof a){var r=document.createElement("div");for(r.innerHTML=a;r.firstChild;)
this[t].appendChild(r.firstChild)}else if(a instanceof e)
for(n=0;n<a.length;n++)
this[t].appendChild(a[n]);else
this[t].appendChild(a);return this},appendTo:function(e){return a(e).append(this),this},prepend:function(a){var t,n;for(t=0;t<this.length;t++)
if("string"==typeof a){var r=document.createElement("div");for(r.innerHTML=a,n=r.childNodes.length-1;n>=0;n--)
this[t].insertBefore(r.childNodes[n],this[t].childNodes[0])}else if(a instanceof e)
for(n=0;n<a.length;n++)
this[t].insertBefore(a[n],this[t].childNodes[0]);else
this[t].insertBefore(a,this[t].childNodes[0]);return this},prependTo:function(e){return a(e).prepend(this),this},insertBefore:function(e){for(var t=a(e),n=0;n<this.length;n++)
if(1===t.length)
t[0].parentNode.insertBefore(this[n],t[0]);else if(t.length>1)
for(var r=0;r<t.length;r++)
t[r].parentNode.insertBefore(this[n].cloneNode(!0),t[r])},insertAfter:function(e){for(var t=a(e),n=0;n<this.length;n++)
if(1===t.length)
t[0].parentNode.insertBefore(this[n],t[0].nextSibling);else if(t.length>1)
for(var r=0;r<t.length;r++)
t[r].parentNode.insertBefore(this[n].cloneNode(!0),t[r].nextSibling)},next:function(t){return new e(this.length>0?t?this[0].nextElementSibling&&a(this[0].nextElementSibling).is(t)?[this[0].nextElementSibling]:[]:this[0].nextElementSibling?[this[0].nextElementSibling]:[]:[])},nextAll:function(t){var n=[],r=this[0];if(!r)
return new e([]);for(;r.nextElementSibling;){var i=r.nextElementSibling;t?a(i).is(t)&&n.push(i):n.push(i),r=i}
return new e(n)},prev:function(t){return new e(this.length>0?t?this[0].previousElementSibling&&a(this[0].previousElementSibling).is(t)?[this[0].previousElementSibling]:[]:this[0].previousElementSibling?[this[0].previousElementSibling]:[]:[])},prevAll:function(t){var n=[],r=this[0];if(!r)
return new e([]);for(;r.previousElementSibling;){var i=r.previousElementSibling;t?a(i).is(t)&&n.push(i):n.push(i),r=i}
return new e(n)},siblings:function (selector){return this.nextAll(selector).add(this.prevAll(selector));},parent:function(e){for(var t=[],n=0;n<this.length;n++)
null!==this[n].parentNode&&(e?a(this[n].parentNode).is(e)&&t.push(this[n].parentNode):t.push(this[n].parentNode));return a(a.unique(t))},parents:function(e){for(var t=[],n=0;n<this.length;n++)
for(var r=this[n].parentNode;r;)
e?a(r).is(e)&&t.push(r):t.push(r),r=r.parentNode;return a(a.unique(t))},find:function(a){for(var t=[],n=0;n<this.length;n++)
for(var r=this[n].querySelectorAll(a),i=0;i<r.length;i++)
t.push(r[i]);return new e(t)},children:function(t){for(var n=[],r=0;r<this.length;r++)
for(var i=this[r].childNodes,s=0;s<i.length;s++)
t?1===i[s].nodeType&&a(i[s]).is(t)&&n.push(i[s]):1===i[s].nodeType&&n.push(i[s]);return new e(a.unique(n))},remove:function(){for(var e=0;e<this.length;e++)
this[e].parentNode&&this[e].parentNode.removeChild(this[e]);return this},detach:function(){return this.remove()},add:function(){var e,t,n=this;for(e=0;e<arguments.length;e++){var r=a(arguments[e]);for(t=0;t<r.length;t++)
n[n.length]=r[t],n.length++}
return n}},function(){function t(t){e.prototype[t]=function(e,n,i){var s;if("undefined"==typeof e){for(s=0;s<this.length;s++)
r.indexOf(t)<0&&(t in this[s]?this[s][t]():a(this[s]).trigger(t));return this}
return this.on(t,e,n,i)}}
for(var n="click blur focus focusin focusout keyup keydown keypress submit change mousedown mousemove mouseup mouseenter mouseleave mouseout mouseover touchstart touchend touchmove resize scroll".split(" "),r="resize scroll".split(" "),i=0;i<n.length;i++)
t(n[i])}
();var t={};a.ajaxSetup=function(e){e.type&&(e.method=e.type),a.each(e,function(e,a){t[e]=a})};var n=0;return a.ajax=function(e){function r(n,r,i){var s=arguments;n&&a(document).trigger(n,r),i&&(i in t&&t[i](s[3],s[4],s[5],s[6]),e[i]&&e[i](s[3],s[4],s[5],s[6]))}
var i={method:"GET",data:!1,async:!0,cache:!0,user:"",password:"",headers:{},xhrFields:{},statusCode:{},processData:!0,dataType:"text",contentType:"application/x-www-form-urlencoded",timeout:0},s=["beforeSend","error","complete","success","statusCode"];e.type&&(e.method=e.type),a.each(t,function(e,a){s.indexOf(e)<0&&(i[e]=a)}),a.each(i,function(a,t){a in e||(e[a]=t)}),e.url||(e.url=window.location.toString());var o=e.url.indexOf("?")>=0?"&":"?",l=e.method.toUpperCase();if(("GET"===l||"HEAD"===l||"OPTIONS"===l||"DELETE"===l)&&e.data){var p;p="string"==typeof e.data?e.data.indexOf("?")>=0?e.data.split("?")[1]:e.data:a.serializeObject(e.data),p.length&&(e.url+=o+p,"?"===o&&(o="&"))}
if("json"===e.dataType&&e.url.indexOf("callback=")>=0){var d,c="f7jsonp_"+Date.now()+n++,u=e.url.split("callback="),m=u[0]+"callback="+c;if(u[1].indexOf("&")>=0){var f=u[1].split("&").filter(function(e){return e.indexOf("=")>0}).join("&");f.length>0&&(m+="&"+f)}
var h=document.createElement("script");return h.type="text/javascript",h.onerror=function(){clearTimeout(d),r(void 0,void 0,"error",null,"scripterror")},h.src=m,window[c]=function(e){clearTimeout(d),r(void 0,void 0,"success",e),h.parentNode.removeChild(h),h=null,delete window[c]},document.querySelector("head").appendChild(h),void(e.timeout>0&&(d=setTimeout(function(){h.parentNode.removeChild(h),h=null,r(void 0,void 0,"error",null,"timeout")},e.timeout)))}
("GET"===l||"HEAD"===l||"OPTIONS"===l||"DELETE"===l)&&e.cache===!1&&(e.url+=o+"_nocache="+Date.now());var g=new XMLHttpRequest;g.requestUrl=e.url,g.requestParameters=e,g.open(l,e.url,e.async,e.user,e.password);var v=null;if(("POST"===l||"PUT"===l||"PATCH"===l)&&e.data)
if(e.processData){var b=[ArrayBuffer,Blob,Document,FormData];if(b.indexOf(e.data.constructor)>=0)
v=e.data;else{var w="---------------------------"+Date.now().toString(16);"multipart/form-data"===e.contentType?g.setRequestHeader("Content-Type","multipart/form-data; boundary="+w):g.setRequestHeader("Content-Type",e.contentType),v="";var C=a.serializeObject(e.data);if("multipart/form-data"===e.contentType){w="---------------------------"+Date.now().toString(16),C=C.split("&");for(var y=[],x=0;x<C.length;x++)
y.push('Content-Disposition: form-data; name="'+C[x].split("=")[0]+'"\r\n\r\n'+C[x].split("=")[1]+"\r\n");v="--"+w+"\r\n"+y.join("--"+w+"\r\n")+"--"+w+"--\r\n"}else
v="application/x-www-form-urlencoded"===e.contentType?C:C.replace(/&/g,"\r\n")}}else
v=e.data;e.headers&&a.each(e.headers,function(e,a){g.setRequestHeader(e,a)}),"undefined"==typeof e.crossDomain&&(e.crossDomain=/^([\w-]+:)?\/\/([^\/]+)/.test(e.url)&&RegExp.$2!==window.location.host),e.crossDomain||g.setRequestHeader("X-Requested-With","XMLHttpRequest"),e.xhrFields&&a.each(e.xhrFields,function(e,a){g[e]=a});var T;return g.onload=function(a){if(T&&clearTimeout(T),g.status>=200&&g.status<300||0===g.status){var n;if("json"===e.dataType)
try{n=JSON.parse(g.responseText),r("ajaxSuccess",{xhr:g},"success",n,g.status,g)}catch(i){r("ajaxError",{xhr:g,parseerror:!0},"error",g,"parseerror")}
else
n="text"===g.responseType||""===g.responseType?g.responseText:g.response,r("ajaxSuccess",{xhr:g},"success",n,g.status,g)}else
r("ajaxError",{xhr:g},"error",g,g.status);e.statusCode&&(t.statusCode&&t.statusCode[g.status]&&t.statusCode[g.status](g),e.statusCode[g.status]&&e.statusCode[g.status](g)),r("ajaxComplete",{xhr:g},"complete",g,g.status)},g.onerror=function(e){T&&clearTimeout(T),r("ajaxError",{xhr:g},"error",g,g.status)},r("ajaxStart",{xhr:g},"start",g),r(void 0,void 0,"beforeSend",g),g.send(v),e.timeout>0&&(g.onabort=function(){T&&clearTimeout(T)},T=setTimeout(function(){g.abort(),r("ajaxError",{xhr:g,timeout:!0},"error",g,"timeout"),r("ajaxComplete",{xhr:g,timeout:!0},"complete",g,"timeout")},e.timeout)),g},function(){function e(e){a[e]=function(t,n,r){return a.ajax({url:t,method:"post"===e?"POST":"GET",data:"function"==typeof n?void 0:n,success:"function"==typeof n?n:r,dataType:"getJSON"===e?"json":void 0})}}
for(var t="get post getJSON".split(" "),n=0;n<t.length;n++)
e(t[n])}
(),a.parseUrlQuery=function(e){var a,t,n,r={};if(!(e.indexOf("?")>=0))
return r;for(e=e.split("?")[1],t=e.split("&"),a=0;a<t.length;a++)
n=t[a].split("="),r[n[0]]=n[1];return r},a.isArray=function(e){return"[object Array]"===Object.prototype.toString.apply(e)?!0:!1},a.each=function(t,n){if("object"==typeof t&&n){var r,i;if(a.isArray(t)||t instanceof e)
for(r=0;r<t.length;r++)
n(r,t[r]);else
for(i in t)
t.hasOwnProperty(i)&&n(i,t[i])}},a.unique=function(e){for(var a=[],t=0;t<e.length;t++)
-1===a.indexOf(e[t])&&a.push(e[t]);return a},a.serializeObject=a.param=function(e,t){function n(e){if(t.length>0){for(var a="",n=0;n<t.length;n++)
a+=0===n?t[n]:"["+encodeURIComponent(t[n])+"]";return a+"["+encodeURIComponent(e)+"]"}
return encodeURIComponent(e)}
function r(e){return encodeURIComponent(e)}
if("string"==typeof e)
return e;var i=[],s="&";t=t||[];var o;for(var l in e)
if(e.hasOwnProperty(l)){var p;if(a.isArray(e[l])){p=[];for(var d=0;d<e[l].length;d++)
a.isArray(e[l][d])||"object"!=typeof e[l][d]?p.push(n(l)+"[]="+r(e[l][d])):(o=t.slice(),o.push(l),o.push(d+""),p.push(a.serializeObject(e[l][d],o)));p.length>0&&i.push(p.join(s))}else"object"==typeof e[l]?(o=t.slice(),o.push(l),p=a.serializeObject(e[l],o),""!==p&&i.push(p)):"undefined"!=typeof e[l]&&""!==e[l]&&i.push(n(l)+"="+r(e[l]))}
return i.join(s)},a.toCamelCase=function(e){return e.toLowerCase().replace(/-(.)/g,function(e,a){return a.toUpperCase()})},a.dataset=function(e){return a(e).dataset()},a.getTranslate=function(e,a){var t,n,r,i;return"undefined"==typeof a&&(a="x"),r=window.getComputedStyle(e,null),window.WebKitCSSMatrix?(n=r.transform||r.webkitTransform,n.split(",").length>6&&(n=n.split(", ").map(function(e){return e.replace(",",".")}).join(", ")),i=new WebKitCSSMatrix("none"===n?"":n)):(i=r.MozTransform||r.OTransform||r.MsTransform||r.msTransform||r.transform||r.getPropertyValue("transform").replace("translate(","matrix(1, 0, 0, 1,"),t=i.toString().split(",")),"x"===a&&(n=window.WebKitCSSMatrix?i.m41:16===t.length?parseFloat(t[12]):parseFloat(t[4])),"y"===a&&(n=window.WebKitCSSMatrix?i.m42:16===t.length?parseFloat(t[13]):parseFloat(t[5])),n||0},a.requestAnimationFrame=function(e){return window.requestAnimationFrame?window.requestAnimationFrame(e):window.webkitRequestAnimationFrame?window.webkitRequestAnimationFrame(e):window.mozRequestAnimationFrame?window.mozRequestAnimationFrame(e):window.setTimeout(e,1e3/60)},a.cancelAnimationFrame=function(e){return window.cancelAnimationFrame?window.cancelAnimationFrame(e):window.webkitCancelAnimationFrame?window.webkitCancelAnimationFrame(e):window.mozCancelAnimationFrame?window.mozCancelAnimationFrame(e):window.clearTimeout(e)},a.supportTouch=!!("ontouchstart"in window||window.DocumentTouch&&document instanceof DocumentTouch),a.fn=e.prototype,a.fn.scrollTo=function(e,t,n,r,i){return 4===arguments.length&&"function"==typeof r&&(i=r,r=void 0),this.each(function(){function s(e){void 0===e&&(e=(new Date).getTime()),null===b&&(b=e);var t,p=Math.max(Math.min((e-b)/n,1),0),d="linear"===r?p:.5-Math.cos(p*Math.PI)/2;return g&&(m=o+d*(c-o)),v&&(f=l+d*(u-l)),g&&c>o&&m>=c&&(h.scrollTop=c,t=!0),g&&o>c&&c>=m&&(h.scrollTop=c,t=!0),v&&u>l&&f>=u&&(h.scrollLeft=u,t=!0),v&&l>u&&u>=f&&(h.scrollLeft=u,t=!0),t?void(i&&i()):(g&&(h.scrollTop=m),v&&(h.scrollLeft=f),void a.requestAnimationFrame(s))}
var o,l,p,d,c,u,m,f,h=this,g=t>0||0===t,v=e>0||0===e;if("undefined"==typeof r&&(r="swing"),g&&(o=h.scrollTop,n||(h.scrollTop=t)),v&&(l=h.scrollLeft,n||(h.scrollLeft=e)),n){g&&(p=h.scrollHeight-h.offsetHeight,c=Math.max(Math.min(t,p),0)),v&&(d=h.scrollWidth-h.offsetWidth,u=Math.max(Math.min(e,d),0));var b=null;g&&c===o&&(g=!1),v&&u===l&&(v=!1),a.requestAnimationFrame(s)}})},a.fn.scrollTop=function(e,a,t,n){3===arguments.length&&"function"==typeof t&&(n=t,t=void 0);var r=this;return"undefined"==typeof e?r.length>0?r[0].scrollTop:null:r.scrollTo(void 0,e,a,t,n)},a.fn.scrollLeft=function(e,a,t,n){3===arguments.length&&"function"==typeof t&&(n=t,t=void 0);var r=this;return"undefined"==typeof e?r.length>0?r[0].scrollLeft:null:r.scrollTo(e,void 0,a,t,n)},a}
();var a=e;window.Dom7=e;}();

var TObject={$ClassName:"TObject",$Parent:null,ClassName:function(s){return s.$ClassName},ClassType:function(s){return s},ClassParent:function(s){return s.$Parent},$Init:function(){},Create:function(s){return s},Destroy:function(s){for(var prop in s)if(s.hasOwnProperty(prop))delete s.prop},Destroy$:function(s){return s.ClassType.Destroy(s)},Free:function(s){if(s!==null)s.ClassType.Destroy(s)}}
var Exception={$ClassName:"Exception",$Parent:TObject,$Init:function(){FMessage=""},Create:function(s,Msg){s.FMessage=Msg;return s}}
function $W(e){return e.ClassType?e:Exception.Create($New(Exception),e.constructor.name+", "+e.message)}
function $New(c){var i={ClassType:c};c.$Init(i);return i}
function $Is(o,c){if(o===null)return false;return $Inh(o.ClassType,c)};function $Inh(s,c){if(s===null)return false;while((s)&&(s!==c))s=s.$Parent;return(s)?true:false};function $Event0(i,f){var li=i,lf=f;return function(){return lf.call(li,li)}}
var ynp={$ClassName:"TApplication",$Parent:TObject,$Init:function($){TObject.$Init($)},c5v:function(S){document.getElementById("sms-an-scene-0").setAttribute("class","run "+"t-0");sxZ();TtS();jJC();Wp("6")},t0T:function(S){TObject.Create(S);return S},Fsj:function(S){UoI.tsq(UoI);Ydp.o37(Ydp);ynp.c5v(S)},Destroy:TObject.Destroy};function DYm(){var KRw;KRw=zK();{var $t1=KRw;if($t1=="sms-page4"){UoI.l1(UoI)}
else if($t1=="sms-page5"){UoI.kL2(UoI)}
else if($t1=="sms-page6"){UoI.S1(UoI)}
else if($t1=="sms-page7"){UoI.Vr(UoI)}
else if($t1=="sms-page8"){UoI.LTz(UoI)}
else if($t1=="sms-page9"){UoI.oiu(UoI)}
else if($t1=="sms-page10"){UoI.v6x(UoI)}
else if($t1=="sms-page11"){UoI.Ks(UoI)}
else if($t1=="sms-page12"){UoI.FB1(UoI)}
else if($t1=="sms-page13"){UoI.KUw(UoI)}
else if($t1=="sms-page14"){UoI.Sj3(UoI)}
else if($t1=="sms-page15"){UoI.oz9(UoI)}
else if($t1=="sms-page16"){UoI.HD4(UoI)}
else if($t1=="sms-page17"){UoI.d27(UoI)}
else if($t1=="sms-page18"){UoI.Mp(UoI)}
else if($t1=="sms-page19"){UoI.uB6(UoI)}
else if($t1=="sms-page20"){UoI.NNa(UoI)}
else if($t1=="sms-page21"){UoI.z6d(UoI)}
else if($t1=="sms-page22"){UoI.qX(UoI)}
else if($t1=="sms-page23"){UoI.XeD(UoI)}
else if($t1=="sms-page24"){UoI.eX(UoI)}
else if($t1=="sms-page25"){UoI.NeV(UoI)}
else if($t1=="sms-page26"){UoI.M5j(UoI)}
else if($t1=="sms-page27"){UoI.iL(UoI)}}};function zK(){var R=undefined;R=(document.querySelector(".tela:not(.nm)")!=null)?document.querySelector(".tela:not(.nm)").id:"";return R};var Ydp={$ClassName:"TBindEventPage",$Parent:TObject,$Init:function($){TObject.$Init($)},cHZ:function(S,Gkg){var Zf=0;var $t2;for(Zf=0,$t2=Gkg.length;Zf<$t2;Zf++){TQJ(Gkg[Zf].element).on(Gkg[Zf].event,Gkg[Zf].handler)}},o37:function(S){var R=null;console.log("TBindEventPage.InitializeObject");Ydp.dx8(S);Ydp.cHZ(S,aou);Ydp.fN(S);return R},dx8:function(S){iGu(JI,"AnimationStart",function(){console.log("AnimationStart11111");TQJ(this).addClass("paused")});iGu(JI,"AnimationEnd",function(){console.log("AnimationEndt11111");Wp("24");TQJ("#sms-page2b")[0].style.webkitAnimationName="ani-sms-page2b-0"});iGu(sbn,"AnimationStart",function(){console.log("AnimationStart2222222222");TQJ(this).addClass("paused")});iGu(sbn,"AnimationEnd",function(){console.log("AnimationEnd card out");TQJ("#sms-page1-2").removeClass("nm");Wp("24");TQJ("#sms-page2b")[0].style.webkitAnimationName="ani-sms-page2b-0"});iGu(uM8,"AnimationStart",function(){console.log("AnimationStart cash");TQJ(this).addClass("paused")});iGu(uM8,"AnimationEnd",function(){console.log("AnimationStart cash")});iGu(a4,"AnimationStart",function(){console.log("Processing your request...");TQJ(this).addClass("paused")});iGu(a4,"AnimationEnd",function(){console.log("Processing your request...");TQJ(this).addClass("nm");TQJ(this).addClass("paused")});iGu(YAB,"AnimationStart",function(){console.log("take your receipt");TQJ(this).addClass("paused")});iGu(YAB,"AnimationEnd",function(){console.log("take your receipt");TQJ(this).addClass("paused")});iGu(qRR,"AnimationStart",function(){var an1;console.log("pulling the envelope");an1=document.getElementById("sms-page3a");an1.classList.add("paused")});iGu(qRR,"AnimationEnd",function(){console.log("pulling the envelope")})},BuX:function(S){TtS();sxZ();window.setTimeout(function(){TQJ("#sms-page2b").removeClass("paused");TQJ("#sms-page2b").removeClass("nm");TQJ("#sms-page2b")[0].click()},1000,null);jJC()},yiw:function(S){console.log("card A clicked");sxZ();Wga("2");TQJ("#sms-page2a").removeClass("paused")},CvX:function(S){console.log("card B clicked");sxZ();TQJ("#sms-page2b")[0].style.webkitAnimationName="ani-sms-page2a-0";TQJ("#sms-page2b").removeClass("paused");Wp("6")},fN:function(S){TQJ("#sms-page23").on("click",function(){var i9=undefined;console.log("restart CASH animation");i9=this;this.style.webkitAnimation="none";window.setTimeout(function(){i9.style.webkitAnimation="";i9.classList.add("nm")},100,null)})},Destroy:TObject.Destroy};function rX5(){TQJ("#sms-page23").removeClass("nm")};function jJC(){window.setTimeout(function(){TQJ("#sms-page1-1").removeClass("nm")},0,null);TQJ("#sms-page1-1").addClass("nm")};function Wp(Bc){sxZ();TQJ("#sms-page"+Bc+"").removeClass("nm");DYm()};function CHQ(){console.log("restart ENVELOPE animation");TQJ("#sms-page3a")[0].style.webkitAnimation="none";window.setTimeout(function(){TQJ("#sms-page3a")[0].style.webkitAnimation=""},10,null)};function Wga(hO){TQJ("#sms-page1-"+hO+"").removeClass("nm")};function sxZ(){var sSj=0;for(sSj=4;sSj<=26;sSj++){TQJ("#sms-page"+sSj.toString()+"").addClass("nm")}};function TtS(){var Nro=0;var kk,QsR;document.getElementById("sms-page1-2").classList.add("nm");document.getElementById("sms-page1-3").classList.add("nm");for(Nro=4;Nro<=11;Nro++){kk=document.getElementById("sms-page1-"+Nro.toString()+"");QsR=kk.cloneNode(true);QsR.classList.add("nm");kk.parentNode.replaceChild(QsR,kk)}};function iGu(TnR,rHL,aKB){var r74=0;for(r74=0;r74<=5;r74++){if(!ix[r74])rHL=rHL.toLowerCase();TnR.addEventListener(ix[r74]+rHL,aKB,false)}};function TQJ(VAK){var R=undefined;return window.Dom7(VAK);return R};var UoI={$ClassName:"TPage",$Parent:TObject,$Init:function($){TObject.$Init($)},tsq:function(S){var R=null;console.log("TPage.InitializeObject");return R},v6x:function(S){console.log("TELA 10");TtS();Wga("2");Wga("11");Wga("7");TQJ("#sms-page1-11").once("click",function(q79){console.log("I accept");Wp("8")});TQJ("#sms-page1-7").once("click",function(oMa){console.log("Cancel button");Wp("18")})},Ks:function(S){console.log("TELA 11");TtS();Wga("2");Wga("3");TQJ("#sms-page1-3").once("click",function(YN5){console.log("I accept, that is correct the amount.")})},FB1:function(S){console.log("TELA 12")},KUw:function(S){console.log("TELA 13")},Sj3:function(S){console.log("TELA 14");TtS();Wga("2");Wga("3");Wga("7");TQJ("#sms-page1-7").once("click",function(nBf){console.log("hum, there are something wrong with the amount entered.");Wp("8")});TQJ("#sms-page1-3").once("click",function(flH){console.log("I accept, that is correct the amount.");Wp("4");Wp("15")})},oz9:function(S){console.log("TELA 15");TtS();Wga("2");Wga("3");Wga("10");Wga("6");window.setTimeout(function(){TQJ("#sms-page5").removeClass("nm");TQJ("#sms-page5a").removeClass("nm");console.log("first");window.setTimeout(function(){console.log("second");TQJ("#sms-page5").removeClass("paused");TQJ("#sms-page5a").removeClass("paused")},1000,null)},1000,null);TQJ("#sms-page5a").once("click",function(){var uY3=undefined;console.log("restart CASH animation");uY3=this;this.style.webkitAnimation="none";window.setTimeout(function(){uY3.style.webkitAnimation="";TQJ("#sms-page5a").addClass("nm")},10,null)});TQJ("#sms-page1-6").once("click",function(XNk){console.log("NO");Wp("16")});TQJ("#sms-page1-10").once("click",function(JIH){console.log("YES");window.setTimeout(function(){console.log("starting receipt");Wp("17");window.setTimeout(function(){console.log("going to screen 17");rX5()},1000,null)},1000,null)})},HD4:function(S){console.log("TELA 16");TtS();Wga("2");Wga("10");Wga("6");TQJ("#sms-page1-10").once("click",function(OXb){console.log("YES, I want to do something else");Wp("7")});TQJ("#sms-page1-6").once("click",function(MCY){console.log("No, that is all");Wp("18")})},d27:function(S){console.log("TELA 17");TtS();Wga("2");Wga("10");Wga("6");TQJ("#sms-page1-10").once("click",function(Et1){console.log("YES, I want to do something else");Wp("7")});TQJ("#sms-page1-6").once("click",function(PyL){console.log("No, that is all");Wp("18")})},Mp:function(S){console.log("TELA 18");window.setTimeout(function(){TQJ("#sms-page1-2").click()},2000,null)},uB6:function(S){console.log("TELA 19");TtS();Wga("10");Wga("6");CHQ();TQJ("#sms-page1-6").once("click",function(A1){console.log("NO");Wp("16")});TQJ("#sms-page1-10").once("click",function(VTV){console.log("YES");window.setTimeout(function(){console.log("starting receipt");Wp("17");window.setTimeout(function(){console.log("going to screen 17");rX5()},1000,null)},1000,null)})},NNa:function(S){console.log("TELA 20");TtS();TQJ("#sms-page3a").once("click",function(){var wN=undefined;console.log("restart CASH animation");wN=this;this.style.webkitAnimation="none";window.setTimeout(function(){wN.style.webkitAnimation="";TQJ("#sms-page3a").removeClass("paused");window.setTimeout(function(){Wp("4");window.setTimeout(function(){Wp("19")},3000,null)},2000,null)},10,null)})},z6d:function(S){console.log("TELA 21")},qX:function(S){console.log("TELA 22")},XeD:function(S){console.log("TELA 23")},eX:function(S){function zuF(){var MH;Wga("6");Wga("10");MH=TQJ("#sms-page24b input").val();if(MH=="1234"){console.log("correct PIN");Wp("7")}else{console.log("incorrect PIN");window.setTimeout(function(){Wp("25")},0,null)}};console.log("TELA 24");Wga("3");TQJ("#sms-page1-3").once("click",function(QrU){DYm();zuF()})},NeV:function(S){console.log("TELA 25");TQJ("#sms-page1-10").once("click",function(vfU){vfU.preventDefault();console.log("L3");Wp("24")});TQJ("#sms-page1-6").once("click",function(Xvi){Xvi.preventDefault();console.log("R3");TQJ("#sms-page1-2").click()})},M5j:function(S){console.log("TELA 26");TtS();Wga("2");Wga("3");TQJ("#sms-page1-3").once("click",function(STa){console.log("Exactly, that is correct the amount.");Wp("20")})},iL:function(S){console.log("TELA 27")},l1:function(S){console.log("TELA 4");window.setTimeout(function(){TQJ("#sms-page4").removeClass("nm");console.log("first");window.setTimeout(function(){console.log("second");TQJ("#sms-page4").removeClass("paused")},10,null)},20,null)},kL2:function(S){console.log("TELA 5")},S1:function(S){console.log("TELA 6")},Vr:function(S){console.log("TELA 7");TtS();Wga("2");Wga("9");Wga("10");Wga("11");TQJ("#sms-page1-9").once("click",function(SMM){console.log("Withdrawal");Wp("9")});TQJ("#sms-page1-10").once("click",function(xYP){console.log("Transfer")});TQJ("#sms-page1-11").once("click",function(yEZ){console.log("Bill Payment")});Wga("5");Wga("6");Wga("7");TQJ("#sms-page1-5").once("click",function(ALm){console.log("Deposit");Wp("26")});TQJ("#sms-page1-6").once("click",function(cz6){console.log("Bank Statement")});TQJ("#sms-page1-7").once("click",function(blZ){console.log("Account Balance")})},LTz:function(S){console.log("TELA 8");TtS();Wga("2");window.setTimeout(function(){Wga("9");Wga("10");Wga("11");Wga("5");Wga("6");Wga("7")},1000,null);TQJ("#sms-page1-9").once("click",function(rn){console.log("$20");Wp("14")});TQJ("#sms-page1-10").once("click",function(MVL){console.log("$60");Wp("14")});TQJ("#sms-page1-11").once("click",function(uHT){console.log("$100");Wp("14")});TQJ("#sms-page1-5").once("click",function(G0P){console.log("$140");Wp("14")});TQJ("#sms-page1-6").once("click",function(xtx){console.log("$200");Wp("14")});TQJ("#sms-page1-7").once("click",function(GmW){console.log("another amount");Wp("11")})},oiu:function(S){console.log("TELA 9");TtS();Wga("2");Wga("9");Wga("5");TQJ("#sms-page1-9").once("click",function(AOX){console.log("Savings");Wp("10")});TQJ("#sms-page1-5").once("click",function(QJR){console.log("Chequing")})},Destroy:TObject.Destroy};var o8=null,aou=[],ix=["","","","",""],JI,sbn,a4,uM8,YAB,qRR;var aou=[{handler:$Event0(Ydp,Ydp.BuX),event:"click",element:"#sms-page1-2"},{handler:$Event0(Ydp,Ydp.yiw),event:"click",element:"#sms-page2a"},{handler:$Event0(Ydp,Ydp.CvX),event:"click",element:"#sms-page2b"}].slice();var ix=["webkit","moz","MS","o",""];var JI=document.getElementById("sms-page2a");var sbn=document.getElementById("sms-page2b");var a4=document.getElementById("sms-page4");var uM8=document.getElementById("sms-page5a");var YAB=document.getElementById("sms-page23");var qRR=document.getElementById("sms-page3a");var $Application=function(){try{o8=ynp.t0T($New(ynp));ynp.Fsj(o8)}catch($e){var fgj=$W($e);console.log(fgj.FMessage)}}
$Application();
