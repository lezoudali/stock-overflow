function MarketData() {
  this.base_url = "http://dev.markitondemand.com/Api/v2";
};

MarketData.prototype.lookup = function(symbol) {
  console.log(this.base_url + "/Lookup/jsonp?callback=myFunction&input=" + symbol)

  $.ajax({
    url: this.base_url + "/Lookup/jsonp?callback=myFunction&input=" + symbol
  });
}