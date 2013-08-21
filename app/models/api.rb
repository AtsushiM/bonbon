require "uri"
require "open-uri"
require "nokogiri"
require "json"

class Api < ActiveRecord::Base
  before_save :set_result_json

  def set_result_json
    img = []

    open("https://www.google.co.jp/search?q=#{URI.escape(self.keyword)}&tbm=isch&biw=1306&bih=1306", 'r') do |f|
      file = Nokogiri.HTML(f.read, nil, 'utf-8')
      file.search('div#search a').each do |link|
        img << { 'href' => link.get_attribute('href'), 'src' => link.search('img')[0].get_attribute('src') }
      end
    end

    self.result_json = JSON.generate img
  end
end
