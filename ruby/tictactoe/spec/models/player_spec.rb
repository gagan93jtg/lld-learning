# frozen_string_literal: true

RSpec.describe Tictactoe::Models::Player do
  describe "Invalid player" do
    context "when name is blank" do
      it "expects an error when name is nil" do
        expect { described_class.new(nil, "O").to raise_error(::Tictactoe::Errors::PlayerInformationMissingError) }
      end
    end

    context "when symbol is blank" do
      it "expects an error when symbol is empty" do
        expect { described_class.new("Test", "").to raise_error(::Tictactoe::Errors::PlayerInformationMissingError) }
      end
    end
  end

  describe "Valid player" do
    context "Valid details" do
      it "expects valid player name" do
        player = described_class.new("Gagan", "O")
        expect(player.name).to eq("Gagan")
      end

      it "expects valid player symbol" do
        player = described_class.new("Gagan", "O")
        expect(player.symbol).to eq("O")
      end
    end
  end
end
