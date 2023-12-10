RSpec.describe Snakesladders::Services::GameService do
  context "Values other than 1 do not start the game" do
    let(:gagan)   { Snakesladders::Models::Player.new("Gagan", "blue") }
    let(:sonia)   { Snakesladders::Models::Player.new("Sonia", "red") }
    let(:players) { [gagan, sonia] }
    subject       { Snakesladders::Services::GameService.new(players, [], [], 10, 6) }

    it "verifies gagan cannot start game with value other than 1" do
      subject.take_turn(gagan, 4)
      expect(gagan.current_cell).to eq(-1)
    end

    it "verifies gagan can start game with value 1" do
      subject.take_turn(gagan, 1)
      expect(gagan.current_cell).to eq(1)
    end
  end

  context "Do normal dice movement" do
    let(:gagan)   { Snakesladders::Models::Player.new("Gagan", "blue") }
    subject       { Snakesladders::Services::GameService.new([gagan], [], [], 10, 6) }

    before        { gagan.current_cell = 20 }
    it "verifies normal movement" do
      subject.take_turn(gagan, 4)
      expect(gagan.current_cell).to eq(24)
    end
  end

  context "Test snakes cut" do
    let(:gagan)   { Snakesladders::Models::Player.new("Gagan", "blue") }
    let(:snake)   { Snakesladders::Models::Snake.new(30, 10) }
    subject       { Snakesladders::Services::GameService.new([gagan], [snake], [], 10, 6) }

    before        { gagan.current_cell = 25 }
    it "verifies cut" do
      subject.take_turn(gagan, 5)
      expect(gagan.current_cell).to eq(10)
    end
  end

  context "Test Ladder promotion" do
    let(:gagan)   { Snakesladders::Models::Player.new("Gagan", "blue") }
    let(:ladder)  { Snakesladders::Models::Ladder.new(10, 30) }
    subject       { Snakesladders::Services::GameService.new([gagan], [], [ladder], 10, 6) }

    before        { gagan.current_cell = 9 }
    it "verifies promotion" do
      subject.take_turn(gagan, 1)
      expect(gagan.current_cell).to eq(30)
    end
  end

  context "Test boundary condition" do
    let(:gagan)   { Snakesladders::Models::Player.new("Gagan", "blue") }
    subject       { Snakesladders::Services::GameService.new([gagan], [], [], 10, 6) }

    before        { gagan.current_cell = 99 }
    it "verifies promotion" do
      subject.take_turn(gagan, 5)
      expect(gagan.current_cell).to eq(99)
    end
  end

  context "Test won" do
    let(:gagan)   { Snakesladders::Models::Player.new("Gagan", "blue") }
    subject       { Snakesladders::Services::GameService.new([gagan], [], [], 10, 6) }

    before        { gagan.current_cell = 99 }
    it "verifies promotion" do
      subject.take_turn(gagan, 1)
      expect(gagan.current_cell).to eq(100)
    end
  end
end
