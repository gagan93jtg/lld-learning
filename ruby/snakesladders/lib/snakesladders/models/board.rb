module Snakesladders
  module Models
    class Board
      attr_accessor :size, :snake_points, :ladder_points, :all_points

      def initialize(size, snakes, ladders)
        self.size = size
        self.all_points = {}
        self.snake_points = {}
        self.ladder_points = {}

        mark_snakes(snakes)
        mark_ladders(ladders)
      end

      def mark_snakes(snakes)
        snakes.each do |snake|
          if all_points[snake.start_point] || all_points[snake.end_point]
            raise ::Snakesladders::Errors::OverlappingPointError.new("Snake overlaps with existing snake or ladder #{snake.start_point}, #{snake.end_point}")
          end

          raise ::Snakesladders::Errors::BoardOutOfBoundError.new("Snake start_point: #{snake.start_point} is outside board: #{last_cell}") if snake.start_point > last_cell

          all_points[snake.start_point] = 1
          all_points[snake.end_point] = 1
          snake_points[snake.start_point] = snake.end_point
        end
      end

      def mark_ladders(ladders)
        ladders.each do |ladder|
          if all_points[ladder.start_point] || all_points[ladder.end_point]
            raise ::Snakesladders::Errors::OverlappingPointError.new("ladder overlaps with existing ladder or ladder #{ladder.start_point}, #{ladder.end_point}")
          end

          raise ::Snakesladders::Errors::BoardOutOfBoundError.new("ladder start_point: #{ladder.end_point} is outside board: #{last_cell}") if ladder.end_point > last_cell

          all_points[ladder.start_point] = 1
          all_points[ladder.end_point] = 1
          ladder_points[ladder.start_point] = ladder.end_point
        end
      end

      def last_cell
        size * size
      end
    end
  end
end
