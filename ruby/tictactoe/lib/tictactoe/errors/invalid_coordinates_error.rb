module Tictactoe
  module Errors
    class InvalidCoordinatesError < StandardError
      def initialize(message = "Coordinate out of bound")
      end
    end
  end
end



