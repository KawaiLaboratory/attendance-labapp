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
//= require_tree .

$(document).on('turbolinks:load', function(){
  $(function(){
    var today = new Date();
    var started_at = 9;
    var expired_at = 21;

    if($('.container-fluid').length && today.getDay() != 0){
      var last_updated_at = $(".update")[0].id;
      if(today.getHours() >= started_at && today.getHours() < expired_at){
        setInterval(function(){
          $.ajax({
            url: "/ajax",
            type: "GET",
          })
          .done(function(response){
            if(last_updated_at != response["date"]){
              location.reload();
            }
          })
          .fail(function(){
            location.reload();
          });
        },3*1000); // 3秒
      }else if(today.getHours() >= expired_at){
        var labels = $(".fa-circle").closest("label")
        if(labels.hasClass("btn-warning") || labels.hasClass("btn-info") || labels.hasClass("btn-danger")){
          $.ajax({
            url: "/members",
            type: "PUT",
            data: {"go_home": "全員帰宅"},
            dataType: 'json'
          })
          .done(function(response){
            location.reload();
          })
          .fail(function(){
            location.reload(); //たまにバグってそう
          });
        }
      }
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