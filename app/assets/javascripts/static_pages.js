// This is a manifest file that'll be compiled into checker.js, which will include all the files
// listed below.
//
//= require static_pages/static_pages

var ready = function () {
  StaticPages.setup();
};

// Turbolinks workaround      
$(document).ready(ready)
$(document).on('page:load', ready)
