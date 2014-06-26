module Sinatra
  module Midas
    class DSL

      attr_reader :group

      def initialize(params)
        @params = params
        @group = ::Midas::InputGroup.new
      end

      def field(name, *args)
        input = ::Midas::Input.new(name)
        args.each do |rule|
          input.validations << ::Midas.find_validation(rule)
        end
        input.value = @params[name]
        @group.inputs << input
      end

      def filters(*names)
        names.each do |name|
          @group.filters << ::Midas.find_filter(name)
        end
      end

    end
  end
end
