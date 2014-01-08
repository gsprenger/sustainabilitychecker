// This is a manifest file that'll be compiled into checker.js, which will include all the files
// listed below.
//
//= require jquery.ui.all
//= require checker2/app
//= require checker2/progression
//= require checker2/navigation
//= require checker2/choice

var ready = function() {
  App.launch();
};

$(document).ready(ready);
$(document).on('page:load', ready);
