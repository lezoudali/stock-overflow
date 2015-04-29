require "open-uri"
require "uri"
require "json"

class MarketData
  BASE_URL = "http://dev.markitondemand.com/Api/v2"

  def self.lookup(symbol)
    JSON.load(open("#{BASE_URL}/Lookup/json?input=#{symbol}"))
  end

  def self.quote(symbol)
    JSON.load(open("#{BASE_URL}/Quote/json?symbol=#{symbol}"))
  end

  def self.chart(symbol, num_days=365)
    parameters = {
      "Normalized": false,
      "NumberOfDays": num_days,
      "DataPeriod": "Day",
      "Elements": [{
        "Symbol": symbol,
        "Type": "price",
        "Params": ["c"]
      }]
    }
    formatted_params = formatter(URI.encode(parameters.to_json))
    begin
      JSON.load(open("#{BASE_URL}/InteractiveChart/json?parameters=#{formatted_params}"))
    rescue
      retry
    end
  end

  private

  def self.formatter(string)
    substitutions = /,|\[|\]|:|{|}/
    string.gsub(substitutions,
      "," => "%2C",
      "[" => "%5B",
      "]" => "%5D",
      ":" => "%3A",
      "{" => "%7B",
      "}" => "%7D"
    )
  end
end