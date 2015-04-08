$(document).ready(function(){

  // add event listener to all players
  givePlayersListeners();

  showMicVisualizer();

  // delete tracks by ID from track button
  $("#all-tracks").on('click', '.track-delete-btn', function(e) {
    e.preventDefault();
    id = $(this).attr("id");

    $.ajax({
      type: 'delete',
      url: '/tracks/' + id
      // data: {id: id}
    });
  });

  $("#controls").on('click', '#recorderStart', function(e) {
    recorderStart();
    playAll();
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

  $("#all-tracks").on('click', '.play', function(e){
    var music = $(this).parent().parent().find(".music")[0];
    play(music, this);

    e.stopPropagation();
  });

  $("#all-tracks").on('click', '.pause', function(e){
    var music = $(this).parent().parent().find(".music")[0];
    play(music, this);

    e.stopPropagation();
  });

  $("#dataTable tbody").on( "click", "tr", function() {
    debugger;
  });

  $('#all-tracks').on('DOMNodeInserted', function(e){
    // debugger;
    console.log("Creating new player.");
    currentDiv = $(this).children().last();
    music = currentDiv.find(".music")[0];
    pButton = currentDiv.find(".play")[0];

    var timeline = currentDiv.find('.timeline')[0]; // timeline
    // timeline width adjusted for playhead
    var playhead = currentDiv.find('.playhead')[0]; // playhead
    var timelineWidth = timeline.offsetWidth - playhead.offsetWidth;

    dynamicallyCreateEventListener(music, pButton, timeline, playhead, timelineWidth);
    // var duration;
    
    // music.addEventListener("canplaythrough", function () {
    //   duration = music.duration;
    //   // console.log("duration is " + duration) ; 
    // }, false);

    
  });

});

function playAll() {
  $.each($('.play'), function(i, v) {
    v.click();
  });
}

function dynamicallyCreateEventListener(music, pButton, timeline, playhead, timelineWidth){
  music.addEventListener("timeupdate", function() {
      var playPercent = timelineWidth * (music.currentTime / music.duration);
      playhead.style.marginLeft = playPercent + "px";
      // console.log("Checking with timeUpdate()");
      console.log("Checking if " + music.currentTime + " = " + music.duration);
      if (music.currentTime === music.duration) {
        pButton.className = "";
        pButton.className = "play";
        console.log("Song finished!");
      }
    }, false);
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