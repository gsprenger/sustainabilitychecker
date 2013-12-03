// This is a manifest file that'll be compiled into checker.js, which will include all the files
// listed below.
//
//= require checker/app
//= require checker/card
//= require checker/navigation
//= require checker/progression

var ready = function() {
  var app = new App();
  app.launch();
};

$(document).ready(ready);
$(document).on('page:load', ready);
