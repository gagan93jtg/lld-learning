module Tictactoe
  module Models
    class Game
      VALID_SYMBOLS = %w(O X)
      attr_accessor :players, :board, :last_turn, :winner, :draw

      def initialize(board_size)
        self.board = Tictactoe::Models::Board.new(board_size)
        self.players = []
        self.draw = false
      end

      def add_player(name, symbol)
        check_if_more_than_two_players!
        check_invalid_symbol!(symbol)
        check_duplicate_symbol!(symbol)
        check_duplicate_player_name!(name)

        player = Player.new(name, symbol)
        players << player
        self.last_turn ||= player
      end

      def play(x, y)
        puts "place [#{last_turn.symbol}] for #{last_turn.name} at [#{x}],[#{y}]"
        board.place(last_turn.symbol, x, y)
        board.print if Tictactoe.print_matrix_on_each_move?
        check_winner?
        check_draw?
        switch_turn
      end

      private def check_winner?
        if board.has_winner?
          self.winner = last_turn
          puts "Winner: #{winner.name}"
        end
      end

      private def check_draw?
        if board.draw?
          self.draw = true
          puts "Game Draw"
        end
      end

      private def switch_turn
        self.last_turn = (last_turn == players[0] ? players[1] : players[0])
      end

      private def check_invalid_symbol!(symbol)
        raise Tictactoe::Errors::InvalidSymbolError unless VALID_SYMBOLS.include?(symbol.upcase)
      end

      private def check_duplicate_symbol!(symbol)
        return if players.empty?

        raise Tictactoe::Errors::DuplicateSymbolError if players[0].symbol == symbol
      end

      private def check_duplicate_player_name!(name)
        return if players.empty?

        raise Tictactoe::Errors::DuplicatePlayerNameError if players[0].name == name
      end

      private def check_if_more_than_two_players!
        raise Tictactoe::Errors::MoreThanTwoPlayersNotSupportedError if players.count == 2
      end
    end
  end
end
