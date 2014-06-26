require "midas-touch/version"
require "midas-touch/filter"
require "midas-touch/validation"
require "midas-touch/input"
require "midas-touch/input_group"

module MidasTouch

  @@filters     = Hash.new
  @@validations = Hash.new

  class << self

    def register_filter(filter)
      @@filters[filter.name] = filter
    end

    def find_filter(name)
      @@filters.fetch(name.to_sym)
    end

    def register_validation(validation)
      @@validations[validation.name] = validation
    end

    def find_validation(name)
      @@validations.fetch(name.to_sym)
    end

  end

end

if self.class.const_defined?(:Sinatra)
  require "sinatra/midas-touch"
end
