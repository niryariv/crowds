#!/usr/bin/env ruby
RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

require 'rubygems'
require 'typhoeus'

ROOT = File.expand_path(File.dirname(__FILE__)+'/../')
require "#{ROOT}/config/environment.rb"
require "#{ROOT}/config/crowds.rb"

ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

puts "#{Time.now} [Feed Reader] Initialized in #{RAILS_ENV}"

cycle_start = Time.now
puts "#{Time.now} [Feedread Daemon] Starting feed cycle"


hydra = Typhoeus::Hydra.new(:max_concurrency => 30)

Feed.all[1..100].each do |f|     
    puts "Reading feed #{f.title} [#{f.url}]"

    req = Typhoeus::Request.new(f.url, 
                                    :user_agent => USER_AGENT,
                                    :timeout    => 30000,
                                    :follow_location => true
                                )
    req.on_complete do |resp|
        f = File.new("/tmp/feeds/#{f.id}", "w")
        f.write(resp.body)
        f.close
    end
    hydra.queue req
end 

hydra.run


puts "#{Time.now} [Feed Reader] Ending feed cycle. Took #{(Time.now - cycle_start).round} seconds."
