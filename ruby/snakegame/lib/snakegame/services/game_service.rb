module Snakegame
  module Services
    class GameService
      attr_accessor :snake

      def initialize(board_size, snake_initial_size)
        self.snake = Snakegame::Models::Snake.new(snake_initial_size, board_size)
      end

      # Sample game over case
      def run
        loop do
          begin
            snake.move!(:right)
            snake.move!(:right)
            snake.move!(:right)
            snake.move!(:right)
            snake.move!(:right)
            snake.move!(:right)
            snake.move!(:right)
            snake.move!(:bottom)
            snake.move!(:left)
            snake.move!(:top)
          rescue Snakegame::Errors::HitTailError
            puts "Game over"
            break
          end
        end
      end
    end
  end
end
