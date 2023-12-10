module Snakesladders
  module Models
    class Ladder
      attr_accessor :start_point, :end_point

      def initialize(start_point, end_point)
        self.start_point = start_point
        self.end_point = end_point

        validate_ladder
      end

      private def validate_ladder
        raise ::Snakesladders::Errors::InvalidLadderError.new("A ladder should start at a smaller value and end at higher value") if start_point > end_point
      end
    end
  end
end
