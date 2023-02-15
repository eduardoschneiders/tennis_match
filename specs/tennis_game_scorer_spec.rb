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
  end
end