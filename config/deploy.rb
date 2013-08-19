require 'rubygems'
require 'bundler/capistrano'
load 'deploy/assets'

default_run_options[:pty] = true


set :repository,  "git@bitbucket.org:mattfawcett/real-ale-hunter-rails.git"
set :deploy_to, "/var/www/realalehunter"
set :branch, "digital-ocean"
set :scm, :git
set :user, :deploy
set :use_sudo, false
set :port, 1985



role :web, "37.139.22.219"                          # Your HTTP server, Apache/etc
role :app, "37.139.22.219"                          # This may be the same as your `Web` server
role :db,  "37.139.22.219", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
