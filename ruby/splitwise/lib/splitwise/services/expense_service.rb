module Splitwise
  module Services
    class ExpenseService
      attr_accessor :expenses

      def initialize
        self.expenses = []
      end

      def add_expense(amount:, user_payment_shares:)
        expenses << Splitwise::Models::Expense.new(amount: amount, user_payment_shares: user_payment_shares)
      end

      def compute_balance
        user_balance_map = Hash.new(0)

        expenses.each do |expense|
          expense.user_payment_shares.each do |payment_share|
            user_balance_map[payment_share.user] += payment_share.amount
          end
        end

        user_balance_map.map do |name, balance|
          Splitwise::Models::UserBalance.new(name: name, balance: balance)
        end
      end

      def settle_expenses
        user_balances = compute_balance

        positive_payments = Splitwise::Models::PriorityQueue.new
        negative_payments = Splitwise::Models::PriorityQueue.new
        settlements = []

        user_balances.each do |user_balance|
          if user_balance.balance >= 0
            positive_payments << user_balance
          else
            negative_payments << user_balance
          end
        end

        loop do
          positive_payment = positive_payments.shift
          negative_payment = negative_payments.shift
          break if !positive_payment && !negative_payment

          amount_to_transfer = [positive_payment.balance, negative_payment.balance.abs].min
          remaining_amount = positive_payment.balance - negative_payment.balance.abs
          settlements << Splitwise::Models::UserSettlement.new(
            payer: negative_payment.name,
            payee: positive_payment.name,
            amount: amount_to_transfer
          )

          if remaining_amount > 0
            positive_payments << Splitwise::Models::UserBalance.new(name: positive_payment.name, balance: remaining_amount)
          elsif remaining_amount < 0
            negative_payments << Splitwise::Models::UserBalance.new(name: negative_payment.name, balance: remaining_amount)
          end
        end

        settlements
      end
    end
  end
end
