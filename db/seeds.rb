# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sites = { "https://marco.org/" => "http://marco.org/rss",
          "http://daringfireball.net/" => "http://daringfireball.net/feeds/main",
          "https://jonathanpike.net/" => "http://www.jonathanpike.net/feed.xml",
          "http://leancrew.com/all-this/" => "http://leancrew.com/all-this/feed/",
          "http://www.justinweiss.com" => "http://www.justinweiss.com/atom.xml",
          "http://tenderlovemaking.com" => "http://tenderlovemaking.com/atom.xml",
          "http://patshaughnessy.net" => "http://feeds2.feedburner.com/patshaughnessy",
          "http://blog.codinghorror.com" => "http://feeds.feedburner.com/codinghorror",
          "http://weblog.jamisbuck.org" => "http://feeds.feedburner.com/buckblog",
          "http://prog21.dadgum.com" => "http://prog21.dadgum.com/atom.xml",
          "https://m.signalvnoise.com/" => "https://m.signalvnoise.com/feed",
          "https://www.hodinkee.com/" => "https://www.hodinkee.com/blog",
          "http://weblog.rubyonrails.org/" => "http://weblog.rubyonrails.org/feed/atom.xml",
          "http://sirupsen.com/" => "http://feeds.feedburner.com/sirupsen",
          "https://sivers.org/blog" => "https://sivers.org/en.atom",
          "http://blog.pinboard.in/" => "https://blog.pinboard.in/feed/" }

sites.each do |url, feed_url|
  Site.create(url: url, feed_url: feed_url)
end 