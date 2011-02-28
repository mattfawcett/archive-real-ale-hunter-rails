task :clean_addresses => :environment do
  matt = User.first
  puts matt.inspect
  Pub.all(:limit => 10000, :conditions => ["user_id = ? AND post_code LIKE 'LS%' ", matt.id]).each do |pub|
    puts "Next pub #{pub.address_2} | #{pub.town} | #{pub.post_code} | (#{pub.name})"
    unless pub.town == "Leeds"
      if pub.address_2
        pub.address_1 += " #{pub.address_2}"
      end
      pub.address_2 = pub.town
      pub.town = "Leeds"
      pub.save!
    end
    puts " Updated to: #{pub.address_2} | #{pub.town} | #{pub.post_code} | (#{pub.name})"
  end
end