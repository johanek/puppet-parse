class Hash
  
  def paramflat
    result = {}

    self.each do |key, val|
      if val.is_a?(Puppet::Parser::AST::ASTArray)
        result[key] = []
        val.each do |item|
          result[key] << item.to_s.gsub("\"",'')
        end
      else
        result[key] = (defined? val.value) ? val.value : nil
      end
    end

    result
  end
  
end
