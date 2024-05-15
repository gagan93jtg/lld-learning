module Tictactoe
  module Errors
    class DuplicatePlayerNameError < StandardError
      def initialize(message = "Player names should be unique")
      end
    end
  end
end
