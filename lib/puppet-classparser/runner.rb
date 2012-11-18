require 'puppet-classparser'

module PuppetClassParser  
  class Runner
  
    def run(files)
      output = {}
      files.each do |file|
        content          = PuppetClassParse.new(file)
        result           = {
          content.class  => {
            'parameters' => content.parameters.paramflat,
            'docs'       => content.docs
          }
        }
        output = output.merge(result)
      end

      output
    end
    
    
  end #class Runner
end #module PuppetClassParser