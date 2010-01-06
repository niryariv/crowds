#!/usr/bin/env ruby

# multi process refresh using Spawn
# currently experimental, not used

begin
  RAILS_ENV = (ARGV[1].nil? ? 'development' : ARGV[1])

  require 'rubygems'
  require 'daemons'
  
  # def log(message)
  #   ActiveRecord::Base.logger.info "#{Time.now} [Mail Daemon] #{message}"
  # end

  ROOT = File.expand_path(File.dirname(__FILE__)+'/../../')
  require "#{ROOT}/config/environment.rb"
  require "#{ROOT}/config/crowds.rb"
  
  ActiveRecord::Base.logger = Logger.new(STDOUT) # direct all log to output, which is then directed to the daemon's log file

  puts "#{Time.now} [Feedread Daemon] Initialized in #{RAILS_ENV}"

  cycle_start = Time.now
  puts "#{Time.now} [Feedread Daemon] Starting feed cycle"

  include Spawn

  spawn_ids = [] ;  ctr = 0
  
  Feed.all.each do |f| 
    ctr+=1
    puts "Refreshing feed #{f.title} [#{f.url}]"

    spawn_ids[ctr] = spawn(:nice => 7) do
         f.refresh
    end
    
    if ctr == 10
        wait(spawn_ids)
        ctr = 0
    end
    
  end 
  
  wait(spawn_ids)
  
  puts "#{Time.now} [Feedread Daemon] Ending feed cycle. Took #{(Time.now - cycle_start).round} seconds."

  Item.delete_old
  Crowd.remove_deleted

  `rm #{CacheDir}/*`

rescue Exception => e
  puts "++++++++ ERROR +++++++\n#{e.message}"
end