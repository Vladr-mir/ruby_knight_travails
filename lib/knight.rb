# frozen_string_literal: false

require 'colorize'
require_relative 'piece'
require_relative 'pathfinder'

# Knight piece
class Knight < Piece
  attr_reader :pos

  include PathFinder

  def initialize(is_white, dimensions)
    symbol = if is_white
               '♘'
             else
               '♞'
             end
    super(dimensions, symbol)
  end

  def movement_range
    [
      [2, 1],
      [2, -1],
      [-2, 1],
      [-2, -1],
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2]
    ]
  end

  # TODO: Make this function to be a pathfinding function
  def knight_moves(new_pos)
    update_pos(new_pos) if valid_move?(@pos, new_pos)
  end
end
