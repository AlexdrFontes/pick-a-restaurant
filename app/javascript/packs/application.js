import "bootstrap";
import { autocomplete } from 'autocomplete';
autocomplete();
import "range_slider";


//= require simple_form_extension

// (function(){function t(t){function n(t){var n=(new Date).getTime()-a;e.duration>n?clearTimeout(i):t.target.dispatchEvent(o),r(t)}function r(t){t.target.removeEventListener("mouseup",n),t.target.removeEventListener("touchstop",n)}var a=(new Date).getTime();t.target.addEventListener("mouseup",n),t.target.addEventListener("touchstop",n);var i=setTimeout(function(){t.target.dispatchEvent(o),r(t)},e.duration)}var e={duration:500};if("object"==typeof longpress_config)for(var n in longpress_config)e[n]=longpress_config[n];var o=document.createEvent("CustomEvent");o.initCustomEvent("longpress",!0,!0,{});var r=document.body;r.addEventListener("mousedown",t),r.addEventListener("touchstart",t)})();

