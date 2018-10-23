require 'httparty'
require 'nokogiri'

class Scraper

  def perform
    parsed_content = []
    parsed_tags = ["button", "div", "link", "span"]

    parsed_tags.each do |parsed_tag|
      url = 'https://twitter.com/'
      doc = HTTParty.get(url)
      parse_page ||= Nokogiri::HTML(doc)
      parse_page.css(parsed_tag).each do |tag|
        if parsed_tag == "div"
          parsed_content << { tag.name => {tag['id'] => {type: tag.name, selector: "css", class: tag['class'],
            identifier: tag.css_path }}}
        elsif parsed_tag == "link"
          parsed_content << { tag.name => { tag['title'] => {type: tag['rel'], selector: "css", link: tag['href'],
            identifier: tag.css_path }}}
        elsif parsed_tag == "span"
          parsed_content << { tag.name => {tag.text => {type: tag.name, selector: "css", class: tag['class'],
            identifier: tag.css_path }}}
        else
          parsed_content << { tag.name => {tag.text => {type: tag.name, selector: "css", identifier: tag.css_path }}}
        end
      end
    end
    puts parsed_content
  end

  scraper = Scraper.new
  puts scraper.perform

end
