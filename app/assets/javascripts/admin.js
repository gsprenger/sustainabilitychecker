// This is a manifest file that'll be compiled into checker.js, which will include all the files
// listed below.
//
//= require_tree ./admin

var ready = function () {
  Admin.setup();
};

// Turbolinks workaround      
$(document).ready(ready)
$(document).on('page:load', ready)
