// This is a manifest file that'll be compiled into checker.js, which will include all the files
// listed below.
//
//= require jquery.ui.slider
//= require_tree ./level1

var ready = function() {
  app = new AppController('level1')
};

$(document).ready(ready);
$(document).on('page:load', ready);
