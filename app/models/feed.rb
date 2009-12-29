#require 'htmlentities/string'
require 'feed_tools'

class Feed < ActiveRecord::Base

  has_many :ownerships #, :dependent => :destroy #true
  has_many :crowds, :through => :ownerships #, :dependent => :destroy
  
  has_many :items, :dependent => :destroy

  attr_accessor :known_urls
  
  # TODO
  # validates_url_format_of :url
  
  
  def refresh(body = nil)
    logger.info "Feed::refresh url:#{self.url}"

    known_urls = []
    self.items.each do |i|
        known_urls << i.url
    end

    rss = FeedTools::Feed.new
    
    # work only via refresh_typho from now on
    return false if body.nil?
    
    rss.items.each do |i|
      published = i.time
      next if (!self.last_read_at.nil? and published < self.last_read_at) or published < (Gaps.max+10).days.ago or known_urls.include?(i.link)
      
      begin
          it = self.items.create(:url=>i.link, :created_at=>published, :title=>i.title, :normalized => false)
          known_urls << i.link
          next if it.new_record? # new_record?=true means that the item was was already in the DB previously, so ignore it
      rescue
      end
      
      i.description.to_s.scan(/(http:\/\/.*?)[$|\'|\"|\s|\<]/i).flatten.uniq.each do |u|
        unless u =~ /(\.mp3|\.mp4|\.mpeg|\.mpg|\.mov|\.gif|\.jpg|\.jpeg|\.png|\.js)$/i \
            or u.include?('/feedads.googleadservices.com/') \
            or u.include?('http://ads.') \
            or u.include?('http://feedads.') \
            or u.include?('http://ad.') \
            or known_urls.include?(u)
                begin
                    self.items.create(:url=>u, :created_at=>published, :source_id=>it.id, :normalized => false)
                rescue # silently
                end
                known_urls << u
        end 
      end
    end
    
    self.fail_count = 0
    self.last_read_at = Time.now
    self.save
    
  rescue Exception=>e
    logger.error "Feed::refresh - ERROR: #{e.message} on #{self.url}"
    self.increment :fail_count
    self.save
    false
  end

end
