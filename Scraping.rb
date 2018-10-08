require 'httparty'
require 'nokogiri'

class Scraper

attr_accessor :parse_page
  
  def perform
    url = 'https://twitter.com/'
    doc = HTTParty.get(url)
    @parse_page ||= Nokogiri::HTML(doc)
  end

  def get_names
    names = perform.css("title")
    names.each do |name|
      a = { name.name => {name.text => {type: name.name, selector: "css", identifier: name.css_path }}}
      puts a
    end
  end

  def get_button
    buttons = perform.css("button")
    buttons.each do |button|
      a = { button.name => {button.text => {type: button.name, selector: "css", identifier: button.css_path }}}
      puts a
    end
  end

  def get_span
    spans = perform.css("span")
    spans.each do |span|
      a = { span.name => {span.text => {type: span.name, selector: "css", identifier: span.css_path }}}
      puts a
    end
  end

  def get_link
    links = perform.css("link")
    links.each do |link|
      a = { link.name => {link.text => {type: link.name, selector: "css", identifier: link.css_path }}}
      puts a
    end
  end

  def get_select_list
    perform.css("select_list")
  end

  def get_checkbox
    perform.css("checkbox")
  end

  def get_radio
    perform.css("radio")
  end

  def get_div
    perform.css("div")
  end

  scraper = Scraper.new
  name = scraper.get_names
  button = scraper.get_button
  span = scraper.get_span
  link = scraper.get_link

end
