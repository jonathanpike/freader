xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
xml.opml("version" => "1.0") do
  xml.title "Subscription Export from the Digest for #{@username}"
  xml.body do
    @subscriptions.each do |subscription|
      xml.outline("text" => subscription.title,
                  "title" => subscription.title,
                  "type" => "rss",
                  "htmlUrl" => subscription.url,
                  "xmlUrl" => subscription.feed_url)
    end
  end
end