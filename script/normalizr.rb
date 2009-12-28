#!/usr/bin/env ruby
RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

require 'rubygems'
require 'typhoeus'
require 'json'

ROOT = File.expand_path(File.dirname(__FILE__)+'/../')
require "#{ROOT}/config/environment.rb"
require "#{ROOT}/config/crowds.rb"

MAX_CON = 20

# quiet
ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

cycle_start = Time.now
puts "#{cycle_start} [Normalizr] Initialized in #{RAILS_ENV}"

# Get to work

# clean up those weird future items
Item.delete_all "created_at > '#{1.day.from_now.to_s(:db)}'"

hydra = Typhoeus::Hydra.new(:max_concurrency => MAX_CON)
hydra.disable_memoization

ctr = 0

loop do
    items = Item.all(:conditions => "normalized = 0", :order => "created_at DESC", :limit => MAX_CON)

    if items.size == 0 # never quit...
        puts "WAIT FOR MORE..."
        sleep(100) 
        next
    end
    
    ctr += items.size
    
    items.each do |i|     
    
        req = Typhoeus::Request.new("http://therealurl.appspot.com/",
                                    :params => { "format" => "json", "url" => i.url },
                                    :timeout => 20000 )

        req.on_complete do |resp|
            # puts "Check [#{i.id}] #{i.url}"
            if resp.code == 200
                begin
                    d = JSON.parse(resp.body)
                    puts "FOUND #{i.url} => #{d['url']}" if i.url != d['url']
                    Item.update_all ["normalized = 1, url=?, title=?", d['url'], d['title']] , "url='#{i.url}'"
                rescue Exception => e
                    Item.update_all "normalized = 1" , "url='#{i.url}'"
                    puts "ERROR: #{e} [#{i.url}]"
                end
            end
        end
        hydra.queue req
    end 
    hydra.run
    sleep(1)
end

puts "#{Time.now} [Normalizr] Done. Took #{(Time.now - cycle_start).round} seconds to clean #{ctr} items"
