module Snakegame
  module Models
    class Coordinate
      attr_accessor :x, :y

      def initialize(x, y)
        self.x = x
        self.y = y
      end

      def to_s
        [x, y].join(", ")
      end

      def ==(other)
        other.x == x && other.y == y
      end

      def eql?(other)
        other.x == x && other.y == y
      end

      def hash
        [x, y].hash
      end
    end
  end
end
