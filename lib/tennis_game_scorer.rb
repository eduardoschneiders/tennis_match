# frozen_string_literal: true

require 'byebug'

class TennisGameScorer
  attr_accessor :match_points, :points, :games, :sets

  def play(match_points)
    @match_points = match_points
    validate_input!
    set_player_points
  end

  def output_score
    "#{sets_status}, #{games_status}, #{current_game_status}"
  end

  private

  def validate_input!
    raise 'Invalid input' unless match_points.uniq.all? { |e| [0, 1].include?(e) }
  end

  def set_player_points
    @points = [0, 0]
    @games = [0, 0]
    @sets = [0, 0]

    match_points.each do |point|
      points[0] += 1 if point == 0
      points[1] += 1 if point == 1

      if points[0] == 4 || points[1] == 4 && two_points_difference? &&!deuce?
        games[0] += 1 if points[0] == 4
        games[1] += 1 if points[1] == 4
        @points = [0, 0]
      end

      if tie_breaker?
        if two_points_difference?
          sets[0] += 1 if games[0] > games[1]
          sets[1] += 1 if games[1] > games[0]

          @games = [0, 0]
          @points = [0, 0]
        end
      elsif completed_games?
        sets[0] += 1 if games[0] == 6
        sets[1] += 1 if games[1] == 6

        @games = [0, 0]
        @points = [0, 0]
      end
    end
  end

  def two_points_difference?
    (points[0] - points[1]).abs == 2
  end

  def deuce?
    points[0] >= 3 && points[1] >= 3
  end

  def advantage?
    deuce? && points[0] != points[1]
  end

  def completed_games?
    games[0] == 6 || games[1] == 6
  end

  def tie_breaker?
    games[0] >= 5 && games[1] >= 5
  end

  def current_game_status
    return "current game: #{points[0] > points[1] ? 'A' : points[0]} - #{points[1] > points[0] ? 'A' : points[1]}" if advantage?
    return 'current game: Deuce' if deuce?

    "current game: #{points[0]} - #{points[1]}"
  end

  def games_status
    game_score = ", game score: #{games[0]}-#{games[1]}" if games.sum > 0
    "#{games.sum} games played#{game_score}"
  end

  def sets_status
    "#{sets.sum} sets played"
  end
end
