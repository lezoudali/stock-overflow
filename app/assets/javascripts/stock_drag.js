$(function(){
  if(window.location.pathname == "/") {
    ids = $("#favorite-stocks li").map(function(i, element, arr) {
      return element.dataset.id
    }).toArray();

    $.ajax({
      url: "/favorites/price_history",
      method: "POST",
      data: {ids: ids},
    }).done(function(data){
      renderChart(data);
    });
  } 
  else if(window.location.pathname.match(/\/stocks\/\w+/)) {
    symbol = window.location.pathname.match(/\/stocks\/(\w+)/)[1]
    $.ajax({
      url: "/stocks/" + symbol + "/series_data",
      method: "GET",
      data: {},
    }).done(function(data){
      new Highcharts.StockChart({
        chart: { renderTo: 'orders_chart' },
        rangeSelector: {
          selected: 4
        },
        title: { text: symbol },
        xAxis: { 
          type: 'datetime'
        },
        yAxis: {
          title: { text: 'Stock Price'}
        },
        series: data
      });
    });
  }

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
      renderLoader();

      if($("#favorite-stocks").children().length == 6) {
        $("#favorite-stocks li").last().appendTo("#stock-list");
      }

      ids = $("#favorite-stocks li").map(function(i, element, arr) {
        return element.dataset.id
      }).toArray();

      $.ajax({
        url: "/favorites/update",
        method: "POST",
        data: { ids: ids},
        dataType: "json"
      });

      // Should return quote data for favorite stocks
      $.ajax({
        url: "/favorites/quote_data",
        method: "POST",
        data: {ids: ids},
      }).done(function(html){
        renderFavoritesTable(html);
      });


      // Should return price history for favorite stocks
      $.ajax({
        url: "/favorites/price_history",
        method: "POST",
        data: {ids: ids},
      }).done(function(data){
        renderChart(data);
      });
    }

    draggedFromStocks = false;
  });

  var renderChart = function(data) {
    new Highcharts.StockChart({
      chart: { renderTo: 'orders_chart' },
      rangeSelector: {
        selected: 4
      },
      title: { text: "Stock Trends" },
      xAxis: { 
        type: 'datetime'
      },
      yAxis: {
        title: { text: 'Stock Price'}
      },
      series: data
    });
  };

  var renderFavoritesTable = function(html) {
    $("#favorites-table").html(html)
  };

  var renderLoader = function() {
    $('#orders_chart').html(
      '<div class="spin-container">' +
        '<div class="spinner windcatcher" id="windcatcher">' +
          '<div class="blade"></div>' +
          '<div class="blade"></div>' +
          '<div class="blade"></div>' +
          '<div class="blade"></div>' +
          '<div class="blade"></div>' +
          '<div class="blade"></div>' +
          '<div class="blade"></div>' +
          '<div class="blade"></div>' +
        '</div>' +
      '</div>'
    )
  };
});