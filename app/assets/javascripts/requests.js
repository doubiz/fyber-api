$( document ).ready(function() {
	$("#request-form").on("submit", function(){
		$("#submit").attr("disabled" , true);
		$("#loading").fadeIn();
	})
});
