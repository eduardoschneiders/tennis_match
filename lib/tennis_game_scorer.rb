# frozen_string_literal: true

require 'byebug'

class TennisGameScorer
  attr_accessor :game

  def play(game)
    @game = game
    validate_input!
  end

  def output_score; end

  private

  def validate_input!
    raise 'Invalid input' unless game.uniq.all? { |e| [0, 1].include?(e) }
  end
end
