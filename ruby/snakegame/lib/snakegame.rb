# frozen_string_literal: true

require_relative "snakegame/version"

require_relative "snakegame/errors/hit_tail_error"
require_relative "snakegame/errors/invalid_direction_error"
require_relative "snakegame/models/coordinate"
require_relative "snakegame/models/snake"
require_relative "snakegame/services/game_service"

module Snakegame
  class Error < StandardError; end
  # Your code goes here...
end
