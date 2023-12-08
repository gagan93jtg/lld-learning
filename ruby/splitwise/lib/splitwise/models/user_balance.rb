module Splitwise
  module Models
    class UserBalance
      include Comparable

      attr_accessor :name, :balance

      def initialize(name:, balance:)
        self.name = name
        self.balance = balance
      end

      def <=>(other)
        balance <=> other.balance
      end
    end
  end
end
