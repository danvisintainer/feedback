$(document).ready(function() {
  $("#login-button").on('click', function(e) {
    $("#global-modal").modal({
      keyboard: true
    });
  });

  $("#twitter-log-in-button").on('click', function(e) {
    window.location = '/auth/twitter';
  });
});

