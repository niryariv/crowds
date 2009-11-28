#require 'htmlentities/string'
require 'feed_tools'

class Feed < ActiveRecord::Base

  has_many :ownerships #, :dependent => :destroy #true
  has_many :crowds, :through => :ownerships #, :dependent => :destroy
  
  has_many :items, :dependent => :destroy

  attr_accessor :known_urls
  
  # TODO
  # validates_url_format_of :url
  
  
  
  def self.hash_all
    fh = {}
    feeds = self.find(:all)
    feeds.each do |f|
      fh[f.id.to_s] = {:title=> f.title, :home_url=>f.home_url}
    end
    fh
  end
    

  def refresh
    logger.info "feeds/refresh url:#{self.url}"

    rss = FeedTools::Feed.new
    rss.feed_data = load_url(self.url, self.last_read_at)
    
    rss.items.each do |i|
      published = i.time
      it = self.items.create(:url=>i.link, :created_at=>published, :title=>i.title)
      next if it.new_record? # new_record?=true means that the item was was already in the DB previously, so ignore it

      i.description.to_s.scan(/(http:\/\/.*?)[$|\'|\"|\s|\<]/i).flatten.uniq.each do |u|
        unless u =~ /(\.mp3|\.mp4|\.mpeg|\.mpg|\.mov|\.gif|\.jpg|\.jpeg|\.png|\.js)$/i or u.include?('/feedads.googleadservices.com/')
            self.items.create(:url=>u, :created_at=>published, :source_id=>it.id)
        end 
      end
    end

    self.update_attribute(:last_read_at, Time.now)
  rescue Exception=>e
    logger.error "Feed/refresh - ERROR: #{e.message} on #{self.url}"
    false
  end


  # these two should probably be in a some library (?)
  def load_url(url, last_updated = nil) 
    last_updated ||= Time.at(0)
    open(url, { 'User-Agent'=>USER_AGENT, 'If-Modified-Since' => last_updated.httpdate }).read.to_s
  rescue Exception=>e
    logger.error "load_url: #{e.message} on #{url}"
    ''
  end
  

# # deprecated for Crowd.refresh_feeds 
#   def self.refresh_all
#     feeds = self.find(:all, :include=>:ownerships)
#     feeds.each do |f|
#       next if f.ownerships.empty? # don't load URLs which aren't owned by anyone
#       if f.refresh
#         logger.info "Refreshed #{f.url}"
#       else
#         logger.error "Failed refresh #{f.url}"
#       end
#     end
#   end
  
end
