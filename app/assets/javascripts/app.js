// This is a manifest file that'll be compiled into app.js, which will include all the files
// listed below.
//
//= require jquery.ui.slider
//= require jquery.ui.effect
//= require polar
//= require_tree ./app

var ready = function() {
  App.get().launchApp()
};

$(document).ready(ready);
$(document).on('page:load', ready);
