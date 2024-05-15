RSpec.describe Tictactoe::Models::Game do
  describe "Initial state" do
    subject(:game) { described_class.new(3) }
    it "expects players to be empty" do
      expect(game.players).to be_empty
    end

    it "expects board to be initialized" do
      expect(game.board).not_to be_nil
    end

    it "expects draw to be falsy" do
      expect(game.draw).to be_falsy
    end
  end

  describe "Adding players" do
    describe "Invalid cases" do
      subject(:game) { described_class.new(3) }

      context "Invalid symbols" do
        it "expects an exception" do
          expect { game.add_player("Gagan", "1") }.to raise_error(Tictactoe::Errors::InvalidSymbolError)
        end
      end

      context "Duplicate symbols" do
        before do
          game.add_player("Gagan", "O")

        end

        it "expects an exception" do
          expect { game.add_player("Gagan2", "O") }.to raise_error(Tictactoe::Errors::DuplicateSymbolError)
        end
      end

      context "Duplicate Name" do
        before do
          game.add_player("Gagan", "O")
        end

        it "expects an exception" do
          expect { game.add_player("Gagan", "X") }.to raise_error(Tictactoe::Errors::DuplicatePlayerNameError)
        end

      end

      context "More than 2 players" do
        before do
          game.add_player("Gagan1", "O")
          game.add_player("Gagan2", "X")
        end

        it "expects an exception" do
          expect { game.add_player("Gagan3", "O") }.to raise_error(Tictactoe::Errors::MoreThanTwoPlayersNotSupportedError)
        end
      end
    end
  end

  describe "Moves switch" do
    subject(:game) { described_class.new(3) }
    before do
      game.add_player("Gagan1", "O")
      game.add_player("Gagan2", "X")
    end

    context "player chances" do
      it "expects first player to play first" do
        expect(game.last_turn.name).to eq("Gagan1")
      end

      it "expects second player to play after them" do
        game.play(0, 0)
        expect(game.last_turn.name).to eq("Gagan2")
      end

      it "expects no winner" do
        expect(game.winner).to be_nil
      end

      it "expects no draw" do
        expect(game.draw).to be_falsy
      end
    end
  end

  describe "Winning case" do
    subject(:game) { described_class.new(3) }
    before do
      game.add_player("Gagan1", "O")
      game.add_player("Gagan2", "X")
      game.play(0, 0)
      game.play(0, 1)
      game.play(1, 0)
      game.play(1, 1)
      game.play(2, 0)
    end

    it "expects winner to be found" do
      expect(game.winner).not_to be_nil
    end

    it "verify winner name" do
      expect(game.winner.name).to eq("Gagan1")
    end
  end

  describe "Draw case" do
    subject(:game) { described_class.new(3) }
    before do
      game.add_player("Gagan1", "O")
      game.add_player("Gagan2", "X")
      game.play(0, 0)
      game.play(0, 1)
      game.play(0, 2)
      game.play(1, 0)
      game.play(1, 1)
      game.play(1, 2)
      game.play(2, 0)
      game.play(2, 1)
      game.play(2, 2)
    end

    it "expects game to be drawn" do
      expect(game.draw).to be_truthy
    end

  end
end
