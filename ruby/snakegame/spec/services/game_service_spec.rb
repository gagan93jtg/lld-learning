RSpec.describe Snakegame::Services::GameService do
  context "Verify initial size" do
    subject { described_class.new(5, 3) }
    let(:first_coordinate) { Snakegame::Models::Coordinate.new(1, 1) }
    let(:second_coordinate) { Snakegame::Models::Coordinate.new(2, 1) }
    let(:third_coordinate) { Snakegame::Models::Coordinate.new(3, 1) }

    it "expects these coordinates" do
      expect(subject.snake.coordinates).to eq([first_coordinate, second_coordinate, third_coordinate])
    end
  end

  context "Invalid direction" do
    subject { described_class.new(5, 3) }

    it "verifies exception raised on invalid move" do
      expect { subject.move!(:random_direction).to raise_error(Snakegame::Errors::InvalidDirectionError) }
    end
  end

  context "Snake growth" do
    subject { described_class.new(10, 3) }
    let(:growth_coordinate) { Snakegame::Models::Coordinate.new(5, 1) }
    before do
      subject.snake.current_step = 3
      subject.snake.move!(:right)
    end

    it "should grow snake by an extra coordinate" do
      expect(subject.snake.coordinates.count).to eq(4)
    end

    it "should expect last coordinate as growth coordinate" do
      expect(subject.snake.coordinates.last).to eq(growth_coordinate)
    end
  end

  context "Move nullification" do
    subject { described_class.new(10, 3) }
    before  { subject.snake.move!(:left) }

    it "should not change anything in the snake" do
      expect(subject.snake.coordinates.count).to eq(3)
    end
  end

  context "Move normalization" do
    context "Right wall end" do
      subject { described_class.new(10, 3) }
      let(:new_coordinate) { Snakegame::Models::Coordinate.new(1, 1) }
      let(:coordinates) do
        [
          Snakegame::Models::Coordinate.new(8, 1),
          Snakegame::Models::Coordinate.new(9, 1),
          Snakegame::Models::Coordinate.new(10, 1),
        ]
      end

      before do
        subject.snake.coordinates = coordinates
        subject.snake.move!(:right)
      end

      it "should expect next coorindate to cross wall and come back to x=1" do
        expect(subject.snake.coordinates.last).to eq(new_coordinate)
      end
    end

    context "Left wall end" do
      subject { described_class.new(10, 3) }
      let(:new_coordinate) { Snakegame::Models::Coordinate.new(10, 1) }
      let(:coordinates) do
        [
          Snakegame::Models::Coordinate.new(3, 1),
          Snakegame::Models::Coordinate.new(2, 1),
          Snakegame::Models::Coordinate.new(1, 1),
        ]
      end

      before do
        subject.snake.coordinates = coordinates
        subject.snake.last_direction = :left
        subject.snake.move!(:left)
      end

      it "should expect next coorindate to cross wall and come back to x=10" do
        expect(subject.snake.coordinates.last).to eq(new_coordinate)
      end
    end

    context "Top wall end" do
      subject { described_class.new(10, 3) }
      let(:new_coordinate) { Snakegame::Models::Coordinate.new(4, 10) }
      let(:coordinates) do
        [
          Snakegame::Models::Coordinate.new(4, 3),
          Snakegame::Models::Coordinate.new(4, 2),
          Snakegame::Models::Coordinate.new(4, 1),
        ]
      end

      before do
        subject.snake.coordinates = coordinates
        subject.snake.last_direction = :top
        subject.snake.move!(:top)
      end

      it "should expect next coorindate to cross wall and come back to y=10" do
        expect(subject.snake.coordinates.last).to eq(new_coordinate)
      end
    end

    context "Bottom wall end" do
      subject { described_class.new(10, 3) }
      let(:new_coordinate) { Snakegame::Models::Coordinate.new(8, 1) }
      let(:coordinates) do
        [
          Snakegame::Models::Coordinate.new(8, 8),
          Snakegame::Models::Coordinate.new(8, 9),
          Snakegame::Models::Coordinate.new(8, 10),
        ]
      end

      before do
        subject.snake.coordinates = coordinates
        subject.snake.last_direction = :bottom
        subject.snake.move!(:bottom)
      end

      it "should expect next coorindate to cross wall and come back to y=1" do
        expect(subject.snake.coordinates.last).to eq(new_coordinate)
      end
    end
  end

  context "Hitting tail" do
    context "Straight movement" do
      subject { described_class.new(10, 3) }
      before do
        20.times { subject.snake.move!(:right) }
      end

      it "should raise tail hit exception" do
        expect { subject.snake.move!(:right) }.to raise_error(Snakegame::Errors::HitTailError)
      end
    end

    context "Complex movement" do
      subject { described_class.new(10, 3) }
      before do
        15.times { subject.snake.move!(:right) }
        subject.snake.move!(:bottom)
        subject.snake.move!(:left)
      end

      it "should raise tail hit exception" do
        expect { subject.snake.move!(:top) }.to raise_error(Snakegame::Errors::HitTailError)
      end
    end
  end
end
