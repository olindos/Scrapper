require 'httparty'
require 'nokogiri'

class Scraper

  def perform (parsed_tag)
    parsed_content = []
    url = 'https://twitter.com/'
    doc = HTTParty.get(url)
    Nokogiri::HTML(doc).css(parsed_tag).each do |tag|
      parsed_content << { tag.name => {tag['id'] => {type: tag.name, selector: "css", class: tag['class'],
            identifier: tag.css_path }}}
    end
  end

  scraper = Scraper.new
  puts scraper.perform('div')
  puts scraper.perform('li')

end
