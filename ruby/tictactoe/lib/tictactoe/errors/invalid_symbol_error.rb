module Tictactoe
  module Errors
    class InvalidSymbolError < StandardError
      def initialize(message = "Symbol should be one of #{Tictactoe::Models::Game::VALID_SYMBOLS}")
      end
    end
  end
end
