$(document).ready(function(){

  $("#recorderStart").on('click', function(e) {
    recorderStart();
    e.stopPropagation();
  });

  $("#recorderStop").on('click', function(e) {
    recorderStop();
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
    currentDiv = $(this).children().last();
    music = currentDiv.find(".music")[0];
    pButton = currentDiv.find(".play")[0];

    var timeline = currentDiv.find('.timeline')[0]; // timeline
    // timeline width adjusted for playhead
    var playhead = currentDiv.find('.playhead')[0]; // playhead
    var timelineWidth = timeline.offsetWidth - playhead.offsetWidth;
    var duration;
    
    music.addEventListener("canplaythrough", function () {
      duration = music.duration;  
    }, false);
    music.addEventListener("timeupdate", timeUpdate(music, pButton, timelineWidth, duration, playhead), false);
  });

});

function playAll() {
  $.each($('.play'), function(i, v) {
    v.click();
  });

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

// Update music scrubber position as the song plays
function timeUpdate(music, pButton, timelineWidth, duration, playhead) {
  var playPercent = timelineWidth * (music.currentTime / duration);
  playhead.style.marginLeft = playPercent + "px";
  if (music.currentTime == duration) {
    pButton.className = "";
    pButton.className = "play";
  }
}

// timeupdate event listener
// music.addEventListener("timeupdate", timeUpdate, false);

// Gets audio file duration
// music.addEventListener("canplaythrough", function () {
//   duration = music.duration;  
// }, false);

  // var music = document.getElementById('music'); // id for audio element
  // var duration; // Duration of audio clip
  // var pButton = document.getElementById('pButton'); // play button

  // var playhead = document.getElementById('playhead'); // playhead





  // //Makes timeline clickable
  // timeline.addEventListener("click", function (event) {
  //   moveplayhead(event);
  //   music.currentTime = duration * clickPercent(event);
  // }, false);

  // // returns click as decimal (.77) of the total timelineWidth
  // function clickPercent(e) {
  //   return (e.pageX - timeline.offsetLeft) / timelineWidth;
  // }

  // // Makes playhead draggable 
  // playhead.addEventListener('mousedown', mouseDown, false);
  // window.addEventListener('mouseup', mouseUp, false);

  // // Boolean value so that mouse is moved on mouseUp only when the playhead is released 
  // var onplayhead = false;
  // // mouseDown EventListener
  // function mouseDown() {
  //   onplayhead = true;
  //   window.addEventListener('mousemove', moveplayhead, true);
  //   music.removeEventListener('timeupdate', timeUpdate, false);
  // }
  // // mouseUp EventListener
  // // getting input from all mouse clicks
  // function mouseUp(e) {
  //   if (onplayhead == true) {
  //     moveplayhead(e);
  //     window.removeEventListener('mousemove', moveplayhead, true);
  //     // change current time
  //     music.currentTime = duration * clickPercent(e);
  //     music.addEventListener('timeupdate', timeUpdate, false);
  //   }
  //   onplayhead = false;
  // }
  // // mousemove EventListener
  // // Moves playhead as user drags
  // function moveplayhead(e) {
  //   var newMargLeft = e.pageX - timeline.offsetLeft;
  //   if (newMargLeft >= 0 && newMargLeft <= timelineWidth) {
  //     playhead.style.marginLeft = newMargLeft + "px";
  //   }
  //   if (newMargLeft < 0) {
  //     playhead.style.marginLeft = "0px";
  //   }
  //   if (newMargLeft > timelineWidth) {
  //     playhead.style.marginLeft = timelineWidth + "px";
  //   }
  // }


  // //Play and Pause
  // function play() {
  //   // start music
  //   if (music.paused) {
  //     music.play();
  //     // remove play, add pause
  //     pButton.className = "";
  //     pButton.className = "pause";
  //   } else { // pause music
  //     music.pause();
  //     // remove pause, add play
  //     pButton.className = "";
  //     pButton.className = "play";
  //   }
  // }

