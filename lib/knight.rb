# frozen_string_literal: false

require 'colorize'

# Knight piece
class Knight
  attr_reader :pos

  def initialize(is_white)
    @pos = nil
    @symbol = if is_white
                '♘'
              else
                '♞'
              end
  end

  def update_pos(new_pos)
    return unless new_pos[0].between?(0, 7) && new_pos[1].between?(0, 7)

    @pos = new_pos
  end

  def valid_move?(pos, new_pos)
    valid = valid_moves(pos)
    valid.each { |move| return true if move == new_pos }
    false
  end

  def to_s
    @symbol
  end

  private

  def valid_moves(pos)
    moves = [
      [pos[0] + 2, pos[1] + 1],
      [pos[0] + 2, pos[1] - 1],
      [pos[0] + 1, pos[1] + 2],
      [pos[0] + 1, pos[1] - 2],
      [pos[0] - 2, pos[1] + 1],
      [pos[0] - 2, pos[1] - 1],
      [pos[0] - 1, pos[1] + 2],
      [pos[0] - 1, pos[1] - 2]
    ]

    moves.select do |row|
      row = row.select { |pos| pos.between?(0, 7) }
      row.length >= 2
    end
  end
end
