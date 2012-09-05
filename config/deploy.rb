require 'rubygems'
require 'bundler/capistrano'
load 'deploy/assets'

default_run_options[:pty] = true


set :repository,  "git@bitbucket.org:mattfawcett/real-ale-hunter-rails.git"
set :deploy_to, "/var/www/realalehunter"
set :branch, "upgrade"
set :scm, :git
set :user, :deploy
set :port, 1985



role :web, "new.realalehunter.co.uk"                          # Your HTTP server, Apache/etc
role :app, "new.realalehunter.co.uk"                          # This may be the same as your `Web` server
role :db,  "new.realalehunter.co.uk", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
