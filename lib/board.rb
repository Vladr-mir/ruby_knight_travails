# frozen_string_literal: false

require 'colorize'

# Chess board
class ChessBoard
  attr_reader :board

  def initialize
    @board = create_board
  end

  def create_board
    Array.new(8) { Array.new(8) }
  end

  def move_knight(new_pos)
    knight = knight_get
    pos = knight.pos
    return unless knight.valid_move?(pos, new_pos)

    knight.update_pos(new_pos)

    board[new_pos[0]][new_pos[1]] = knight
    board[pos[0]][pos[1]] = nil
  end

  def place_piece(piece, pos)
    return nil unless pos[0].between?(0, 7) && pos[1].between?(0, 7)

    piece.update_pos(pos)
    board[pos[0]][pos[1]] = piece
  end

  def pretty_print
    board.each_with_index do |row, row_index|
      formatted = ''
      row.each_with_index { |square, square_index| formatted << format_row(square, square_index + 1, row_index + 1) }
      puts formatted
    end
  end

  private

  def knight_get
    board.each do |row|
      piece = row.find { |element| !element.nil? }

      return piece unless piece.nil?
    end
  end

  def format_row(square, square_index, row_index)
    formatted = if square.nil?
                  "\s\s"
                else
                  "#{square}\s"
                end

    if (row_index - square_index).even?
      formatted.colorize(color: :black, background: :white)
    else
      formatted.colorize(color: :black, background: :green)
    end
  end
end
