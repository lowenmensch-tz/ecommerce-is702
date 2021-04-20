$(document).ready(function(){

	$(".search-results").css("display", "none")
			$("body").on("click", function(){
				$(".search-results").css("display", "none")
			})

			if($('[data-toggle="tooltip"]').length>0) {  // check if element exists
				$('[data-toggle="tooltip"]').tooltip()
			} 

			$(".search input").on("keyup", function(e){
				
				value = $(".search input").val();

				$(".search-results").css("display", "block")
				$.ajax({
					url:`/ajax/search?query=${value.toLowerCase()}`
				}).done(function(data){
					
					showResults(data)

				})

	})

	function showResults(data){
		var output = "";

		console.log( data );

		/*
			data = 
			[ {"id":element_a, "title":element_b, "photo":element_c, "price":element_d,  "category":element_e}, ... ]
		*/

		if(data.length === 0 ){
		
			output = "No Results Found";
			$(".search-results .container").html(output);

		}

		else{
		
			for (let index = 0; index < data.length; index++) {
				output += `
						<div class="row">
							<div class="col p-2 ml-3">
								<a href="/products/${data[index]["category"]}/${data[index]["id"]}">${data[index]["title"]}</a>
							</div>
						</div>
						`;

			$(".search-results").html(output);

			}
		}
	} // end function

}); 
