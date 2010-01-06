#!/usr/bin/env ruby
RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

require 'rubygems'
require 'typhoeus'

ROOT = File.expand_path(File.dirname(__FILE__)+'/../../')
require "#{ROOT}/config/environment.rb"
require "#{ROOT}/config/crowds.rb"

ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

# Get to work

MAX_CON = 200

hydra = Typhoeus::Hydra.new(:max_concurrency => MAX_CON)
hydra.disable_memoization

# all_feeds = Feed.all(:order => "fail_count, last_read_at, created_at")
def now
    Time.now.utc
end

cycle_start = now ; ctr = 0 # ; next_start = 0
puts "#{cycle_start} [Fast Reader] Initialized in #{RAILS_ENV}"

total_items = 0

#loop do
    
    Crowd.remove_deleted

    feeds = Feed.all 
    # feeds = Feed.all(   
    #                     :order => "updated_at, fail_count, last_read_at, created_at", 
    #                     :conditions => ["updated_at is null OR updated_at < ?", cycle_start],
    #                     :limit => MAX_CON
    #                 )

    # # for the loop
    # ctr += feeds.size
    # 
    # # if feeds.size == 0
    # #     puts "#{now} [Fast Reader] Ended feed cycle. Took #{(now - cycle_start).round} seconds. Updated #{ctr} feeds. Sleep(60) and go again!"
    # #     cycle_start = now ; ctr = 0
    # #     exit # sleep(60)
    # #     next
    # # end

# Holy shit!
# FeedTools: (316 files) [Fast Reader] Running for 1126 seconds. Updated 498 feeds. Found 1232 items
# FeedZirra: (357 files) [Fast Reader] Running for 87 seconds. Updated 498 feeds. Found 5247 items.

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
            ctr += 1
            f.fail_count = ([200, 304].include?(resp.code) ? 0 : f.fail_count+1)
            f.updated_at = now
            if resp.code == 200
                begin
                    items = f.feedzirra_get_links(resp.body)
                    total_items += items.size
                    File.open("/tmp/feeds/#{f.id}", 'w') {|fp| fp.puts Marshal.dump(items); fp.close}
                rescue Exception => e
                    f.fail_count += 1000
                    puts "ERROR: #{e} [#{f.id}] #{f.url}"
                end
            end
            f.save
        end

        hydra.queue req
        # sleep(1)
    end 
    hydra.run    
    puts "#{now} [Fast Reader] Running for #{(now - cycle_start).round} seconds. Updated #{ctr} feeds. Found #{total_items} items."
    
# end