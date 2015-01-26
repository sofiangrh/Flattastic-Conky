
import feedparser
rss_url = "http://news.google.com/?output=rss"
feed = feedparser.parse( rss_url )
count =  len(feed['entries'])
for i in range(0, count):
	if (i>=9):
		break
	print '{0: <83} {1}...'.format(' ', feed.entries[i].title[0:40].encode('utf8'))
