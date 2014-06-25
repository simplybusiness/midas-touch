module Midas
  class Input

    attr_accessor :name
    private :name=

    attr_accessor :value
    attr_accessor :filters
    attr_accessor :validations

    def initialize(name)
      self.name        = name.to_sym
      self.filters     = Array.new
      self.validations = Array.new
      @invalidate = false
    end

    def filter!
      filters.each do |filter|
        self.value = filter.call(self.value)
      end
      self.value
    end

    def valid?
      return false if @invalidate
      validations.each do |rule|
        return false if !rule.call(self.value)
      end
      true
    end

    def invalidate!
      @invalidate = true
    end

  end
end
