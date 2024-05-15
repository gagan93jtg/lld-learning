RSpec.describe Tictactoe::Services::Runner do
  describe "Basic runner flow" do
    subject(:runner) { described_class.new }
    before do
      runner.add_players
      runner.play
    end

    it "expects Gagan1 to be the winner" do
      expect(runner.game.winner.name).to eq("Gagan1")
    end

  end
end
