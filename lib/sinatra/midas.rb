require 'sinatra/midas/dsl'

module Sinatra
  module Midas
    def form(&block)
      if block_given?
        @form = DSL.new(params)
        @form.instance_eval(&block)
        @form.group.filter!
      end
      @form.group
    end
  end

  helpers Midas
end
