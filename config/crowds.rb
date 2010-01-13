# Config vars for Crowds app go here.

AppName = 'Crowds Machine'


# Didn't really plan to cheat on my User-Agent, but Facebook forces that...
USER_AGENT = 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.1.6) Gecko/20091201 Firefox/3.5.6'


# These are the time gaps for which to check new items
# Items older than (Gaps.max + 10) are automatically deleted from the DB
# Gaps = [1,3,7,30]   # days

TimeframeStart = 14 # days.ago
TimeframeEnd   = 1  # day.from_now


# Lifetime of popular items cache
CacheLifetime = 4  # hours
CacheDir = RAILS_ROOT + '/tmp/cache/data'

# FeedCacheDir = '/tmp/feeds'

# Default number of references a URL should have in order to be considered "popular"
DefaultThreshold = 2

# Default max number of items to return
DefaultItemLimit = 25


# Delicious API login (for tags)
DeliciousUser  = 'crowdwhisper'
DeliciousPass  = 'cr0wdd'


require 'open-uri'
