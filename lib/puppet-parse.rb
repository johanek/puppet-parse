$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "vendor"))
require 'puppet'
require 'puppet-parse/version'
require 'puppet-parse/parser'
require 'puppet-parse/runner'
require 'puppet-parse/hash'
require 'puppet-parse/configuration'
gem 'rdoc', '~>3.12'
require 'rdoc'

class PuppetParse
  # Public: Access PuppetParse's configuration from outside the class.
  #
  # Returns a PuppetParse::Configuration object.
  def self.configuration
    @configuration ||= PuppetParse::Configuration.new
  end

  # Public: Access PuppetParse's configuration from inside the class.
  #
  # Returns a PuppetParse::Configuration object.
  def configuration
    self.class.configuration
  end
end
