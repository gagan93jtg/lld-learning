module Snakesladders
  module Services
    class GameService
      attr_accessor :board, :dice, :players, :snakes, :ladders

      def initialize(players, snakes, ladders, board_size, dice_range)
        self.players = players
        self.snakes = snakes
        self.ladders = ladders
        self.board = ::Snakesladders::Models::Board.new(board_size, snakes, ladders)
        self.dice = ::Snakesladders::Models::Dice.new(dice_range)
      end

      def run
        loop do
          player = players.shift
          take_turn(player, dice.roll)

          if player.current_cell == board.last_cell
            player.won = true
            puts "Player #{player.name} won"
            break
          else
            players << player
          end
        end
      end

      def take_turn(player, dice_value)
        if player.current_cell == -1
          player.current_cell = 1 if dice_value == 1
        elsif player.current_cell + dice_value > board.last_cell
          puts "[#{player.name}] Dice roll nullified as #{player.current_cell} + #{dice_value} > #{board.last_cell}"
        else
          player.current_cell += dice_value
          if board.snake_points[player.current_cell]
            destination = board.snake_points[player.current_cell]
            puts "[#{player.name}] cut by snake. Going back to #{destination}"
            player.current_cell = destination
          elsif board.ladder_points[player.current_cell]
            destination = board.ladder_points[player.current_cell]
            puts "[#{player.name}] promoted by ladder. Moving to #{destination}"
            player.current_cell = destination
          else
            puts "[#{player.name}] moving to #{player.current_cell} after dice value #{dice_value}"
          end
        end
      end
    end
  end
end
