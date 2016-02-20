// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap
//= require ckeditor/init
//= require jquery_ujs
//= require turbolinks
//= require_tree .


var ready;

ready = function() {

    $('.dropdown-toggle').dropdown();

    setTimeout(function(){
        $('.alert').fadeOut('slow', function(){
            //$(this).remove();
        });
    }, 3500);
};

$(document).ready(ready);
$(document).on('page:load', ready);
$(document).on('page:update', ready);