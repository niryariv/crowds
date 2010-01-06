#!/usr/bin/env ruby
RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

require 'rubygems'
require 'typhoeus'
require 'json'

ROOT = File.expand_path(File.dirname(__FILE__)+'/../../')
require "#{ROOT}/config/environment.rb"
require "#{ROOT}/config/crowds.rb"

MAX_CON = 20

FEED_DIR = "/tmp/feeds"

# quiet
ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

cycle_start = Time.now
puts "#{cycle_start} [Normalizr] Initialized in #{RAILS_ENV}"

# Get to work


hydra = Typhoeus::Hydra.new(:max_concurrency => MAX_CON)
hydra.disable_memoization

# returns the next available feed to read
def get_next_feed
    f = Dir.entries(FEED_DIR).reject{ |f| f.include?('.') }.pop
    return false if f.nil?
    
    data = Marshal.load(File.read("#{FEED_DIR}/#{f}"))
    File.rename("#{FEED_DIR}/#{f}", "#{FEED_DIR}/#{f}.processing")
    
    [f.to_i, data]
end

 
ctr = 0

loop do
    # clean up items table
    Item.delete_all "created_at > '#{1.day.from_now.to_s(:db)}'"
    Item.delete_old
    
    feed = get_next_feed

    if !feed
        puts "#{Time.now} [Normalizr] Done. Took #{(Time.now - cycle_start).round} seconds to clean #{ctr} items"
        exit
    end
    
    # if items.size == 0 # never quit...
    #     puts "#{Time.now} [Normalizr] Done. Took #{(Time.now - cycle_start).round} seconds to clean #{ctr} items. Sleep(60) and go again!"
    #     cycle_start = Time.now ; ctr = 0
    #     sleep(60) 
    #     next
    # end

    feed_id, data = feed
    
    # ctr += items.size
    data.each do |url, info|    
        req = Typhoeus::Request.new("http://therealurl.appspot.com/",
                                    :params => { "format" => "json", "url" => url },
                                    :timeout => 20000 )

        req.on_complete do |resp|
            if resp.code == 200 and resp.body != 'error'
                d = JSON.parse(resp.body)
                url = d['url']
                info[:title] = d['title']
            end

            if info[:parent].nil? # this is a parent link
                it = Item.create (:feed_id => feed_id, :published => info[:created_at], :source_id => feed_id, :url => url, :title => info[:title])
                parents[url] = Item.id
            else    # this is a child link
                source_id = (parents[url].nil? ? feed_id : parents[url])
                Item.create (:feed_id => feed_id, :published => info[:created_at], :source_id => source_id, :url => url, :title => info[:title])
            end
                        
        end
        hydra.queue req
    end 
    hydra.run
    sleep(1)
end