RSpec.describe Snakesladders::Models::Board do
  context "verify board size" do
    subject { described_class.new(10, [], []) }

    it "verifies board last_cell as 100" do
      expect(subject.last_cell).to eq(100)
    end
  end

  context "overlapping snakes and/or ladders" do
    let(:snakes) { [Snakesladders::Models::Snake.new(84, 5)] }
    let(:ladders) { [Snakesladders::Models::Ladder.new(84, 95)] }

    it "verifies exception raised" do
      expect{described_class.new(10, snakes, ladders)}.to raise_error(::Snakesladders::Errors::OverlappingPointError)
    end
  end

  context "snakes out of range" do
    let(:snakes) { [Snakesladders::Models::Snake.new(101, 99)] }

    it "verifies exception raised" do
      expect{described_class.new(10, snakes, [])}.to raise_error(::Snakesladders::Errors::BoardOutOfBoundError)
    end
  end

  context "ladders out of range" do
    let(:ladders) { [Snakesladders::Models::Ladder.new(99, 101)] }

    it "verifies exception raised" do
      expect{described_class.new(10, [], ladders)}.to raise_error(::Snakesladders::Errors::BoardOutOfBoundError)
    end

  end
end
