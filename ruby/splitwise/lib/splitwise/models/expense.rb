module Splitwise
  module Models
    class Expense
      attr_accessor :amount, :user_payment_shares

      # amount              - total amount we're splitting
      # user_payment_shares - amount paid by each user
      def initialize(amount:, user_payment_shares:)
        self.amount = amount
        self.user_payment_shares = user_payment_shares

        validate_amount_with_share!
        normalize_shares
      end

      private def validate_amount_with_share!
        raise ArgumentError, "Payments should sum to amount: [#{amount}]" unless user_payment_shares.sum(&:amount) == amount
      end

      private def normalize_shares
        per_user_share = (amount.to_f / user_payment_shares.count).round(2)
        user_payment_shares.each { |user_share| user_share.amount -= per_user_share }
      end
    end
  end
end
