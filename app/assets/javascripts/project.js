$(document).ready(function(){
	$(".button_to").on('submit', function(e){
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
