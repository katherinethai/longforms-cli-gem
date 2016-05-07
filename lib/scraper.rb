require_relative '../config/environment'

class Scraper

  def self.scrape_index_page(page_url)
    doc = Nokogiri::HTML(open(page_url))
    article_array = []

    doc.css(".article").each do |article|
      article_hash = {}

      title = article.css("a[class='h-one article-title']").text.gsub("  ","").gsub("â","'").gsub("\n","")
      url = article.css("a[class='h-one article-title']").attribute("href").value
      description = article.css(".desc").text.gsub("â","'")
      
      details_left = article.css(".article_details .article_details_left").text.gsub("\n","").gsub("  ","").gsub("Author: ","").split("Source: ")
      author = details_left[0]
      source = details_left[1]
      
      details_right = article.css(".article_details .article_details_right").text.gsub("\n","").gsub("Published:  ","").gsub("   ","").split("Length:  ")
      date = details_right[0]
      length = details_right[1]

      article_hash[:title] = title
      article_hash[:url] = url
      article_hash[:description] = description
      article_hash[:author] = author
      article_hash[:source] = source
      article_hash[:date] = date
      article_hash[:length]= length

      article_array << article_hash
    end
  article_array
  end

end

Scraper.scrape_index_page("http://longreads.com/picks/?page=4")