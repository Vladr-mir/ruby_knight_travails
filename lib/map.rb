# !/usr/bin/env ruby
# frozen_string_literal: false

require_relative 'knight'
require_relative 'board'

chess_size = 8
from = [3, 3]

board = ChessBoard.new(chess_size)
knight = Knight.new(false, chess_size)

knight.update_pos(from)

0.upto(7).each do |row|
  0.upto(7).each do |square|
    path = knight.find_path(from, [row, square])
    board.place_symbol([row, square], path.length - 1)
  end
end

board.pretty_print
