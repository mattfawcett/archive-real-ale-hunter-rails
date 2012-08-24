# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

# Global access to Rake DSL methods is deprecated. This libe fixed it, this should not be needed once we are on rails 3.0.8 or higher
include Rake::DSL

RealAleHunter::Application.load_tasks

# Load annotate gem. Ok if load error, it does not exist in production
begin
  require 'annotate/tasks'
rescue LoadError
end

