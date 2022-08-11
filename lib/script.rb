# !/usr/bin/env ruby
# frozen_string_literal: false

require_relative 'knight'
require_relative 'board'

board = ChessBoard.new(8)
knight = Knight.new(false, 8)

moves_counter = 0
move_from_to = [[0, 0], [7, 7]]

board.place_piece(knight, move_from_to[0])
path = knight.find_path(*move_from_to)

path.each do |square|
  moves_counter += 1
  knight.knight_moves(square)
  board.update_board
end

board.pretty_print
puts "\nYou made it in #{moves_counter - 1} moves! Here's your path:"
path.each do |move|
p move
end
