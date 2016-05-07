require_relative '../config/environment'

class Article
  attr_accessor :title, :url, :description, :author, :source, :date

  @@all = []

  def initialize(article_hash)
    article_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(articles_array)
    articles_array.each do |article_hash|
      Article.new(article_hash)
    end
  end

  def self.all
    @@all
  end

  def self.reset
    @all.clear
  end

end