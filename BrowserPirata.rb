require "nokogiri"
require "net/http"

class Page
  def initialize(url)
  	@uri = URI(url)
  	@response = Net::HTTP.get(@uri)
  	@file = Nokogiri::HTML(@response)
  	fetch!
  end

  def fetch!
  	puts "url> #{@uri}"
  	puts "Fetching..."
  	puts "Titulo: #{title}"
  	links
  	puts "Links: "
  	for i in 0...@links.length
	  	puts "\t#{links[i]}: #{@link_href[i]}"
  	end
  end

  def links
  	@links = []
  	@link_href = []
  	nav = @file.search(".nav-item")
  	nav.each do |link|
  		@links << link.search("a").first.inner_text
  		@link_href << link.search("a").first["href"]
  	end
  	@links
  end

  def title
  	@title = @file.search("title").inner_text
  end
end

class Browser
  def run!(url)
  	page = Page.new(url)
  end
end

browser = Browser.new.run!("http://www.codea.mx")
#page = Page.new("http://www.codea.mx")

#p page.fetch!