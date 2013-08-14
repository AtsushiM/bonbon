require "cgi"
require "open-uri"
require "nokogiri"

json.array!(@apis) do |api|
  json.extract! api, :name
  json.url api_url(api, format: :json)
  open("https://www.google.co.jp/search?q=#{CGI.escape(api['keyword'])}&tbm=isch&biw=1306&bih=651", 'r') {|f|
    # f.each {|line| p line}
    # json.test f.read
    doc = Nokogiri.HTML f.read, nil, 'utf-8'

    imgs = []
    doc.search('div#search a').each do |link|
      img = link.search('img')
      src = img[0].get_attribute('src')

      imgs << { 'href' => link.get_attribute('href'), 'src' => src }
    end
    json.img imgs
  }
end
