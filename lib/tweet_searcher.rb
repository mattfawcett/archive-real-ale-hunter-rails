module TweetSearcher
  def self.run!
    Twitter::Search.new('#realalehunter').each do |tweet|
      next unless tweet.geo
      next if Visit.find_by_tweet_id(tweet.id)
      pubs = Pub.find(:all, :origin => tweet.geo.coordinates, :within => 1, :order => :distance)
      if pubs.length > 0
        matching_pub = nil
        pubs.each do |pub|
          name_of_pub_words = pub.name.downcase.gsub(/[^a-z ]/, "").split(" ")
          tweet_words = tweet.text.downcase.gsub(/[^a-z ]/, "").split(" ")
          if (tweet_words - name_of_pub_words).length < tweet_words.length
            matching_pub = pub
            break
          end
        end
        matching_pub = pubs.first if !matching_pub
        visit = Visit.create(:pub => matching_pub, :user => User.find_by_twitter_username(tweet.from_user),
                             :comments => tweet.text.gsub("#realalehunter","").strip,
                             :tweet_id => tweet.id, :tweet_username => tweet.from_user)
      end
    end
  end
end