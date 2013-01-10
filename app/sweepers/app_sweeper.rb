class AppSweeper < ActionController::Caching::Sweeper
  observe Pub, Visit, Image, Rating

  def after_save(record)
    self.class::expire_pub_page(record.is_a?(Pub) ? record : record.pub)
    self.class::expire_pubs_json if record.is_a?(Pub)
  end

  def self.expire_pubs_json
    cache_dir = ActionController::Base.page_cache_directory
    FileUtils.rm("#{cache_dir}/pubs.json") rescue Errno::ENOENT
  end
  
  def self.expire_pub_page(pub)
    #not working
    ActionController::Base.new.expire_page("/pubs/#{pub.slug}")
  end
end
