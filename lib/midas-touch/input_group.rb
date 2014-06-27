module MidasTouch
  class InputGroup

    include Enumerable

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

    def [](name)
      input = input(name)
      input.value if input
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
    alias_method :keys, :fields

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

    def invalidate_input(input_name)
      input = input(input_name)
      input.invalidate!
      @failures << input
    end

    def to_h
      Hash[@inputs.map { |input| [input.name, input.value] }]
    end

    def each(&block)
      to_h.each(&block)
    end

  end
end
