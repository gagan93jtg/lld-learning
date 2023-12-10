RSpec.describe Snakesladders::Models::Dice do
  context "verify dice roll value within range" do
    subject { Snakesladders::Models::Dice.new(6) }

    it "verifies dice roll value within range" do
      expect(subject.roll < 6).to be_truthy
    end
  end
end
