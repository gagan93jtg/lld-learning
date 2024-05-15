module Tictactoe
  module Errors
    class DuplicateSymbolError < StandardError
      def initialize(message = "Players should have unique symbols")
      end
    end
  end
end
