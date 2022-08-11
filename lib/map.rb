# !/usr/bin/env ruby
# frozen_string_literal: false

require_relative 'knight'
require_relative 'board'

board = ChessBoard.new(8)
knight = Knight.new(false, 8)

from = [3, 3]

board.place_piece(knight, from[0])
path = knight.find_path(from)

0.upto(7).each do |row|
  0.upto(7).each do |square|
    path = knight.find_path(from[0], [row, square])
    board.place_symbol([row, square], path.length - 1)
  end
end

board.pretty_print
