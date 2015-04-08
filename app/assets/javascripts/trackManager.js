$(document).ready(function(){

  // make Microphone visualizer
  showMicVisualizer();

  // make wavesurfers on page load
  $("div[id^=waveform-]").each(function(i, v) {
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
    $(this).text("Stop");
    $(this).attr('id', 'recorderStop');
    e.stopPropagation();
  });

  $("#controls").on('click', '#recorderStop', function(e) {
    recorderStop();
    $(this).text("Record");
    $(this).attr('id', 'recorderStart');
    e.stopPropagation();
  });

  $("#playAll").on('click', function(e) {
    playAll();
    e.stopPropagation();
  });



});

function makeWavesurfer(div) {
  var wavesurfer = Object.create(WaveSurfer);

  // debugger;
  wavesurfer.init({
    container: "#" + div.attr("id"),
    waveColor: 'gray',
    progressColor: 'black'
  });

  wavesurfer.load(div.attr("audio-source"));

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

  div.append($('<button/>', {
    text: "Play / Pause",
    click: function () { wavesurfer.playPause(); }
  }));

  div.append($('<button/>', {
    text: "Stop",
    click: function () { wavesurfer.stop(); }
  }));

  $(div).find("button").first().addClass("play");
  $(div).find("button").last().addClass("stop")

}

// Play and Pause
function play(music, pButton) {
  // start music
  if (music.paused) {
    music.play();
    // remove play, add pause
    pButton.className = "";
    pButton.className = "pause";
  } else { // pause music
    music.pause();
    // remove pause, add play
    pButton.className = "";
    pButton.className = "play";
  }
}

function playAll() {
  $.each($('.stop'), function(i, v) {
    v.click();
  });

  $.each($('.play'), function(i, v) {
    v.click();
  });
}

function givePlayersListeners() {
  $("div[id^=audio-and-player]").each(function(i, v) {
    currentDiv = $(this);
    music = currentDiv.find(".music")[0];
    pButton = currentDiv.find(".play")[0];

    var timeline = currentDiv.find('.timeline')[0]; // timeline
    // timeline width adjusted for playhead
    var playhead = currentDiv.find('.playhead')[0]; // playhead
    var timelineWidth = timeline.offsetWidth - playhead.offsetWidth;

    dynamicallyCreateEventListener(music, pButton, timeline, playhead, timelineWidth);
  });
}

function showMicVisualizer() {
  var wavesurfer = Object.create(WaveSurfer);

  wavesurfer.init({
    container     : '#mic-visualizer',
    waveColor     : 'black',
    interact      : false,
    cursorWidth   : 0,
    pixelRatio    : 1
  });

  var microphone = Object.create(WaveSurfer.Microphone);

  microphone.init({
      wavesurfer: wavesurfer
  });
  
  
  microphone.start();
}