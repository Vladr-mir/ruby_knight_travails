# !/usr/bin/env ruby
# frozen_string_literal: false

require_relative 'knight'
require_relative 'board'

moves_counter = 0
chess_size = 8
move_from_to = [[3, 3], [3, 4]]

board = ChessBoard.new(chess_size)
knight = Knight.new(false, chess_size)

knight.update_pos(move_from_to[0])
path = knight.find_path(*move_from_to)

path.each do |square|
  moves_counter += 1
  board.place_symbol(square, moves_counter - 1)
  knight.knight_moves(square)
end

board.place_symbol(knight.pos, knight.to_s)

board.pretty_print
puts "\nYou made it in #{moves_counter - 1} moves! Here's your path:"
path.each do |move|
  p move
end
