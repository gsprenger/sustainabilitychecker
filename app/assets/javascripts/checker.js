// This is a manifest file that'll be compiled into checker.js, which will include all the files
// listed below.
//
//= require jquery.ui.slider
//= require jquery.ui.effect-highlight
//= require polar
//= require_tree ./checker

var ready = function() {
  App.get().launchApp()
};

$(document).ready(ready);
$(document).on('page:load', ready);
