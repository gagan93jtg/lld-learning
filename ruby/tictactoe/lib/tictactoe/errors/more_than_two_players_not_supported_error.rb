module Tictactoe
  module Errors
    class MoreThanTwoPlayersNotSupportedError < StandardError
      def initialize(message = "Only two players are supported at max")
      end
    end
  end
end


