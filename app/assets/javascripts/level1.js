// This is a manifest file that'll be compiled into checker.js, which will include all the files
// listed below.
//
//= require jquery.ui.slider
//= require polar
//= require_tree ./checker

var ready = function() {
  app = App.get()
  app.launchLevel(1)
};

$(document).ready(ready);
$(document).on('page:load', ready);
