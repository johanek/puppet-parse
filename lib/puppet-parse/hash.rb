class Hash
  
  def paramflat
    result = {}

    self.each do |key, val|
      result[key] = val.value
    end

    result
  end
  
end