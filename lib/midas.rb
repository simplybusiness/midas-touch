require "midas/version"
require "midas/filter"
require "midas/validation"
require "midas/input"
require "midas/input_group"

module Midas

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
  require "sinatra/midas"
end
