task :tweet_searcher => :environment do
  TweetSearcher.run!
end