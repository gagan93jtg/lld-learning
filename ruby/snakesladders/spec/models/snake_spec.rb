RSpec.describe Snakesladders::Models::Snake do
  context "Invalid snake" do
    it "throws an exception on invalid snake" do
      expect { Snakesladders::Models::Snake.new(10, 30) }.to raise_error(::Snakesladders::Errors::InvalidLadderError)
    end
  end

  context "Valid snake" do
    subject{ Snakesladders::Models::Snake.new(30, 10) }

    it "verifies correct start point" do
      expect(subject.start_point).to eq(30)
    end

    it "verifies correct end point" do
      expect(subject.end_point).to eq(10)
    end
  end
end
