class Hash
  
  def paramflat
    result = {}

    self.each do |key, val|
      result[key] = (defined? val.value) ? val.value : nil
    end

    result
  end
  
end
