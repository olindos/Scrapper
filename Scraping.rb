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
      a = { span.name => {span.text => {type: span.name, selector: "css", class: span['class'],
        identifier: span.css_path }}}
      puts a
    end
  end

  def get_link
    links = perform.css("link")
    links.each do |link|
      a = { link.name => {link['title'] => {type: link['rel'], selector: "css", link: link['href'],
        identifier: link.css_path }}}
      puts a
    end
  end

  def get_select_list
    lists = perform.css("select_list")
    puts lists
  end

  def get_checkbox
    checkboxs = perform.css("checkbox")
    puts checkboxs
  end

  def get_radio
    radios = perform.css("radio")
    puts radios
  end

  def get_div
    divs = perform.css("div")
    divs.each do |div|
      a = { div.name => {div['id'] => {type: div.name, selector: "css", class: div['class'],
        identifier: div.css_path }}}
      puts a
    end
  end

  scraper = Scraper.new
  name = scraper.get_names
  button = scraper.get_button
  span = scraper.get_span
  link = scraper.get_link
  select_list = scraper.get_select_list
  checkbox = scraper.get_checkbox
  radio = scraper.get_radio
  div = scraper.get_div
  
end
