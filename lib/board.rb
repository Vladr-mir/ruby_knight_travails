# frozen_string_literal: false

require 'colorize'

# Chess board
class ChessBoard
  attr_reader :board

  def initialize(dimensions)
    @board = create_board(dimensions)
  end

  def create_board(dimensions)
    Array.new(dimensions) { Array.new(dimensions) }
  end

  def move_piece(piece_pos, new_pos)
    piece = get_piece(piece_pos)
    pos = piece.pos
    return unless piece.valid_move?(piece_pos, new_pos)

    piece.update_pos(new_pos)

    board[new_pos[0]][new_pos[1]] = piece
    board[pos[0]][pos[1]] = '.'
  end

  def get_piece(piece_pos)
    board[piece_pos[0]][piece_pos[1]]
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

  # Updates the pieces position
  def update_board
    board.each_with_index do |row, row_index|
      row.each_with_index do |square, square_index|
        unless square.nil? || square == '.'
          board[row_index][square_index] = '.'
          board[square.pos[0]][square.pos[1]] = square
        end
      end
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
