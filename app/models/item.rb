class Item < ActiveRecord::Base

  belongs_to :feed
  
  validates_uniqueness_of :url, :scope => :feed_id
  
  before_save :get_title, :verify_url, :verify_unique
  

  # This is slow and wasteful. But, since now it's only used for post URLs, it's not that big a deal.
  def verify_unique
    Item.find(:first, :conditions=>['feed_id=? AND url=?', self.feed_id, self.url]).nil?
  end
  
  def get_title
    if self.title.nil?
      html = open(self.url).read
      self.title = html.scan(/<title.*?>(.*?)<\/title>/mi).first.to_s.strip
    end
  rescue Exception=>e
    logger.error "Item.get_title (#{self.url}) Failed: #{e.message}"
    self.title = '' if self.title.nil?
  end


  # Handles URLs that redirect. Ruby open() handles redirection automatically, but there's no way to get the real URL from it
  # so this method is just to make sure we have the correct URLs in the DB.
  def verify_url
    self.url = Trueurl.get(self.url)
  end


  # Housekeeping: removes old items from the DB
  def self.delete_old
    self.delete_all "created_at < '#{(Gaps.max+10).days.ago.to_s(:db)}'"
  end

end