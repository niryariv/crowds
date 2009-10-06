#require 'feedtools'

# Here lay the site-specific parsers. 
# Each gets raw content (html/rss/etc) and returns an array of found links

module Parsers
  
  def parse_digg(html)
    html[/<body.*<\/body>/m].scan(/news-body.*href=\"(http.*?)\"/)
  end
  
  # def parse_reddit(rss)
  #   rss[/<channel.*/m].scan(/<description>.*href=\"(.*)\".*\[link\].*<\/description>/)
  # end
  # 
  # def parse_delicious(rss)
  #   rss[/<channel.*/m].scan(/<link>(.*)<\/link>/)
  # end

  def parse_slashdot(html)
    html[/<body.*<\/body>/m].scan(/class=\"intro\".*?href=\"(http.+?)\".+?<\/div>/m)
  end

  def parse_technorati(html)
    html[/<body.*<\/body>/m].scan(/class=\"content\".*?href=\"(http.*?)\".+?<\/h3>/m)
  end
  
  def parse_bloglines_top_links(rss)
    rss[/<channel.*/m].scan(/<a.*href=\"(http.*?)\"/).delete_if { |u| u.to_s.include? "bloglines" }
  end
  
  def parse_plain(content)
    c = content[/<item.*/m]   #if c.nil?
    c = content[/<entry.*/m]  if c.nil?
    c = content[/<body.*/m]   if c.nil?
    c = content if c.nil? 
    c.scan(/(http:\/\/.*?)(?:\"|\'|<|&lt;)/i) #c.scan(/(http:\/\/.*?)[\"|\'|<|&gt;]/)
  end
end

# rss = open('../../sources/bloglines_top_links.rss').read
# l = rss.scan(/<a.*href=\"(http.*?)\"/).delete_if { |u| u.to_s.include? "bloglines" }
# puts l.inspect
