$(document).ready(function() {
  $('#new-user-form').hide();

  $("#login-button").on('click', function(e) {
    $("#global-modal").modal({
      keyboard: true
    });
  });

  $("#new-project-link").on('click', function(e) {
    e.preventDefault();
    $("#new-project-modal").modal({
      keyboard: true
    });
  });

  $("#twitter-log-in-button").on('click', function(e) {
    window.location = '/auth/twitter';
  });

  $("button#switch-to-sign-up-button").on('click', function(e) {
    $('div#log-in-form').hide();
    $('div#new-user-form').fadeIn(500);
  });

  $("#switch-to-log-in-button").on('click', function(e) {
    $('div#new-user-form').hide();
    $('div#log-in-form').fadeIn(500);

  });
});

