module Midas
  class InputGroup

    attr_accessor :inputs
    attr_accessor :filters
    attr_accessor :validations

    def initialize
      @inputs      = Array.new
      @filters     = Array.new
      @validations = Array.new
      @failures    = Array.new
    end

    def input(name)
      name = name.to_sym
      @inputs.find { |input| input.name == name }
    end

    def filter!
      @inputs.each do |input|
        filters.each { |filter| input.value = filter.call(input.value) }
        input.filter!
      end
    end

    def fields
      @inputs.map(&:name)
    end

    def valid?
      @failures = Array.new
      @inputs.each do |input|
        validations.each do |rule|
          if !rule.call(input.value)
            @failures << input
            break
          end
        end
        @failures << input unless input.valid?
      end
      @failures.uniq!
      @failures.empty?
    end

    def error_on?(name)
      @failures.include?(input(name))
    end

  end
end
