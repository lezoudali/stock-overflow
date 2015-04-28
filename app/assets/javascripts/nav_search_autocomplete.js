$(function(){ 
  $( "#stock-search" ).keyup(function( event, ui ) {
    $("#result-dropdown ul").empty();
    
    $.ajax({
        url: "/search/query",
        method: "GET",
        data: { query: this.value}
    })

     .done(function(data) {
      $.each(data, function(i,stock){
        $("<li>" + stock.company + "</li>").appendTo("#result-dropdown ul");
      })
     })
  });}
);