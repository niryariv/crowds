require 'net/https'

class Tag < ActiveRecord::Base  
  
  def self.get_for(url)
    #logger.info "Tag::get_for #{url}"
    
    t = find_by_url(url)
    return t.tags unless t.nil?

    http=Net::HTTP.new('api.del.icio.us', 443)
    http.use_ssl = true

    xml = ''    
    http.start do |http|
      req = Net::HTTP::Get.new('/v1/posts/suggest?url=' + url)
      req.basic_auth DeliciousUser, DeliciousPass
      response = http.request(req)
      xml = response.body
    end
    
    xml = xml.gsub 'recommended>', 'popular>'
    tags = xml.scan(/<popular>(.*)<\/popular>/).flatten
    tags = (tags.size > 0) ? '#' + tags[0..2].join(' #') : ''
    create(:url=>url, :tags=>tags)

    tags
  end

end