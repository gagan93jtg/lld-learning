# cloudn't find an internal implementation of heap/priority queue in ruby std library
# not wanting to include gems to wrapping this in a class using arrays
module Splitwise
  module Models
    class PriorityQueue

      def initialize
        @array = Array.new
      end

      def shift
        @array.shift
      end

      def << (item)
        @array << item
      end
    end
  end
end
