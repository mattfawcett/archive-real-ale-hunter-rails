module TweetSearcher
  def self.run!
    Twitter::Search.new('#realalehunter').each do |tweet|
      next unless tweet.geo
      pubs = Pub.find(:all, :origin => tweet.geo.coordinates, :within => 2, :order => :distance)
      if pubs.length > 0
        matching_pub = nil
        pubs.each do |pub|
          name_of_pub_words = pub.name.downcase.gsub(/[^a-z ]/, "").split(" ")
          tweet_words = tweet.text.downcase.gsub(/[^a-z ]/, "").split(" ")
          puts "name of pub words are #{name_of_pub_words.inspect}, tweet words are #{tweet_words.inspect}, minus are #{(tweet_words - name_of_pub_words).inspect}"
          if (tweet_words - name_of_pub_words).length < tweet_words.length
            matching_pub = pub
            puts "FOUND A MATCH #{matching_pub.name}"
            break
          end
        end
        matching_pub = pubs.first if !matching_pub
        visit = Visit.create(:pub => matching_pub, :user => User.find_by_twitter_username(tweet.from_user),
                             :comments => tweet.text.gsub("#realalehunter","").strip)
      end
    end
  end
end