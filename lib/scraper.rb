require_relative '../config/environment'

class Scraper

  def self.scrape_index_page
    doc = Nokogiri::HTML(open("https://longreads.com/"))
    article_array = []

    doc.css(".article").each do |article|
      article_hash = {}


      title = article.css("a[class='h-one article-title']").text.gsub("  ","").gsub("â","'")
      url = article.css("a[class='h-one article-title']").attribute("href").value
      description = article.css(".desc").text.gsub("â","'")
      author = article.css("span.authors-container").first.text.gsub("\n","").gsub("  ","")
      source = article.css(".article_details_left div.detail")[1].text.gsub("Source: ", "")
      date = article.css(".article_details_right div.detail")[0].text.gsub("Published: ", "").gsub("\n","")

      article_hash[:title] = title
      article_hash[:url] = url
      article_hash[:description] = description
      article_hash[:author] = author
      article_hash[:source] = source
      article_hash[:date] = date

      article_array << article_hash
    end
  end

end
