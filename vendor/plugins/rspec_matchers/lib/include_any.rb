module Spec
  module Matchers
    def include_any(*args)
      IncludeAny.new(*args)
    end
  
    class IncludeAny
      def initialize(*args)
        @args = args
      end
    
      def matches?(target)
        @target = target
        @args.any? { |arg| @target.include?(arg) }
      end
    
      def failure_message
        "expected #{@target.inspect} to include one or more elements from #{@args.inspect}"
      end
    
      def negative_failure_message
        "expected #{@target.inspect} not to include any elements from #{@args.inspect}"
      end
    end
  end
end
