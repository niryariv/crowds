# CREATE TABLE trueurls (id INT NOT NULL AUTO_INCREMENT, host varchar(255), clean tinyint(1), PRIMARY KEY(id), INDEX(host));

class Trueurl < ActiveRecord::Base
    
  UrlShorteners = %w{ adjix.com b23.ru bit.ly budurl.com canurl.com cli.gs decenturl.com dolop.com dwarfurl.com easyurl.net elfurl.com ff.im 
    fire.to flq.us freak.to fuseurl.com g02.me go2.me idek.net is.gd ix.lt kissa.be kl.am korta.nu krunchd.com ln-s.net loopt.us memurl.com 
    miklos.dk moourl.com myurl.in nanoref.com notlong.com ow.ly ping.fm piurl.com poprl.com qicute.com qurlyq.com reallytinyurl.com redirx.com 
    rubyurl.com rurl.org shorl.com short.ie shorterlink.com shortlinks.co.uk shorturl.com shout.to shrinkurl.us shurl.net shw.me simurl.com 
    smallr.com snipr.com snipurl.com snurl.com starturl.com surl.co.uk tighturl.com tinylink.com tinypic.com tinyurl.com tinyvh.com tr.im 
    traceurl.com twurl.nl u.mavrev.com ur1.ca url-press.com url.ie url9.com urlcut.com urlhawk.com urlpass.com urlx.ie xaddr.com xrl.us yep.it 
    yuarel.com yweb.com zurl.ws } + %w{ feedburner.com feedproxy.google.com }

    
  def self.get(url)  
    host = url.split('/')[2].downcase
    
    return scrape_real_url(url) if UrlShorteners.include?(host)

    u = Trueurl.find_by_host(host)
    if u.nil?
      new_url = scrape_real_url(url)
      u = Trueurl.create(:host => host, :clean => (new_url == url))
      new_url
    else
      (u.clean?) ? url : scrape_real_url(url)
    end
    
  end


  def self.scrape_real_url(url)
    new_url = `curl -Is '#{url}'`.match(/^Location:\s(.*?)$/).to_a[1].to_s.strip
    (new_url == '') ? url : new_url
  end
end
