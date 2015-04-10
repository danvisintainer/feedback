$(document).ready(function(){

	$("#comments").hide();
	$("#comment-count").click(function(e){
			$("#comments").toggle();
	});

	$("#new_comment").on('submit', function(e){
		$("#comments").show();
	});

});
