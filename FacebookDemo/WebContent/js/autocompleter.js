$(document).ready(function() {
	$(function() {
		$("#search").autocomplete({
		source : function(request, response) {
			$.ajax({
				url : "searchAction",
				type : "POST",
				data : {
					term : request.term
				},
				dataType : "json",
				success : function(jsonResponse) {
					response(jsonResponse.list);
				}
			});
			}
		});
	});
});
