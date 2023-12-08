module Splitwise
  module Models
    class UserSettlement
      attr_accessor :payer, :payee, :amount

      def initialize(payer:, payee:, amount:)
        self.payer = payer                   # who pays
        self.payee = payee                   # who gets paid
        self.amount = amount                 # the amount
      end

      def to_s
        "#{payer.name} pays #{payee.name} Rs. #{amount}"
      end
    end
  end
end
