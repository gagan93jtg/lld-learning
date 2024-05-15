module Tictactoe
  module Models
    class Board
      attr_accessor :size, :cells, :number_of_moves

      def initialize(size)
        self.size = size
        self.cells = Array.new(size) { Array.new(size) { nil } }
        self.number_of_moves = 0
      end

      def place(symbol, x, y)
        raise Tictactoe::Errors::InvalidCoordinatesError if x >= size || y >= size
        raise Tictactoe::Errors::BoardCellOccupiedError if cells[x][y]

        cells[x][y] = symbol
        self.number_of_moves += 1
      end

      def print
        line = ""
        (size * size).times { line += "-" }
        puts line

        0.upto(size - 1) do |row|
          row_line  = ""
          0.upto(size - 1) do |col|
            row_line += "#{cells[row][col]}  "
          end
          puts row_line
        end

        puts line
      end


      def has_winner?
        # no point checking winner case if atleast half board is empty
        return false if ( ((size * 2)  - 1 ) > number_of_moves )

        horizontal_winner? || vertical_winner? || diagonal_winner?
      end

      def draw?
        size * size == number_of_moves
      end

      private def horizontal_winner?
        0.upto(size - 1).each do |row|
          return true if cells[row].all? { |el| el == "O" } || cells[row].all? {|el| el == "X" }
        end

        false
      end

      private def vertical_winner?
        (0...size - 1).each do |col|
          return true if (0...size - 1).all? { |row| cells[row][col] == "O" } || (0...size).all? { |row| cells[row][col] == "X" }
        end

        false
      end

      private def diagonal_winner?
        straight_diagonal_winner? || opposite_diagonal_winner?
      end

      private def straight_diagonal_winner?
        first_element = cells[0][0]
        0.upto(size - 1).each do |diagonal|
          return false if cells[diagonal][diagonal] != first_element
        end

        true
      end

      private def opposite_diagonal_winner?
        first_element = cells[0][size - 1]
        (size - 1).downto(0).each do |diagonal|
          return false if cells[diagonal][size - diagonal - 1] != first_element
        end

        true
      end
    end
  end
end
