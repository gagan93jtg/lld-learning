module Snakesladders
  module Models
    class Player
      attr_accessor :name, :color, :current_cell, :won

      def initialize(name, color)
        self.name = name
        self.color = color
        self.current_cell = -1
        self.won = false
      end
    end
  end
end
