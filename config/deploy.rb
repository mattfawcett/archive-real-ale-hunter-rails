default_run_options[:pty] = true


set :repository,  "git@github.com:mattfawcett/real-ale-hunter-rails.git"
set :deploy_to, "/home/matt/web/real-ale-hunter-rails"
set :scm, :git
set :user, :matt
set :port, 1985



role :web, "174.143.255.140"                          # Your HTTP server, Apache/etc
role :app, "174.143.255.140"                          # This may be the same as your `Web` server
role :db,  "174.143.255.140", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end