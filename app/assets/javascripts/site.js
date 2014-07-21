// This is a manifest file that'll be compiled into site.js, which will include all the files
// listed below.
//
//= require_tree ./site

var ready = function () {
  setup()
};

// Turbolinks workaround      
$(document).ready(ready)
$(document).on('page:load', ready)
