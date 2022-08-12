# frozen_string_literal: false

require 'colorize'

# Chess board
class ChessBoard
  attr_reader :board

  def initialize(dimensions)
    @board = Array.new(dimensions) { Array.new(dimensions) }
  end

  def place_symbol(pos, symbol)
    board[pos[0]][pos[1]] = symbol
  end

  def pretty_print
    board.each_with_index do |row, row_index|
      formatted = ''
      row.each_with_index { |square, square_index| formatted << format_row(square, square_index + 1, row_index + 1) }
      puts formatted
    end
  end

  private

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
