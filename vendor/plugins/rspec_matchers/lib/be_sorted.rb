module Spec
  module Matchers
    def be_sorted(&block)
      BeSorted.new(&block)
    end
    
    class BeSorted
      def initialize(&block)
        @sort_block = block
      end
      
      def matches?(actual)
        @actual = actual
        @expected = @actual.sort(&@sort_block)
        @actual == @expected
      end
      
      def failure_message
        "expected collection in order:\n" +
        @expected.inspect +
        "\nbut got order:\n" +
        @actual.inspect
      end
      
      def negative_failure_message
        "expected collection not to be in order:\n" +
        @actual.inspect
      end
    end
  end
end
