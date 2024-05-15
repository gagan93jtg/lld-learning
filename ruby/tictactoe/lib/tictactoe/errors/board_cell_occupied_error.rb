module Tictactoe
  module Errors
    class BoardCellOccupiedError < StandardError
      def initialize(message = "Board cell is already occupied")
      end
    end
  end
end
