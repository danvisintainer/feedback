$('.progress-bar').each(function(i) {
  $(this).appear(function() {
    var percent = $(this).attr('aria-valuenow');
    $(this).animate({'width' : percent + '%'});
    $(this).find('span').animate({'opacity' : 1}, 900);
    $(this).find('span').countTo({from: 0, to: percent, speed: 900, refreshInterval: 30});
  });
});

$('.count-item').each(function(i) {
  $(this).appear(function() {
    var number = $(this).find('.count-to').data('countto');
    $(this).find('.count-to').countTo({from: 0, to: number, speed: 1200, refreshInterval: 30});
  });
});