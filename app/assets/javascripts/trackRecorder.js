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

  function recorderStart() {
    navigator.getUserMedia({audio: true}, function(localMediaStream){
      mediaStream = localMediaStream;
      var mediaStreamSource = context.createMediaStreamSource(localMediaStream);
      playAll();
      rec = new Recorder(mediaStreamSource, {
        workerPath: '../recorderWorker.js'
      });

      rec.record();
    }, function(err){
      console.log('Not supported');
    });
  }

  function recorderStop() {
    mediaStream.stop();
    rec.stop();

    rec.exportWAV(function(e){
      rec.clear();

      var fd = new FormData();
      fd.append('fname', 'test.wav');
      fd.append('data', e);
      fd.append('project_id', gon.project_id);
      $.ajax({
        type: 'POST',
        url: '/tracks',
        data: fd,
        processData: false,
        contentType: false,
        dataType: "script",

        // a custom XHR request, to allow for track upload progress bars
        xhr: function() {
          var xhr = new window.XMLHttpRequest();
          xhr.upload.addEventListener("progress", function(e){
            if (e.lengthComputable) {
              // current progress is set to the page here.
              var percentComplete = (e.loaded / e.total) * 100;
              $('.progress-bar').attr('aria-valuenow', percentComplete);
              $('.progress-bar').css('width', percentComplete + '%');
              $('.progress-text').text(percentComplete);
            }
          }, false);
        return xhr;
        }
      });

    });
  }