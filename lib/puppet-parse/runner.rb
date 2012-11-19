module PuppetParse
  class Runner
  
    def initialize
    end
  
    def run(files)
      output = {}
      files.each do |file|
        content          = PuppetParse::Parser.new(file)
        result           = {
          content.klass  => {
            'parameters' => content.parameters.paramflat,
            'docs'       => content.docs
          }
        }
        output = output.merge(result)
      end
      
      output
    end
    
    
  end #class Runner
end #module PuppetParse