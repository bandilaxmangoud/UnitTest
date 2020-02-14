module MyHelper
end

class Array

  # array filter extension
  def filter(hash)
    name_sym = hash.keys.first.to_sym
    result = self.find { |item| item[name_sym] == hash[hash.keys.first] }
  end
end
