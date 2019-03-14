// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require jquery
//= require cocoon
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function(){
  $(function(){
    if($('.container-fluid').length){
      setTimeout("location.reload()",120000);
    }
  });
  
  $(function(){
    $('.btn_radio').change( function() {
      var nextStatus = $('input[name^="members"]:checked').closest("label");
      $(".btn_radio").closest("label.btn-primary").not(nextStatus).removeClass("btn-primary").addClass("btn-default");
      nextStatus.removeClass("btn-default").addClass("btn-primary");
    });
  });
});