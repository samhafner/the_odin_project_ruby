class Board
  attr_reader :board

  def initialize
    @board = # important: use the block syntax to avoid the same array being used in each row
      Array.new(3) do
        Array.new(3, ' ')
      end
    fill_board!
  end

  def draw_board
    puts ''
    @board.each_with_index do |row, i|
      puts " #{row[0]} | #{row[1]} | #{row[2]} "
      puts '---+---+---' unless i == @board.length - 1
    end
    puts ''
  end

  def update_board(input, symbol)
    @board.map! do |row|
      row.map { |cell| cell == input ? symbol : cell }
    end

    @board.each_with_index do |row, row_index|
      row.each_with_index do |_column, column_index|
        @board[row_index][column_index] = symbol if @board[row_index][column_index] == input
      end
    end
  end

  private

  def fill_board!
    @board.each_with_index do |row, row_index|
      row.each_with_index do |_column, column_index|
        row[column_index] = row_index * 3 + column_index + 1
      end
    end
  end
end
