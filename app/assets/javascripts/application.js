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
//= require jquery_ujs
//= require Chart.bundle
//= require chartkick
//= require data-confirm-modal
//= require_tree .

$(document).on('turbolinks:load', function(){
  $(function(){
    var ajax_reload = function(){
          var today = new Date();
          var h = today.getHours();
          var last_updated_at = $(".update")[0].id;
          var started_at = 9;
          var expired_at = 21;
          
          if(today.getDay() != 0){
            if(started_at <= h && h < expired_at){
              $.ajax({
                url: "/ajax",
                type: "GET",
              })
              .done(function(response){
                console.log("success");
                if(last_updated_at != response["date"]){
                  location.reload();
                }
              })
              .fail(function(){
                console.log("failed");
              });
            }else if(expired_at <= h){
              $.ajax({
                url: "/ajax",
                type: "GET",
              })
              .done(function(response){
                if(Number(response["date"].substr(8, 2)) < expired_at){
                  $.ajax({
                    url: "/members",
                    type: "PUT",
                    data: {"go_home": "全員帰宅"},
                    dataType: 'json'
                  })
                  .done(function(){
                    location.reload();
                  })
                  .fail(function(){
                    location.reload();
                  });
                }
              })
              .fail(function(){
                console.log("failed!");
              });
            }
          }
          console.log(today);
          setTimeout(function() {ajax_reload()}, 3*1000);
        };

    if($('.container-fluid').length){
      ajax_reload();
    }
  });
  
  $(function(){
    $('.btn_radio').change( function() {
      // var nextStatus = $('input[name^="members"]:checked').closest("label");
      // $(".btn_radio").closest("label").not(nextStatus).not("").removeClass("btn-primary").addClass("btn-default");
      // nextStatus.removeClass("btn-default").addClass("btn-primary");
      $('.fa-circle').remove();
      $('.btn_radio:checked').closest("label").prepend('<i class="fa fa-circle fa-3x"></i>');
    });
  });
});