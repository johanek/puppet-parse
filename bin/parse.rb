#!/usr/bin/env ruby
require 'rubygems'
require 'puppet'
require 'rdoc'

a = Puppet::Parser::Parser.new('production')
b = a.import('init.pp')

pclass = b.last.name

d = RDoc::Markup.parse(b.last.doc)
docs = {}

d.parts.each do |part|
  if part.respond_to?(:items)
    part.items.each do |item|
      key = item.label.tr('^A-Za-z0-9_', '')
      docs[key] = item.parts.first.parts
    end
  end
end

b.last.arguments.each do |k,v|
  puts "#{k} #{v} #{docs[k]}"
end
