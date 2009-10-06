#!/usr/bin/ruby

# Unhandled edge cases:
# 1. A line that starts with "Processing" or "Completed in" which is not by the logger itself
# 2. URL containing ']'

cmd =  {}; cmd.default = ''
while (!ARGV.empty?) do
  cmd[ARGV.shift] = ARGV.shift
end

match_url = cmd['-u']
line_count = tot_runtime = tot_dbtime = tot_dbperc = 0

days = Hash.new {|h,k| h[k]={ :tot_runtime=>0, :tot_dbtime=>0, :hits=>0, :max=>0, :min=>0}}
day = 'unknown'

found_urls = {}; found_urls.default=0

STDIN.each_line do |line|
  day = $1.to_s if line =~ %r{^Processing .* (\d\d\d\d-\d\d-\d\d) }

  if line =~ %r{^Completed in (\dms).*DB: (\d+) .* 200 OK \[(.*#{match_url}.*)\]}
    runtime = $1.to_f
    dbtime = $2.to_f
    url = $3
    found_urls[url] +=1 
    # Here you can put and extra filter on the results, Eg:
    # if dbperc > 20 or dbtime > 1 
      days[day][:tot_runtime] += runtime
      days[day][:tot_dbtime] += dbtime
      days[day][:hits] += 1
      days[day][:max] = runtime if days[day][:max] < runtime or days[day][:max] == 0
      days[day][:min] = runtime if days[day][:min] > runtime or days[day][:min] == 0
    # end
    
  end
end

days.delete('unknown')

puts "match_url:|#{match_url}|"
found_urls.each {|u, hits| puts "#{hits}: #{u}"}; puts ''
  
days.sort.each do |d,v|
  hits = v[:hits]
  avg_runtime = v[:tot_runtime] / hits
  avg_dbtime  = v[:tot_dbtime] / hits
  avg_perc = (avg_dbtime/avg_runtime) * 100
  printf("%s:\t Runtime %.2fs \tDB %.2fs (%.1f%%) \t Max %.2fs Min %.2fs\n", d, avg_runtime, avg_dbtime, avg_perc, v[:max], v[:min])
end