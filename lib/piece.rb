# lib/piece.rb
# frozen_string_literal: false

# Pieces blueprint
class Piece
  def initialize(dimensions, symbol)
    @dimensions = dimensions - 1
    @pos = nil
    @symbol = symbol
  end

  # Updates pos (without going out of bounds)
  def update_pos(new_pos)
    return unless new_pos[0].between?(0, @dimensions) && new_pos[1].between?(0, @dimensions)

    @pos = new_pos
  end

  def to_s
    @symbol
  end

  def movement_range
    [
      [0, 1]
    ]
  end

  def valid_move?(pos, new_pos)
    valid = find_valid_moves(pos)
    valid.each { |move| return true if move == new_pos }
    false
  end

  def find_valid_moves(pos)
    # Find relative moves
    relative_moves = movement_range
    relative_moves.map do |row|
      row[0] += pos[0]
      row[1] += pos[1]
    end

    # Deletes invalid moves
    relative_moves.select do |row|
      row = row.select { |new_pos| new_pos.between?(0, @dimensions) }
      row.length >= 2
    end
  end

  def piece_move(new_pos)
    update_pos(new_pos) if valid_move?(@pos, new_pos)
  end
end
