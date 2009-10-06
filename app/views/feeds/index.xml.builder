xml.instruct! :xml, :version=>"1.0" 
xml.opml(:version=>"1.1") do
  xml.head do
    xml.title "Feeds for #{@crowd.title}"
    xml.dateCreated Time.now.rfc2822
  end
  xml.body do
    for f in @feeds
      xml.outline(:title=>h(f.title), :htmlUrl=>h(f.home_url), :xmlUrl=>h(f.url))
    end
  end
end