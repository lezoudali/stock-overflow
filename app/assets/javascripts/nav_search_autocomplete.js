$(function(){ 
  $( "#stock-search" ).keyup(function( event, ui ) {
    $("#result-dropdown ul").empty();
    if(this.value.length > 0) {
      $.ajax({
        url: "/search/query",
        method: "GET",
        data: { query: this.value}
      }).done(function(data) {
        $.each(data, function(i,stock){
          stockAsLink = "<a href='/stocks/" + 
                        stock.symbol + 
                        "'><li>" + 
                        stock.company + 
                        " (" + stock.symbol + ")</li></a>"
          $(stockAsLink).appendTo("#result-dropdown ul");
        });
      });
    }
  });
});