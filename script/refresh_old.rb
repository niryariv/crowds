#!/usr/bin/env ruby
RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

require 'rubygems'
require 'typhoeus'

ROOT = File.expand_path(File.dirname(__FILE__)+'/../')
require "#{ROOT}/config/environment.rb"
require "#{ROOT}/config/crowds.rb"

ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

# Get to work

MAX_CON = 60

hydra = Typhoeus::Hydra.new(:max_concurrency => MAX_CON)
hydra.disable_memoization

# all_feeds = Feed.all(:order => "fail_count, last_read_at, created_at")
def now
    Time.now.utc
end

cycle_start = now ; ctr = 0 # ; next_start = 0
puts "#{cycle_start} [Feed Reader] Initialized in #{RAILS_ENV}"

loop do

    Crowd.remove_deleted

    feeds = Feed.all(   
                        :order => "fail_count, last_read_at, created_at", 
                        :conditions => ["updated_at is not null AND updated_at < ?", cycle_start],
                        :limit => MAX_CON
                    )

    ctr += feeds.size
    
    if feeds.size == 0
        puts "#{now} [Feed Reader] Ended feed cycle. Took #{(now - cycle_start).round} seconds. Updated #{ctr} feeds. Sleep(60) and go again!"
        cycle_start = now ; ctr = 0
        sleep(60)
        next
    end
    
    feeds.each do |f|
        puts "Reading feed #{f.title} [#{f.url}]"
        
        req = Typhoeus::Request.new(    
                                        f.url, 
                                        :user_agent => USER_AGENT,
                                        :timeout    => 30000,
                                        :follow_location => true,
                                        :headers    => (f.last_read_at.nil? ? {} : { 'If-Modified-Since' => f.last_read_at.httpdate })
                                    )
        req.on_complete do |resp|
            puts "#{resp.code} #{f.url}"
            if resp.code == 200
                f.refresh(resp.body)
            else
                f.increment :fail_count unless resp.code == 304
                f.updated_at = now
                f.save
            end
        end

        hydra.queue req
        # sleep(1)
    end 
    hydra.run    
    puts "#{now} [Feed Reader] Running for #{(now - cycle_start).round} seconds. Updated #{ctr} feeds."
end


