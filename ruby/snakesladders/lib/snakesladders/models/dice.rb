module Snakesladders
  module Models
    class Dice
      attr_accessor :range

      def initialize(range)
        self.range = range
      end

      def roll
        ((rand * 10000) % 6).to_i
      end
    end
  end
end
