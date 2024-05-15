module Tictactoe
  module Services
    class Runner
      attr_accessor :game

      def initialize
        self.game = Tictactoe::Models::Game.new(3)
      end

      def add_players
        game.add_player("Gagan1", "O")
        game.add_player("Gagan2", "X")
      end

      # This method won't be called through test cases. We'll do our own play.
      # This is just to test one case
      # This starts with player1
      def play
        raise InsufficientPlayersError if game.players.count < 2

        game.play(1,1) # Gagan1 places 0 on the center
        game.play(0,2) # Gagan2 places X on the top right
        game.play(2,0) # Gagan1 places 0 on bottom left
        game.play(2,2) # Gagan2 places X on bottom right
        game.play(0,0) # Gagan1 places 0 on top left
        game.play(0,1) # Gagan2 places X on top center
        game.play(1,0) # Gagan1 places 0 on left middle and wins
      end
    end
  end
end
