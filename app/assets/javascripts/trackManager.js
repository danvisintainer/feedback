$(document).ready(function(){

  //make Soundcloud Upload Listener
  $('.soundcloud-upload-form').on('click', function(e)
      {
      e.preventDefault();
      e.stopPropagation();
      var form = $(this);
      $.ajax({
        url: form.attr('action'),
        method: 'post',
        data: {id: form.children('.upload-track').val()},
        dataType: 'script'
        });
      });

  // make Microphone visualizer
  showMicVisualizer();

  // make wavesurfers on page load
  $("div[id^=wavesurfer-set-]").each(function(i, v) {
    // debugger;
    makeWavesurfer($(this));
  });

  // make wavesurfers on recording add
  $('#all-tracks').on('DOMNodeInserted', function(e){
    // debugger;
    makeWavesurfer($(e.target));
  });

  $("#controls").on('click', '#recorderStart', function(e) {
    recorderStart();
    // playAll();
    $(this).text(" Stop ");
    $(this).attr('id', 'recorderStop');
    $(this).prepend('<i class="fa fa-stop"></i>');
    e.stopPropagation();
  });

  $("#controls").on('click', '#recorderStop', function(e) {
    recorderStop();
    $(this).text(" Record");
    $(this).attr('id', 'recorderStart');
    $(this).prepend('<i class="fa fa-circle"></i>');
    e.stopPropagation();
  });

  $("#all-tracks").on('click', '.track-delete-btn', function(e) {
    e.preventDefault();
    id = $(this).attr("id");

    $.ajax({
      type: 'delete',
      url: '/tracks/' + id
      // data: {id: id}
    });
  });

  $("#playAll").on('click', function(e) {
    playAll();
    e.stopPropagation();
  });

});

function makeWavesurfer(div) {
  var wavesurfer = Object.create(WaveSurfer);
  var container = div.children().find(".wavesurfer-insert")[0];

  wavesurfer.init({
    container: container,
    waveColor: 'gray',
    progressColor: 'black'
  });

  wavesurfer.load(div.children().find(".wavesurfer-insert").attr('audio-source'));
  
  console.log("Seeking to beginning");


  if (wavesurfer.enableDragSelection) {
        wavesurfer.enableDragSelection({
            color: 'rgba(0, 255, 0, 0.1)'
        });
    }


  document.addEventListener('DOMContentLoaded', function () {
    var progressDiv = document.querySelector('#progress-bar');
    var progressBar = progressDiv.querySelector('.progress-bar');

    var showProgress = function (percent) {
        progressDiv.style.display = 'block';
        progressBar.style.width = percent + '%';
    };

    var hideProgress = function () {
        progressDiv.style.display = 'none';
    };

    wavesurfer.on('loading', showProgress);
    wavesurfer.on('ready', hideProgress);
    wavesurfer.on('destroy', hideProgress);
    wavesurfer.on('error', hideProgress);
  });

  div.children().find('.left-col').append($('<button/>', {
    click: function () { 
      wavesurfer.seekTo(0);
      wavesurfer.playPause(); }
  }));

  div.children().find('.left-col').append($('<button/>', {
    click: function () { wavesurfer.stop(); }
  }));

  $(div).find("button").first().addClass("btn btn-border-d btn-round play");
  $(div).find("button").first().append('<i class="fa fa-play">');
  
  $(div).find("button").last().addClass("btn btn-border-d btn-round stop");
  $(div).find("button").last().append('<i class="fa fa-stop">');


}

function playAll() {

    $.each($('.stop'), function(i, v) {
      v.click();
    });



    $.each($('.play'), function(i, v) {
      v.click();
    });
  
}

function showMicVisualizer() {
  var wavesurfer = Object.create(WaveSurfer);

  wavesurfer.init({
    container     : '#mic-visualizer',
    waveColor     : 'black',
    interact      : false,
    cursorWidth   : 0,
    pixelRatio    : 0.8
  });

  var microphone = Object.create(WaveSurfer.Microphone);

  microphone.init({
      wavesurfer: wavesurfer
  });
  
  
  microphone.start();
}

