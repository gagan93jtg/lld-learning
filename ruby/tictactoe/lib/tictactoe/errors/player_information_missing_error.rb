module Tictactoe
  module Errors
    class PlayerInformationMissingError < StandardError
      def initialize(message = "Player name and symbol are mandatory")
      end
    end
  end
end


