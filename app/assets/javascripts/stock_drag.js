$(function(){
  var draggedFromStocks;

  $("#favorite-stocks").sortable({
    axis: "y"
  });

  $("#stock-list li").draggable({
    axis: "y",
    connectToSortable: "#favorite-stocks"
  });

  $( "#stock-list li" ).on( "dragstart", function( event, ui ) {
    draggedFromStocks = true;
  });

  $("#favorite-stocks").on( "sortreceive", function( event, ui ) {
    if(draggedFromStocks) {
      $("#favorite-stocks li").last().remove();
    }
    draggedFromStocks = false;
  });
});