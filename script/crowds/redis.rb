#!/usr/bin/env ruby
RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])
ROOT = File.expand_path(File.dirname(__FILE__)+'/../')

require 'rubygems'
require 'redis'

r = Redis.new

require "#{ROOT}/config/environment.rb"
require "#{ROOT}/config/crowds.rb"

ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file


feeds = []

Feed.all.each do |f|
    key = "feed-#{f.id}-urls"
    feeds << key
    
    f.items.each do |i|
        r.set_add(key, i.url)
    end
end

puts feeds

puts r.set_intersect(feeds)

