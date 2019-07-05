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
//= require jquery
//= require activestorage
//= require turbolinks
//= require semantic-ui
//= require toastr
//= require autosize
//= require_tree .

scroll_bottom = function() {
  if ($('#messages').length > 0 ) {
     $('#messages').scrollTop($('#messages')[0].scrollHeight);
  }
}

submit_message = function() {
  $('textarea').on('keydown', function(e) {
    if (e.keyCode == 13 && e.shiftKey ) {
      $('textarea').val($('#message_body').val() + "\n")
      autosize($('textarea'));
      e.preventDefault()
    }
    else if (e.keyCode == 13) {
      $("button").click()
      e.preventDefault()
      $("textarea").val('')
      return false
    }
  })
}


// submit = $(function() {
//   $('#message_body').on('ajax:success', function(a, b,c ) {
//     $(this).find('input[type="text"]').val('');
//   });
// });


$(document).on('turbolinks:load', function() {
  $('.ui.dropdown').dropdown();
  submit_message();
  scroll_bottom();


})
