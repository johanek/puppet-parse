require 'puppet-classparser/version'
require 'puppet-classparser/hash'
require 'rubygems'
require 'puppet'
require 'rdoc'

class PuppetClassParse
  
  def initialize(file)
    self.file(file)

    # Read file and return parsed object
    pparser = Puppet::Parser::Parser.new('production')
    @object = pparser.import(@file)
  end
  
  # Sets file to be tested
  def file(file)
    if File.exist? file
      @fileinfo = {}
      @fileinfo[:path] = file
      @fileinfo[:fullpath] = File.expand_path(file)
      @fileinfo[:filename] = File.basename(file)
      @file = file
    end
  end
  
  # Read parameters from parsed object, returns hash of parameters and default 
  # values
  def parameters
    @object.last.arguments
  end
  
  # Read class from parsed object, returns string containing class
  def class
    @object.last.name
  end
  
  # Read RDOC contents from parsed object, returns hash of paragraph headings
  # and the following paragraph contents 
  #(i.e. parameter and parameter documentation)
  def docs
    rdoc = RDoc::Markup.parse(@object.last.doc)
    docs = {}

    rdoc.parts.each do |part|
      if part.respond_to?(:items)
        part.items.each do |item|
          key = item.label.tr('^A-Za-z0-9_-', '')
          docs[key] = item.parts.first.parts
        end # do item
      end # endif
    end # do parm
    
    docs
  end # def docs
      
end # Class PuppetParse