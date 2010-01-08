#require 'htmlentities/string'
# require 'feed_tools'
require 'feedzirra'

class Feed < ActiveRecord::Base

  has_many :ownerships #, :dependent => :destroy #true
  has_many :crowds, :through => :ownerships #, :dependent => :destroy
  
  has_many :items, :dependent => :destroy

  attr_accessor :known_urls
  
  # TODO
  # validates_url_format_of :url
 

  # rss is a Feedzirra::Feed object
  def refresh(rss = nil)
      
      # this is meant to be called with a Feed object. If the object isn't present, try and fetch the feed - without If-Modified-Since etc
      rss = Feedzirra::Feed.fetch_and_parse(self.url) if rss.nil?
      
      items = {}

      rss.entries.each do |i|
          puts "checking #{i.title}"
          published = i.last_modified
          next if (!self.last_read_at.nil? and published < self.last_read_at) or published < (Gaps.max+10).days.ago \

          begin
              # items[i.url] = { :created_at=>published, :title=>i.title }
              it = self.items.create(:url=>i.url, :created_at=>published, :title=>i.title, :normalized => false)
          rescue Exception => e # items already existed
              puts "ERROR Feed::feedzirra_refresh #{e}"
              next 
          end
          
          i.content.to_s.scan(/(http:\/\/.*?)[$|\'|\"|\s|\<]/i).flatten.uniq.each do |u|
            unless u =~ /(\.mp3|\.mp4|\.mpeg|\.mpg|\.mov|\.gif|\.jpg|\.jpeg|\.png|\.js)$/i \
              or u.include?('http://feedads.') \
              or u.include?('http://ads.') \
              or u.include?('http://ad.') \
              or items.keys.include?(u)
                begin
                    self.items.create(:url=>u, :created_at=>published, :source_id=>it.id, :normalized => false)
                rescue Exception => e
                    puts "ERROR Feed::feedzirra_refresh #{e}"
                end
                # items[u] = {:created_at=>published, :parent=>i.url}
            end 
          end
      end
      
      items
  end
  
  # # unused for now
  # def feedzirra_get_links(body)
  #     items = {}
  # 
  #     # rss = FeedTools::Feed.new
  #     # rss.feed_data = body
  #     
  #     rss = Feedzirra::Feed.parse(body)
  # 
  #     rss.entries.each do |i|
  #         puts "checking #{i.title}"
  #         published = i.last_modified
  #         next if (!self.last_read_at.nil? and published < self.last_read_at) or published < (Gaps.max+10).days.ago \
  # 
  #       items[i.url] = { :created_at=>published, :title=>i.title }
  # 
  #       i.summary.to_s.scan(/(http:\/\/.*?)[$|\'|\"|\s|\<]/i).flatten.uniq.each do |u|
  #         unless u =~ /(\.mp3|\.mp4|\.mpeg|\.mpg|\.mov|\.gif|\.jpg|\.jpeg|\.png|\.js)$/i \
  #             or u.include?('http://feedads.') \
  #             or u.include?('http://ads.') \
  #             or u.include?('http://ad.') \
  #             or items.keys.include?(u)
  #                items[u] = {:created_at=>published, :parent=>i.url}
  #         end 
  #       end
  #     end
  #     
  #     items
  # end


  # # deprecated - use refresh() with no arguments instead
  # def load
  #   logger.error("WTF? load (#{self.id}) #{self.url}")
  #   self.last_read_at = Time.at(0) if self.last_read_at.nil?
  #   
  #   open(self.url, { 'User-Agent' => USER_AGENT, 'If-Modified-Since' => self.last_read_at.httpdate }).read.to_s                    
  # rescue Exception=>e
  #   logger.error "ERROR Feed::load : #{e.message} on #{url}"
  #   ''
  # end

end
