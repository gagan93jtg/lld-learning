module Tictactoe
  module Errors
    class InsufficientPlayersError < StandardError
      def initialize(message = "Exactly two players needed")
      end
    end
  end
end
