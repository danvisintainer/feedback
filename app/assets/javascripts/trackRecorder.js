var navigator = window.navigator;
  var Context = window.AudioContext || window.webkitAudioContext;
  var context = new Context();
  
  // audio
  var mediaStream;
  var rec;

  navigator.getUserMedia = (
    navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia
  );

  function record() {
    navigator.getUserMedia({audio: true}, function(localMediaStream){
      mediaStream = localMediaStream;
      var mediaStreamSource = context.createMediaStreamSource(localMediaStream);
      rec = new Recorder(mediaStreamSource, {
        workerPath: 'recorderWorker.js'
      });

      rec.record();
    }, function(err){
      console.log('Not supported');
    });
  }

  function stop() {
    mediaStream.stop();
    rec.stop();

    rec.exportWAV(function(e){
      rec.clear();

      var fd = new FormData();
      fd.append('fname', 'test.wav');
      fd.append('data', e);
      $.ajax({
          type: 'POST',
          url: '/tracks',
          data: fd,
          processData: false,
          contentType: false,
          success: function(response){
            $("body").append(response)
          }

      });

    });
  }