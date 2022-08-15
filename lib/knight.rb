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
end
