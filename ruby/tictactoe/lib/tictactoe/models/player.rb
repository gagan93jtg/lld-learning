module Tictactoe
  module Models
    class Player
      attr_accessor :name, :symbol

      def initialize(name, symbol)
        raise PlayerInformationMissingError if !name || !symbol || name.empty? || symbol.empty?

        self.name = name
        self.symbol = symbol
      end
    end
  end
end
