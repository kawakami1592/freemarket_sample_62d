# ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)
# ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', File.dirname(__FILE__))

root = "/var/www/freemarket_sample_62d/current"
before_exec do |server|
ENV['BUNDLE_GEMFILE'] = "#{root}/Gemfile"
end

require 'bundler/setup' # Set up gems listed in the Gemfile.
require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
