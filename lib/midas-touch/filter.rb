module MidasTouch
  class Filter

    attr_accessor :name
    private :name=

    def initialize(name)
      self.name = name.to_sym
    end

    def call(value)
      value
    end

  end
end
