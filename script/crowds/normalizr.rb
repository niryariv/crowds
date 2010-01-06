#!/usr/bin/env ruby
RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

require 'rubygems'
require 'typhoeus'
require 'json'

ROOT = File.expand_path(File.dirname(__FILE__)+'/../../')
require "#{ROOT}/config/environment.rb"
require "#{ROOT}/config/crowds.rb"

MAX_CON = 20

# quiet
ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

cycle_start = Time.now
puts "#{cycle_start} [Normalizr] Initialized in #{RAILS_ENV}"

# Get to work


hydra = Typhoeus::Hydra.new(:max_concurrency => MAX_CON)
hydra.disable_memoization

ctr = 0

loop do
    # clean up items table
    Item.delete_all "created_at > '#{1.day.from_now.to_s(:db)}'"
    Item.delete_old
    
    # order by id, mark all as normalized allow the next normalizr process to pick new ones
    items = Item.all(:conditions => "normalized = 0", :order => "id", :limit => MAX_CON)
    
    if items.size == 0 # never quit...
        puts "#{Time.now} [Normalizr] Done. Took #{(Time.now - cycle_start).round} seconds to clean #{ctr} items. Sleep(60) and go again!"
        cycle_start = Time.now ; ctr = 0
        sleep(60) 
        next
    end

    Item.update_all "normalized = 1", "id BETWEEN #{items.first.id} AND #{items.last.id}"
    
    ctr += items.size
    
    items.each do |i|     
    
        req = Typhoeus::Request.new("http://therealurl.appspot.com/",
                                    :params => { "format" => "json", "url" => i.url },
                                    :timeout => 20000 )

        req.on_complete do |resp|
            if resp.code == 200 and resp.body != 'error'
                begin
                    d = JSON.parse(resp.body)
                    if i.url != d['url']
                        i.update_attributes :url => d['url'], :title => d['title']
                    elsif d['title'] != i.title.to_s
                        i.update_attribute "title", d['title']
                    end
                rescue Exception => e
                    puts "ERROR: #{e} [#{i.url}]"
                end
            end
        end
        hydra.queue req
    end 
    hydra.run
    sleep(1)
end