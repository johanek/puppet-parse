#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
require 'puppet-classparser/runner'
require 'yaml'

run = PuppetClassParser::Runner
puts run.run(ARGV).inspect

