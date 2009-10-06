xml.instruct! :xml, :version=>"1.0" 
xml.rss(:version=>"2.0", 'xmlns:atom'=>"http://www.w3.org/2005/Atom") do
  xml.channel do
    xml.title "#{AppName}: #{@crowd.title}"
    xml.link request.url.gsub('.xml', '')
    xml.description "Latest items from '#{@crowd.title}'"
    xml.language "en-us"
    @items.each do |url, data|
      xml.item do
        xml.title "#{data[:title]} #{data[:tags]}"
        xml.pubDate  Date.parse(data[:period]).to_time.rfc822
        xml.description do 
          xml.cdata! "<a href=\"#{url}\">#{data[:title]}</a> #{data[:tags]}\n<p>\n"
          data[:feeds].each do |f| 
            xml.cdata! "<a href=\"#{f.feed.home_url}\">#{f.feed.title}</a><br />\n"
          end
          xml.cdata! "</p>"          
        end
        #xml.pubDate item.created_at.rfc2822
        xml.link url
        xml.guid url
      end
    end
  end
end