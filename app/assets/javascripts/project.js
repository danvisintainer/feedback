
$(document).ready(function(){

	if (gon.project_completed === true){
		$("#recorderStart").hide();
		$("#instrument-need-checkbox").hide();
	}
	$("#collab-btn").on('submit', function(e){
		e.preventDefault();
		var url = $(this).attr("action");
		var data = $(this).children().last().val();

		$.ajax({
			type: 'PATCH',
			dataType: "script",
			url: url,
			data: {completed: data}
		});
	});
});
