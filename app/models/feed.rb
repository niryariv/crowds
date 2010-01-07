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
  


  def refresh(body)
    logger.info "Feed::refresh url:#{self.url}"
    
    known_urls = []
    self.items.each do |i|
        known_urls << i.url
    end
    
    rss = FeedTools::Feed.new
    
    # body is never nil, at the current setup
    # if !body.nil?
    #     rss.feed_data = body
    # else
    #     rss.feed_data = load_url(self.url, self.last_read_at)
    # end
    rss.feed_data = body
    
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
            or u.include?('http://feedads.') \
            or u.include?('http://ads.') \
            or u.include?('http://ad.') \
            or known_urls.include?(u)
                begin
                    self.items.create(:url=>u, :created_at=>published, :source_id=>it.id, :normalized => false)
                rescue
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

 

  def feedzirra_refresh(body)
      items = {}

      rss = Feedzirra::Feed.parse(body)

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
          
          i.summary.to_s.scan(/(http:\/\/.*?)[$|\'|\"|\s|\<]/i).flatten.uniq.each do |u|
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
  
  def feedzirra_get_links(body)
      items = {}

      # rss = FeedTools::Feed.new
      # rss.feed_data = body
      
      rss = Feedzirra::Feed.parse(body)

      rss.entries.each do |i|
          puts "checking #{i.title}"
          published = i.last_modified
          next if (!self.last_read_at.nil? and published < self.last_read_at) or published < (Gaps.max+10).days.ago \

        items[i.url] = { :created_at=>published, :title=>i.title }

        i.summary.to_s.scan(/(http:\/\/.*?)[$|\'|\"|\s|\<]/i).flatten.uniq.each do |u|
          unless u =~ /(\.mp3|\.mp4|\.mpeg|\.mpg|\.mov|\.gif|\.jpg|\.jpeg|\.png|\.js)$/i \
              or u.include?('http://feedads.') \
              or u.include?('http://ads.') \
              or u.include?('http://ad.') \
              or items.keys.include?(u)
                 items[u] = {:created_at=>published, :parent=>i.url}
          end 
        end
      end
      
      items
  end

  def get_links(body)
      items = {}

      rss = FeedTools::Feed.new
      rss.feed_data = body
      
      rss.items.each do |i|
          puts "checking #{i.title}"
          published = i.time
          next if (!self.last_read_at.nil? and published < self.last_read_at) # or published < (Gaps.max+10).days.ago \

        items[i.link] = { :url=>i.link, :created_at=>published, :title=>i.title, :items=>[] }

        i.description.to_s.scan(/(http:\/\/.*?)[$|\'|\"|\s|\<]/i).flatten.uniq.each do |u|
          unless u =~ /(\.mp3|\.mp4|\.mpeg|\.mpg|\.mov|\.gif|\.jpg|\.jpeg|\.png|\.js)$/i \
              or u.include?('http://feedads.') \
              or u.include?('http://ads.') \
              or u.include?('http://ad.') \
              or items.keys.include?(u)
                 items[i.link][:items] << {:url=>u, :created_at=>published}
          end 
        end
      end
      
      items
  end


  # deprecated by refresh_typho. if this is called, something went wrong
  def load
    logger.error("WTF? load (#{self.id}) #{self.url}")
    self.last_read_at = Time.at(0) if self.last_read_at.nil?
    
    open(self.url, { 'User-Agent' => USER_AGENT, 'If-Modified-Since' => self.last_read_at.httpdate }).read.to_s                    
  rescue Exception=>e
    logger.error "ERROR Feed::load : #{e.message} on #{url}"
    ''
  end

end
