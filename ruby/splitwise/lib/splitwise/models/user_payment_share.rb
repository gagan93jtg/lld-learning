module Splitwise
  module Models
    class UserPaymentShare
      attr_accessor :user, :amount

      def initialize(user:, amount:)
        self.user = user
        self.amount = amount
      end
    end
  end
end
