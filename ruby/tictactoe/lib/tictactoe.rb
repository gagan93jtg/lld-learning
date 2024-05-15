# frozen_string_literal: true

require_relative "tictactoe/version"

require_relative "tictactoe/errors/duplicate_player_name_error"
require_relative "tictactoe/errors/duplicate_symbol_error"
require_relative "tictactoe/errors/invalid_symbol_error"
require_relative "tictactoe/errors/more_than_two_players_not_supported_error"
require_relative "tictactoe/errors/board_cell_occupied_error"
require_relative "tictactoe/errors/insufficient_players_error"
require_relative "tictactoe/errors/player_information_missing_error"
require_relative "tictactoe/errors/invalid_coordinates_error"

require_relative "tictactoe/models/board"
require_relative "tictactoe/models/game"
require_relative "tictactoe/models/player"

require_relative "tictactoe/services/runner"


module Tictactoe
  class Error < StandardError; end

  # set to false in test cases. Eases testing otherwise. Could be driven from ENV variable
  def self.print_matrix_on_each_move?
    false
  end
end

# r = Tictactoe::Services::Runner.new
# r.add_players
# r.play
