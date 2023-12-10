# frozen_string_literal: true

require_relative "snakesladders/version"

require_relative "snakesladders/errors/board_out_of_bound_error"
require_relative "snakesladders/errors/invalid_ladder_error"
require_relative "snakesladders/errors/invalid_snake_error"
require_relative "snakesladders/errors/overlapping_point_error"

require_relative "snakesladders/models/board"
require_relative "snakesladders/models/dice"
require_relative "snakesladders/models/ladder"
require_relative "snakesladders/models/player"
require_relative "snakesladders/models/snake"

require_relative "snakesladders/services/game_service"

module Snakesladders
  class << self

    def run
      ::Snakesladders::Services::GameService.new(players, snakes, ladders, 10, 6).run
    end

    def players
      [
        ::Snakesladders::Models::Player.new("Gagan", "blue"),
        ::Snakesladders::Models::Player.new("Sonia", "red"),
      ]
    end

    def snakes
      [
        ::Snakesladders::Models::Snake.new(36, 6),
        ::Snakesladders::Models::Snake.new(32, 10),
        ::Snakesladders::Models::Snake.new(37, 5),
        ::Snakesladders::Models::Snake.new(63, 18),
        ::Snakesladders::Models::Snake.new(88, 24),
        ::Snakesladders::Models::Snake.new(97, 56),
      ]
    end

    def ladders
      [
        ::Snakesladders::Models::Ladder.new(3, 38),
        ::Snakesladders::Models::Ladder.new(4, 14),
        ::Snakesladders::Models::Ladder.new(28, 74),
        ::Snakesladders::Models::Ladder.new(71, 92),
      ]
    end
  end
end
