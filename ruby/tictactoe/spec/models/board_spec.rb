# frozen_string_literal: true

RSpec.describe Tictactoe::Models::Board do
  describe "Confirm board of specific size initialized correctly" do
    subject(:board) { described_class.new(4) }
    it "ensures a board of 4x4" do
      expect(board.size).to eq(4)
    end

    it "ensures 4 rows" do
      expect(board.cells.count).to eq(4)
    end

    it "ensures 4 columns" do
      expect(board.cells[0].count).to eq(4)
    end
  end

  describe "Number of moves initialized correctly" do
    subject(:board) { described_class.new(10) }
    it "ensures no. of moves set to zero" do
      expect(board.number_of_moves).to eq(0)
    end
  end

  describe "Symbol placement" do
    subject(:board) { described_class.new(4) }
    describe "Invalid placement" do
      context "When cell already occupied" do
        before { board.cells[0][0] = "X" }

        it "raises an exception for already occupied cell" do
          expect { board.place("X", 0, 0) }.to raise_error(Tictactoe::Errors::BoardCellOccupiedError)
        end

        it "ensures no. of moves set to zero" do
          expect(board.number_of_moves).to eq(0)
        end
      end

      context "When cell out of bound" do
        it "raises an exception for out of bound" do
          expect { board.place("X", 10, 10) }.to raise_error(Tictactoe::Errors::InvalidCoordinatesError)
        end

        it "ensures no. of moves set to zero" do
          expect(board.number_of_moves).to eq(0)
        end
      end

      context "Valid placement" do
        before { subject.place("X", 0, 0) }
        it "ensures no. of moves set to zero" do
          expect(board.number_of_moves).to eq(1)
        end
      end
    end
  end

  describe "Winner checks" do
    describe "horizontal winner cases" do
      subject(:board) { described_class.new(4) }

      context "first row winner" do
        before do
          board.place("O", 0, 0)
          board.place("X", 1, 0)
          board.place("O", 0, 1)
          board.place("X", 1, 1)
          board.place("O", 0, 2)
          board.place("X", 1, 2)
          board.place("O", 0, 3)
        end

        it "expects 7 moves" do
          expect(board.number_of_moves).to eq(7)
        end

        it "expects a winner" do
          expect(board.has_winner?).to be_truthy
        end

        it "expects a horizontal winner" do
          expect(board.send(:horizontal_winner?)).to be_truthy
        end
      end

      context "last row winner" do
        before do
          board.place("O", 3, 0)
          board.place("X", 1, 0)
          board.place("O", 3, 1)
          board.place("X", 1, 1)
          board.place("O", 3, 2)
          board.place("X", 1, 2)
          board.place("O", 3, 3)
        end

        it "expects 7 moves" do
          expect(board.number_of_moves).to eq(7)
        end

        it "expects a winner" do
          expect(board.has_winner?).to be_truthy
        end

        it "expects a horizontal winner" do
          expect(board.send(:horizontal_winner?)).to be_truthy
        end
      end
    end

    describe "vertical winner cases" do
      subject(:board) { described_class.new(4) }

      context "first column winner" do
        before do
          board.place("O", 0, 0)
          board.place("X", 0, 1)
          board.place("O", 1, 0)
          board.place("X", 1, 1)
          board.place("O", 2, 0)
          board.place("X", 2, 1)
          board.place("O", 3, 0)
        end

        it "expects 7 moves" do
          expect(board.number_of_moves).to eq(7)
        end

        it "expects a winner" do
          expect(board.has_winner?).to be_truthy
        end

        it "expects a vertical winner" do
          expect(board.send(:vertical_winner?)).to be_truthy
        end
      end
    end

    describe "diagonal winner cases" do
      subject(:board) { described_class.new(4) }

      context "straight diagonal" do
        before do
          board.place("O", 0, 0)
          board.place("X", 0, 1)
          board.place("O", 1, 1)
          board.place("X", 1, 2)
          board.place("O", 2, 2)
          board.place("X", 2, 3)
          board.place("O", 3, 3)
        end

        it "expects 7 moves" do
          expect(board.number_of_moves).to eq(7)
        end

        it "expects a winner" do
          expect(board.has_winner?).to be_truthy
        end

        it "expects a diagonal winner" do
          expect(board.send(:diagonal_winner?)).to be_truthy
        end

        it "expects straight_diagonal_winner" do
          expect(board.send(:straight_diagonal_winner?)).to be_truthy
        end
      end

      context "opposite diagonal" do
        before do
          board.place("O", 0, 3)
          board.place("X", 0, 1)
          board.place("O", 1, 2)
          board.place("X", 2, 2)
          board.place("O", 2, 1)
          board.place("X", 2, 3)
          board.place("O", 3, 0)
        end

        it "expects 7 moves" do
          expect(board.number_of_moves).to eq(7)
        end

        it "expects a winner" do
          expect(board.has_winner?).to be_truthy
        end

        it "expects a diagonal winner" do
          expect(board.send(:diagonal_winner?)).to be_truthy
        end

        it "expects opposite_diagonal_winner" do
          expect(board.send(:opposite_diagonal_winner?)).to be_truthy
        end
      end
    end
  end

  describe "Draw checks" do
    subject(:board) { described_class.new(3) }
    before do
      board.place("O", 0, 0)
      board.place("X", 0, 1)
      board.place("X", 0, 2)
      board.place("X", 1, 0)
      board.place("X", 1, 1)
      board.place("0", 1, 2)
      board.place("X", 2, 0)
      board.place("0", 2, 1)
      board.place("O", 2, 2)
    end

    it "expects a draw case" do
      expect(subject.draw?).to be_truthy
    end
  end
end
