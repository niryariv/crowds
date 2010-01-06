ROOT = File.expand_path(File.dirname(__FILE__)+'/../../')

proc  = `ps aux | grep ruby`

normalizr = "normalizr"
refresh = "refresh_typho"

normalizr_on = proc.include?(normalizr)
refresh_on   = proc.include?(refresh)

puts proc
puts "[#{Time.now}] Normalizer: #{normalizr_on} | Refresh: #{refresh_on}"

system("#{ROOT}/script/#{normalizr}.rb > #{ROOT}/log/#{normalizr}.log") unless normalizr_on
system("#{ROOT}/script/#{refresh}.rb > #{ROOT}/log/#{refresh}.log")     unless refresh_on

# 
# puts "refresh_running: #{refresh_running}"
# puts "normalizr_running: #{normalizr_running}"