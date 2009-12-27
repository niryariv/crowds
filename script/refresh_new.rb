#!/usr/bin/env ruby
RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

require 'rubygems'
require 'typhoeus'

ROOT = File.expand_path(File.dirname(__FILE__)+'/../')
require "#{ROOT}/config/environment.rb"
require "#{ROOT}/config/crowds.rb"

ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

cycle_start = Time.now
puts "#{cycle_start} [Feed Reader] Initialized in #{RAILS_ENV}"

# Get to work

hydra = Typhoeus::Hydra.new(:max_concurrency => 30)
hydra.disable_memoization

GC.start

Feed.all(:conditions => "last_read_at is null").each do |f|     
    puts "Reading feed #{f.title} [#{f.url}]"
    
    last_updated = f.last_read_at.httpdate unless f.last_read_at.nil?
    
    req = Typhoeus::Request.new(f.url, 
                                    :user_agent => USER_AGENT,
                                    :timeout    => 30000,
                                    :follow_location => true,
                                    :headers    => { 'If-Modified-Since' => last_updated }
                                )
    req.on_complete do |resp|
        puts "#{resp.code} #{f.url}"
        if resp.code == 200
            f.refresh(resp.body)
        elsif resp.code != 304
            f.increment :fail_count
            f.save
        end
    end
    hydra.queue req
end 

hydra.run


puts "#{Time.now} [Feed Reader] Ending feed cycle. Took #{(Time.now - cycle_start).round} seconds."


