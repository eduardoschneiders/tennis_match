require 'tennis_game_scorer'

RSpec.describe TennisGameScorer do
  describe '#play' do
    describe 'input validation' do
      context 'when numbers are 0 and 1' do
        it 'dont raise error' do
          expect{ described_class.new.play([0, 0]) }.not_to raise_error
        end
      end

      context 'when numbers are not 0 and 1' do
        it 'raises error' do
          expect{ described_class.new.play([1, 2]) }.to raise_error
        end
      end
    end
  end

  describe '#output_score' do
    subject(:output_score) { game_scorer.output_score}
    let(:game_scorer) { described_class.new}
    let(:game) { [1, 0] }

    before do
      game_scorer.play(game)
    end

    context 'all right' do
      let(:game) { [0, 0] }

      it 'returns the game status' do
        expect(output_score).to eql('0 sets played, 0 games played, current game: 2 - 0')
      end
    end

    context '' do
      let(:game) { [0, 0, 1, 1] }

      it 'returns the game status' do
        expect(output_score).to eql('0 sets played, 0 games played, current game: 2 - 2')
      end
    end

    context 'when Deuce' do
      let(:game) { [0, 0, 1, 1, 0, 1] }

      it 'returns the game status' do
        expect(output_score).to eql('0 sets played, 0 games played, current game: Deuce')
      end
    end

    context 'Advantage' do
      let(:game) { [0, 0, 1, 1, 0, 1, 1] }

      it 'returns the game status' do
        expect(output_score).to eql('0 sets played, 0 games played, current game: 3 - A')
      end
    end

    context 'when 1 game was completed' do
      let(:game) { [0, 0, 0, 0, 0, 0, 1, 1] }

      it 'returns the game status' do
        expect(output_score).to eql('0 sets played, 1 games played, game score: 1-0, current game: 2 - 2')
      end
    end

    context 'when 1 set was completed' do
      let(:game) do
        [
          0, 0, 0, 0, # game 1
          0, 0, 0, 0, # game 2
          0, 0, 0, 0, # game 3
          0, 0, 0, 0, # game 4
          0, 0, 0, 0, # game 5
          0, 0, 0, 0, # game 6
        ]
      end

      it 'returns the game status' do
        expect(output_score).to eql('1 sets played, 0 games played, current game: 0 - 0')
      end
    end
  end
end