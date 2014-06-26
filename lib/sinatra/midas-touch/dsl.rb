module Sinatra
  module MidasTouch
    class DSL

      attr_reader :group

      def initialize(params)
        @params = params
        @group = ::MidasTouch::InputGroup.new
      end

      def field(name, *args)
        input = ::MidasTouch::Input.new(name)
        args.each do |rule|
          input.validations << ::MidasTouch.find_validation(rule)
        end
        input.value = @params[name]
        @group.inputs << input
      end

      def filters(*names)
        names.each do |name|
          @group.filters << ::MidasTouch.find_filter(name)
        end
      end

    end
  end
end
