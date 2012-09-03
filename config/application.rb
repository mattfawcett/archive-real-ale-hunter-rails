require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module RealAleHunter
  class Application < Rails::Application
    config.autoload_paths += [config.root.join('lib'), "#{Rails.root}/app/sweepers"]
    config.encoding = 'utf-8'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{Rails.root}/extras )

    # Specify gems that this application depends on and have them installed with rake gems:install
    # config.gem "bj"
    # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
    # config.gem "sqlite3-ruby", :lib => "sqlite3"
    # config.gem "aws-s3", :lib => "aws/s3"

    # config.gem "friendly_id"
    # config.gem "sqlite3-ruby", :lib => "sqlite3"
    # config.gem "haml"
    # config.gem "paperclip"
    # config.gem "geokit"
    # config.gem "mattfawcett-phpbb-auth", :lib => "phpbb_auth", :source => "http://gems.github.com"
    # config.gem 'thinking-sphinx', :lib => 'thinking_sphinx', :version => '1.3.2'
    # config.gem "will_paginate"
    # config.gem 'rack-rewrite', '~> 0.1.2'


    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Skip frameworks you're not going to use. To use Rails without a database,
    # you must remove the Active Record framework.
    # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    config.time_zone = 'UTC'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    # config.i18n.default_locale = :de
    #config.action_controller.page_cache_directory = File.join(Rails.root, 'public', 'system', 'cache')

    config.secret_token = "b13ba2397ca83a3682d2466cd5ded7dcc73f989ad74d1597692042437f1aec6ee27cfa74b7b5f249b010be81aab2a30ec0d4cd7c2952e8ccfc1b68079284ccde"

    require 'rack-rewrite'
    config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
      r301 '/what-is-real-ale', '/what_is_real_ale'
      r301 '/styles-of-real-ale', '/styles_of_real_ale'
      r301 '/brewing-real-ale', '/brewing_real_ale'
      r301 '/camra-campaign-for-real-ale', '/camra_campaign_for_real_ale'
      r301 '/links.html', '/links'
      r301 '/pubs/ALL.html', '/pubs'
      r301 %r{/pubs/(\w).html}, '/pubs?letter=$1'
      r301 '/towns/ALL.html', '/towns'
      r301 %r{/towns/(\w).html}, '/towns#$1'
      r301 %r{/towns/(.*)/index.html}, '/towns/$1/pubs'
      rewrite %r{/pubs/view_pub/\d+/(\d+).html}, '/pubs/$1' #friendly_id will then redirect to the better name
      rewrite %r{/pubs/view_pub_on_map/(\d+).html}, '/pubs/$1' #friendly_id will then redirect to the better name
      rewrite %r{/pubs/view_images/(\d+)/[0-9].html}, '/pubs/$1/images' #friendly_id will then redirect to the better name
      r301 "/map/index.html", '/map'
      r301 "/new.html", '/whats_new'
      r301 "/newuser/index.php", '/whats_new'
      r301 %r{/forum(.*)}, 'http://forum.realalehunter.co.uk$1'
      rewrite '/app', '/app/index.html'

    end

    config.active_record.observers = :app_sweeper

    config.assets.enabled = true
  end
end

