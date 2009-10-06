#!/usr/bin/env ruby

RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

require 'rubygems'
require 'daemons'


# def log(message)
#   ActiveRecord::Base.logger.info "#{Time.now} [Mail Daemon] #{message}"
# end

ROOT = File.expand_path(File.dirname(__FILE__)+'/../')

# The server loop
Daemons.run_proc("feedread_daemon_#{RAILS_ENV}", {:dir_mode => :normal, 
                                        :dir=>"#{ROOT}/log/", 
                                        #:ontop => true, 
                                        #:monitor => true,
                                        :backtrace => true, 
                                        :log_output => true 
                                        }) do # {}

  # here we go..
  require "#{ROOT}/config/environment"
  GC.start
  
  ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

  puts "#{Time.now} [Feedread Daemon] Initialized in #{RAILS_ENV}"

#  loop do 
    cycle_start = Time.now
    puts "#{Time.now} [Feedread Daemon] Starting feed cycle"
    Feed.all.each do |f| 
      puts "Refreshing feed #{f.title} [#{f.url}]"
      f.refresh
      f = nil
      sleep(1)
    end 
    puts "#{Time.now} [Feedread Daemon] Ending feed cycle. Took #{(Time.now - cycle_start).round} seconds."
    
    Item.delete_old
#  end
end