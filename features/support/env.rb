# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'

# Comment out the next line if you don't want Cucumber Unicode support
require 'cucumber/formatter/unicode'



require 'webrat'
require "webrat/mechanize"


Webrat.configure do |config|
  config.mode = :rails
end

class MechanizeWorld < Webrat::MechanizeAdapter
  include Webrat::Matchers
end


require 'cucumber/rails/rspec'
require 'webrat/core/matchers'

require 'spec/stubs/cucumber'

require 'machinist'
require File.expand_path(File.dirname(__FILE__) + "/../../spec/blueprints")
at_exit { Sham.reset }
