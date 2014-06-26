module MidasTouch
  class Validation

    attr_accessor :name
    private :name=

    def initialize(name)
      self.name = name.to_sym
    end

    def call(value)
      true
    end

  end
end
