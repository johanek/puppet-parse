$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "vendor"))
require 'puppet'
require 'puppet-parse/version'
require 'puppet-parse/parser'
require 'puppet-parse/runner'
require 'puppet-parse/hash'
require 'puppet-parse/configuration'
require 'rdoc'

