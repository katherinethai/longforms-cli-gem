require_relative '../config/environment'

class CLI 

  def make_articles
    articles_array = Scraper.scrape_index_page
    Article.create_from_collection(articles_array)
  end

  # def display_articles
  #   Student.all.each do |student|
  #   puts "#{student.name.upcase}".colorize(:blue)
  #   puts "  location:".colorize(:light_blue) + " #{student.location}"
  #   puts "  profile quote:".colorize(:light_blue) + " #{student.profile_quote}"
  #   puts "  bio:".colorize(:light_blue) + " #{student.bio}"
  #   puts "  twitter:".colorize(:light_blue) + " #{student.twitter}"
  #   puts "  linkedin:".colorize(:light_blue) + " #{student.linkedin}"
  #   puts "  github:".colorize(:light_blue) + " #{student.github}"
  #   puts "  blog:".colorize(:light_blue) + " #{student.blog}"
  #   puts "----------------------".colorize(:green)
  #   end
  end

end