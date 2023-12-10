module Snakesladders
  module Models
    class Snake
      attr_accessor :start_point, :end_point

      def initialize(start_point, end_point)
        self.start_point = start_point
        self.end_point = end_point

        validate_snake
      end

      private def validate_snake
        raise ::Snakesladders::Errors::InvalidLadderError.new("A snake should end at a lower position than start position") if end_point > start_point
      end
    end
  end
end
