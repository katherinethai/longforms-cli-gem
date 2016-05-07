require_relative '../config/environment'
require 'colorize'

class CLI

  def call
    puts "Welcome to the longform browsing Ruby Gem CLI!"
    puts ""
    run
  end

  def run
    @page_num = 1
    make_articles
    display_articles
    menu
  end 

  def make_articles(page_url = "https://longreads.com/picks")
    articles_array = Scraper.scrape_index_page(page_url)
    Article.create_from_collection(articles_array)
    articles_array.uniq!
  end

  def display_articles(from_number = 1)
    Article.all[from_number-1, 10].each.with_index(from_number) do |article, index| 
    puts "#{index}. #{article.title}\n".colorize(:blue)
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
  end

  def menu
    display_instructions(@page_num)
    input = gets.chomp
    if input.downcase == "next" 
      @page_num += 1
      make_articles(page_url(@page_num))
      display_articles((@page_num*10)-9)
      display_instructions(@page_num)
    elsif input.downcase == "back" && @page_num != 1
      @page_num -= 1
      display_articles((@page_num*10)-9)
      display_instructions(@page_num)
    elsif input.downcase == "back" && @page_num == 1
      puts "Sorry! You're already on the first page of articles.".colorize(:red)
      puts ""
      display_instructions(@page_num)
    elsif (1..1000).include?(input.to_i)
      display_article_details(input.to_i - 1)
      puts "Would you like to view another article? Enter Y or N."
      input = gets.chomp.downcase
      if input == "y"
        run
      else
        quit
      end
    elsif input == "exit"
      quit
    else
      menu
    end
  end

  def quit
    puts ""
    puts "Thank you for reading today!"
    exit
  end

  def display_instructions(page_num)
    puts "You are on page #{page_num}. Type 'next' or 'back' to navigate between pages. Type the number of an article to view its details."
    puts ""
  end

  def page_url(page_num)
    "https://longreads.com/picks" + "/?page=#{page_num}"
  end

end