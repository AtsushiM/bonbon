require "uri"
require "open-uri"
require "nokogiri"

class Api < ActiveRecord::Base
    def self.get_json
        data = []

        self.all.each do |api|
            imgs = []
            open("https://www.google.co.jp/search?q=#{URI.escape(api['keyword'])}&tbm=isch&biw=1306&bih=651", 'r') {|f|
              doc = Nokogiri.HTML f.read, nil, 'utf-8'
              doc.search('div#search a').each do |link|
                img = link.search('img')
                src = img[0].get_attribute('src')

                imgs << { 'href' => link.get_attribute('href'), 'src' => src }
              end
            }

            data << {'keyword' => api.keyword, 'name' => api.name, 'img' => imgs}
        end

        JSON.generate data
    end
end
