// This is a manifest file that'll be compiled into checker.js, which will include all the files
// listed below.
//
//= require jquery.ui.slider
//= require checker/app
//= require checker/navigation
//= require checker/progression
//= require checker/choice
//= require checker/check
//= require checker/models/demographics
//= require checker/models/diet
//= require checker/models/households
//= require checker/models/services
//= require checker/models/density
//= require checker/models/land
//= require checker/models/bm
//= require checker/models/agriculture
//= require checker/models/energy

var ready = function() {
  App.launch();
};

$(document).ready(ready);
$(document).on('page:load', ready);
