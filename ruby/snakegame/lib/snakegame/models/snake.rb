module Snakegame
  module Models
    class Snake
      VALID_DIRECTIONS = %i(left right top bottom)
      GROWTH_STEP = 3
      attr_accessor :coordinates, :current_step, :board_size, :last_direction

      def initialize(initial_size, board_size)
        self.coordinates = Array.new
        self.current_step = 1
        self.board_size = board_size
        self.last_direction = :right
        grow_initial(initial_size)
      end

      def move!(direction)
        validate_direction!(direction)
        return if should_nullify_move?(direction)

        new_x = coordinates[-1].x
        new_y = coordinates[-1].y
        growth_x = new_x
        growth_y = new_y

        if direction == :left
          new_x -= 1
          growth_x = new_x - 1
        elsif direction == :right
          new_x += 1
          growth_x = new_x + 1
        elsif direction == :top
          new_y -= 1
          growth_y = new_y - 1
        elsif direction == :bottom
          new_y += 1
          growth_y = new_y + 1
        end

        coordinate = normalize(Coordinate.new(new_x, new_y))
        check_collission!(coordinate)
        coordinates << coordinate
        grow_snake!(growth_x, growth_y)
        coordinates.shift
        self.current_step += 1
        self.last_direction = direction

        puts "Step: #{current_step}, Coordinates: #{coordinates.map(&:to_s)}"
      end

      private def grow_snake!(growth_x, growth_y)
        return unless should_grow_snake?

        puts "Growing..."
        growth_coordinate = normalize(Coordinate.new(growth_x, growth_y))
        check_collission!(growth_coordinate)
        coordinates << growth_coordinate
        self.current_step = 0
      end

      private def check_collission!(coordinate)
        raise Snakegame::Errors::HitTailError if coordinates.include?(coordinate)
      end

      private def should_grow_snake?
        current_step == GROWTH_STEP
      end

      private def should_nullify_move?(direction)
        (direction == :left && last_direction == :right) ||
        (direction == :right && last_direction == :left) ||
        (direction == :top && last_direction == :bottom) ||
        (direction == :bottom && last_direction == :top)
      end

      private def validate_direction!(direction)
        unless VALID_DIRECTIONS.include?(direction)
          raise Snakegame::Errors::InvalidDirectionError.new("Invalid direction")
        end
      end

      private def normalize(coordinate)
        coordinate.x %= board_size if coordinate.x > board_size
        coordinate.x = board_size - coordinate.x if coordinate.x <= 0

        coordinate.y %= board_size if coordinate.y > board_size
        coordinate.y = board_size - coordinate.y if coordinate.y <= 0

        coordinate
      end

      private def grow_initial(initial_size)
        initial_size.times do |time|
          self.coordinates << Snakegame::Models::Coordinate.new(time + 1, 1)
        end
      end
    end
  end
end
