require 'sinatra/midas-touch/dsl'

module Sinatra
  module MidasTouch
    def form(&block)
      if block_given?
        @form = DSL.new(params)
        @form.instance_eval(&block)
        @form.group.filter!
      end
      @form.group
    end
  end

  helpers MidasTouch
end
