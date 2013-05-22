class PuppetParse
  class Runner
  
    def initialize
      @output = {
        "nodes"   => {},
        "classes" => {},
      }
    end
  
    def run(files)
      files.each do |file|
        content = PuppetParse::Parser.new(file)

        nodes = content.nodes
        @output["nodes"] = @output["nodes"].merge(nodes) if nodes != {}

        classes = content.classes
        @output["classes"] = @output["classes"].merge(classes) if classes != {}

        #next if content.instance_variable_get('@object').nil? 
        #parameters = (defined? content.parameters) ? content.parameters.paramflat : nil

        #result = {
          #content.klass  => {
          #  'parameters' => parameters,
          #  'docs'       => content.docs
          #}
        #}
        #output = output.merge(classes)
      end
      @output
    end
    
    
  end #class Runner
end #module PuppetParse
