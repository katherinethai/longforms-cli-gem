require_relative '../config/environment'
require 'colorize'

class CLI

  def call
    puts "Welcome to the longform browsing Ruby Gem CLI!"
    puts ""
    run
  end

  def run
    @active = true
    while @active
      menu 
    end
  end 

  def make_articles(page_url = "https://longreads.com/picks")
    Article.all.clear
    articles_array = Scraper.scrape_index_page(page_url)
    Article.create_from_collection(articles_array)
  end

  def display_articles
    Article.all.each_with_index do |article, index|
    puts "#{index + 1}. #{article.title}".colorize(:blue)
    puts "#{article.description}"
    puts "----------------------".colorize(:green)
    end
    menu
  end

  def display_article_details(index)
    puts "----------------------".colorize(:green)
    puts "#{Article.all[index].title}".colorize(:blue)
    puts "  Description:".colorize(:light_blue) + " #{Article.all[index].description}"
    puts "  Author(s):".colorize(:light_blue) + " #{Article.all[index].author}"
    puts "  Source:".colorize(:light_blue) + " #{Article.all[index].source}"
    puts "  Published:".colorize(:light_blue) + " #{Article.all[index].date}"
    puts "  Length:".colorize(:light_blue) + " #{Article.all[index].length}"
    puts ""
    puts "  Link:".colorize(:light_blue) + " #{Article.all[index].url}"
    puts "----------------------".colorize(:green)
    menu
  end

  def menu
    puts "Type \"Search\" to select a page of articles, the number of an article to view its details, or \"exit\" to leave the CLI."
    input = gets.chomp
    if input.downcase == "search"
      puts "Please enter the page number you would like to view."
      page_num = gets.chomp.to_i
      make_articles(page_url(page_num))
      display_articles
    elsif (1..10).include?(input.to_i)
      display_article_details(input.to_i - 1)
    elsif input == "exit"
      puts "Thank you for reading today!"
      @active = false
    else
      menu
    end
  end

  def page_url(page_num)
    "https://longreads.com/picks" + "/?page=#{page_num}"
  end

end