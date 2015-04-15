$(document).ready(function(){

	$("#comments").hide();

	$("#comment-count").click(function(e){

		if (!$("#comments").is(":visible")) {
      $("#comments").slideDown();    
    } else {
      $("#comments").slideUp();
    }
	});

	$("#new_comment").on('submit', function(e){
		$("#comments").show();
	});

});
