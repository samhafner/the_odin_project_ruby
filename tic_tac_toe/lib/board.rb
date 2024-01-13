class Board
  attr_reader :board

  def initialize
    @board = create_board
  end

  def draw_board
    puts ''
    puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} "
    puts '---+---+---'
    puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} "
    puts '---+---+---'
    puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} "
    puts ''
  end

  def update_board(input, symbol)
    @board.map! do |row|
      row.map { |cell| cell == input ? symbol : cell }
    end
  end

  private

  def create_board
    board = Array.new(3) do
      Array.new(3)
    end
    board.each_with_index do |row, row_index|
      row.each_with_index do |_column, column_index|
        row[column_index] = row_index * 3 + column_index + 1
      end
    end
    board
  end
end
