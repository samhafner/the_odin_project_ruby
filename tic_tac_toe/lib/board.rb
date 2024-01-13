class Board
  attr_reader :board

  def initialize
    @board = Array.new(3) { Array.new(3, ' ') } # important: use the block syntax to avoid the same array being used in each row
    fill_board!
  end

  def draw_board
    puts ""
    puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} "
    puts "---+---+---"
    puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} "
    puts "---+---+---"
    puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} "
    puts ""
  end

  def update_board(input, symbol)
    @board.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        @board[row_index][column_index] = symbol if @board[row_index][column_index] == input
      end
    end
  end

  private

  def fill_board!
    @board.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        row[column_index] = row_index * 3 + column_index + 1
      end
    end
  end
end
