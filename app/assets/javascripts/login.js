$(document).ready(function() {
  $('#new-user-form').hide();

  // if the user's browser is Safari, call the warning modal
  if (navigator.userAgent.indexOf('Safari') > -1) {
    if (navigator.userAgent.indexOf('Chrome') > -1) {
      // chrome detected, do nothing
    } else {
      if (!sessionStorage.sawSafariWarning) {
        sessionStorage.setItem("sawSafariWarning", true);
        $("#safari-warning-modal").modal({
          keyboard: true
        });
      } 
    }
  }

  $("#getting-started-btn").on('click', function(e) {
    e.preventDefault();
    $("#getting-started-modal").modal({
      keyboard: true
    });
  });

  $("#login-button").on('click', function(e) {
    e.preventDefault();
    $("#global-modal").modal({
      keyboard: true
    });
  });

  $("#login-link").on('click', function(e) {
    e.preventDefault();
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

  $("#project-login-button").on('click', function(e) {
    e.preventDefault();
    $("#global-modal").modal({
      keyboard: true
    });
  });

  $("#start-new-button").on('click', function(e) {
    e.preventDefault();
    $("#new-project-modal").modal({
      keyboard: true
    });
  });

  $("#twitter-log-in-button").on('click', function(e) {
    window.location = '/auth/twitter';
  });

  $("#soundcloud-log-in-button").on('click', function(e) {
    window.location = '/auth/soundcloud/new';
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

