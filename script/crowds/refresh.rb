#!/usr/bin/env ruby
RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

require 'rubygems'
require 'typhoeus'

ROOT = File.expand_path(File.dirname(__FILE__)+'/../../')
require "#{ROOT}/config/environment.rb"
require "#{ROOT}/config/crowds.rb"

ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

# Get to work

MAX_CON = 60

hydra = Typhoeus::Hydra.new(:max_concurrency => MAX_CON)
hydra.disable_memoization

def now
    Time.now.utc
end

def get_headers(headers_string)
  headers = {}
  headers_string.to_a.each do |h|
    k,v = h.split(':',2)
    headers[k.strip.downcase] = v.strip unless v.nil? or k.nil?
  end
  headers
end

cycle_start = now ; ctr = 0 # ; next_start = 0
puts "#{cycle_start} [Feed Reader] Initialized in #{RAILS_ENV}"

loop do
    
    feeds = Feed.all(   
                        :order => "updated_at, fail_count, created_at", 
                        :conditions => ["updated_at is null OR updated_at < ?", cycle_start],
                        :limit => MAX_CON
                    )

    ctr += feeds.size
    
    if feeds.size == 0
        puts "#{now} [Feed Reader] Ended feed cycle. Took #{(now - cycle_start).round} seconds. Updated #{ctr} feeds." # Sleep(60) and go again!"
        ## single loop
        # cycle_start = now ; ctr = 0
        # sleep(300)
        # next
        exit
    end


    feeds.each do |f|
        puts "Reading feed #{f.title} [#{f.url}]"
        
        req = Typhoeus::Request.new(    
                                        f.url, 
                                        :user_agent => USER_AGENT,
                                        :timeout    => 30000,
                                        :follow_location => true,
                                        :headers    => { 'If-None-Match' => f.etag, 'If-Modified-Since' => f.last_modified }
                                    )
        req.on_complete do |resp|
            puts "#{resp.code} #{f.url}"
            if resp.code == 200
                begin
                    f.etag = get_headers(resp.headers)['etag']
                    f.last_modified = get_headers(resp.headers)['last-modified']
                    f.refresh(Feedzirra::Feed.parse(resp.body))
                rescue Exception => e # because, when FZ fails it often means the feed is dead, so mark it +1000 to check it later
                    f.fail_count += 1000
                    puts "ERROR: #{e} [#{f.id}] #{f.url}"
                end
            else
                #f.update_attribute :fail_count, (f.fail_count + 1) unless resp.code == 304
                f.increment :fail_count unless resp.code == 304
            end
            f.updated_at = now
            f.save
        end

        hydra.queue req
    end 
    hydra.run    
    puts "#{now} [Feed Reader] Running for #{(now - cycle_start).round} seconds. Updated #{ctr} feeds."
    
end


