// This is a manifest file that'll be compiled into checker.js, which will include all the files
// listed below.
//
//= require jquery.ui.all
//= require checker/app
//= require checker/check
//= require checker/card
//= require checker/navigation
//= require checker/progression
//= require checker/choice

var ready = function() {
  App.launch();
};

$(document).ready(ready);
$(document).on('page:load', ready);
