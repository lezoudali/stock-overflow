require 'open-uri'
module Findable
  def times_base_uri
    "http://api.nytimes.com/svc/search/v2/articlesearch"
  end

  def find_articles

    headlines_doc = Nokogiri::HTML(open("http://finance.yahoo.com/q/h?s=#{symbol}+HEADLINES"))
    headlines_doc.search("#yfncsumtab li").collect do |article|  
      {
        "snippet" => article.search("a").first.text,
        "web_url" => article.children.first.attribute("href").value.split("*").last,
        "journal" => article.children.last.text

      }    
    end

  end
end