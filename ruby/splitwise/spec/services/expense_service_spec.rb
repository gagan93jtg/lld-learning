# frozen_string_literal: true

RSpec.describe Splitwise::Services::ExpenseService do
  context "compute_balance spec" do
    before do
      user_service = Splitwise::Services::UserService.new
      @expense_service = Splitwise::Services::ExpenseService.new

      gagan = user_service.create_user(id: 1, name: "Gagan", image_url: nil)
      harman = user_service.create_user(id: 2, name: "Harman", image_url: nil)
      ishmeet = user_service.create_user(id: 3, name: "Ishmeet", image_url: nil)
      sidak = user_service.create_user(id: 4, name: "Sidak", image_url: nil)
      antar = user_service.create_user(id: 5, name: "Antar", image_url: nil)

      ups = []
      ups << Splitwise::Models::UserPaymentShare.new(user: gagan, amount: 1500)
      ups << Splitwise::Models::UserPaymentShare.new(user: harman, amount: 500)
      ups << Splitwise::Models::UserPaymentShare.new(user: ishmeet, amount: 200)
      ups << Splitwise::Models::UserPaymentShare.new(user: sidak, amount: 300)
      @expense_service.add_expense(amount: 2500, user_payment_shares: ups)

      ups = []
      ups << Splitwise::Models::UserPaymentShare.new(user: gagan, amount: 100)
      ups << Splitwise::Models::UserPaymentShare.new(user: harman, amount: 4900)
      ups << Splitwise::Models::UserPaymentShare.new(user: ishmeet, amount: 0)
      ups << Splitwise::Models::UserPaymentShare.new(user: sidak, amount: 0)
      @expense_service.add_expense(amount: 5000, user_payment_shares: ups)
    end

    subject { @expense_service.settle_expenses }

    it "verifies that harman gets 275 from gagan" do
      gagan_settles = subject.find{|settlement| settlement.payer.name == 'Gagan' }
      expect(gagan_settles.payee.name).to eq("Harman")
      expect(gagan_settles.amount).to eq(275.0)
    end

    it "verifies that harman gets 1575 from sidak" do
      sidak_settles = subject.find{|settlement| settlement.payer.name == 'Sidak' }
      expect(sidak_settles.payee.name).to eq("Harman")
      expect(sidak_settles.amount).to eq(1575.0)
    end

    it "verifies that harman gets 1675 from ishmeet" do
      ishmeet_settles = subject.find{|settlement| settlement.payer.name == 'Ishmeet' }
      expect(ishmeet_settles.payee.name).to eq("Harman")
      expect(ishmeet_settles.amount).to eq(1675.0)
    end
  end
end
