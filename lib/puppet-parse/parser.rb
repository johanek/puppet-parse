require 'pp'

class PuppetParse
  class Parser

    def initialize(file)
      # AST representations of nodes and classes.
      @nodes = []
      @classes = []

      # ASTs converted into ruby hash.
      @nodes_hash = {}
      @classes_hash = {}

      # Read file and return parsed object
      pparser = Puppet::Parser::Parser.new('test')

      if File.exists?(file)
        @file = File.expand_path(file)

        begin
          pparser.import(@file)
        rescue Puppet::ParseError => e
          puts "Error while parsing: #{e.message}"
          exit 1
        end

        # Fill in nodes definitions.
        @nodes = pparser.environment.known_resource_types.nodes

        # Fill in classes defined in parsed file.
        pparser.environment.known_resource_types.hostclasses.each do |klass|
          next if klass.last.file != @file

          @classes << klass.last
        end

        # Find object in list of definitions
        pparser.environment.known_resource_types.definitions.each do |x|
          @object = x.last if x.last.file == @file
        end
      else
        'File does not exist'
      end
    end

    # Just stripe away \" from string.
    def strip_quotes(string)
      string = string.chomp('\"').reverse.chomp('\"').reverse
      string.chomp('"').reverse.chomp('"').reverse
    end

    def handle_vardef(hash, ast_node)
      if ast_node.value == nil
        rvalue = nil
      else
        rvalue = ast_node.value.to_s
      end
      rvalue = strip_quotes(rvalue)
      hash[ast_node.name.to_s] = rvalue
    end

    def handle_resource(hash, ast_node)
      ast_node.instances.each do |instance|
        instance_title = strip_quotes(instance.title.to_s)
        hash[instance_title] = {}

        # Fill in each parameter.
        instance.parameters.each do |parameter|
          hash[instance_title][parameter.param.to_s] = strip_quotes(parameter.value.to_s)
        end
      end
    end

    def handle_resource_override(hash, ast_node)
      hash[ast_node.object.to_s] = {}

      ast_node.parameters.each do |parameter|
        hash[ast_node.object.to_s][parameter.param.to_s] = strip_quotes(parameter.value.to_s)
      end
    end

    def handle_function(hash, ast_node)
      return if ast_node.name != "include"

      argument_name = strip_quotes(ast_node.arguments[0].to_s)
      hash[argument_name] = {}
    end


    ### Classes

    def classes
      @classes.each do |klass|

        # Prepare new class hash.
        @classes_hash[klass.name.to_s] = initialize_class_hash
        @classes_hash[klass.name.to_s]["parent"] = klass.parent.to_s

        next if klass.code == nil

        # Walk through class definition.
        klass.code.each do |ast|
          #puts ast.class.to_s
          case ast.class.to_s
            when "Puppet::Parser::AST::VarDef"
              handle_vardef(@classes_hash[klass.name.to_s]["variables"], ast)
            when "Puppet::Parser::AST::Resource"
              if @classes_hash[klass.name.to_s]["resources"][ast.type] == nil
                @classes_hash[klass.name.to_s]["resources"][ast.type] = {}
              end

              handle_resource(@classes_hash[klass.name.to_s]["resources"][ast.type], ast)
            when "Puppet::Parser::AST::ResourceOverride"
              handle_resource_override(@classes_hash[klass.name.to_s]["resource_overrides"], ast)
            else
              next
          end
        end
      end

      @classes_hash
    end

    def initialize_class_hash
      {
        "variables"          => {},
        "resources"          => {},
        "resource_overrides" => {},

        # Empty for now.
        "resource_defaults"  => {},
        "includes"           => {},
      }
    end



    ### Nodes

    # Return a hash describeing nodes parsed.
    # 
    # {
    #   :name => {
    #     :variables => {
    #       :varname => value,
    #       :varname => value,
    #     }
    #
    #     :resources => {
    #       :type => {
    #         :name => {
    #           :parameter => value,
    #           :parameter => value,
    #         },
    #         :name => {
    #           :parameter => value,
    #           :parameter => value,
    #         },
    #       }
    #     }
    #
    #     :includes => {
    #       :name => {},
    #       :name => {},
    #     }
    #   }
    # }
    def nodes
      @nodes.each do |node|
        node = node.pop

        # Prepare new node hash.
        @nodes_hash[node.name.to_s] = initialize_node_hash

        # Walk through node definition.
        node.code.each do |ast|
          case ast.class.to_s
            when "Puppet::Parser::AST::VarDef"
              handle_vardef(@nodes_hash[node.name.to_s]["variables"], ast)
            when "Puppet::Parser::AST::Resource"
              if ast.type == "class"
                resource_type = @nodes_hash[node.name.to_s]["includes"]
              else
                @nodes_hash[node.name.to_s]["resources"][ast.type] = {}
                resource_type = @nodes_hash[node.name.to_s]["resources"][ast.type]
              end

              handle_resource(resource_type, ast)
            when "Puppet::Parser::AST::Function"
              handle_function(@nodes_hash[node.name.to_s]["includes"], ast)
            else
              # Just skip unknown AST types.
              next
          end
        end
      end

      @nodes_hash
    end

    def initialize_node_hash
      {
        "variables" => {},
        "resources" => {},
        "includes"  => {},
      }
    end


    # Read parameters from parsed object, returns hash of parameters and default
    # values
    def parameters
      result = (defined? @object.arguments) ? @object.arguments : {}
      result
    end

    # Read class from parsed object, returns string containing class
    def klass
      @object.name if (defined? @object.class.name)
    end

    # Read RDOC contents from parsed object, returns hash of paragraph headings
    # and the following paragraph contents
    #(i.e. parameter and parameter documentation)
    def docs
      if !@object.doc.nil?
        rdoc            = RDoc::Markup.parse(@object.doc)
        docs            = {}

        rdoc.parts.each do |part|
          if part.respond_to?(:items)
            part.items.each do |item|
              # Skip rdoc items that aren't paragraphs
              next unless (item.parts.to_s.scan("RDoc::Markup::Paragraph") == ["RDoc::Markup::Paragraph"])
              # Documentation must be a list - if there's no label then skip
              next if item.label.nil?
              key       = item.label.tr('^A-Za-z0-9_-', '')
              docs[key] = item.parts.first.parts
            end # do item
          end # endif
        end # do parm
        docs
      end # if nil?
    end # def docs
  end # class Parser
end # module PuppetParse
