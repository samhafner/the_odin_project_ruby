require_relative 'board'
require_relative 'player'
require_relative 'messages'

WINNING_COMBINATIONS = [
  [1, 2, 3], [4, 5, 6], [7, 8, 9], # horizontal wins
  [1, 4, 7], [2, 5, 8], [3, 6, 9], # vertical wins
  [1, 5, 9], [3, 5, 7]             # diagonal wins
].freeze

class TicTacToe
  def initialize
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @current_player = @player1
    @game_board = Board.new
    @score = {
      @player1.name => 0,
      @player2.name => 0
    }
  end

  def play
    GameMessages.welcome_message

    loop do
      @game_board.draw_board
      play_turn
      break if game_over?

      change_player
    end

    end_game

    GameMessages.current_score(@score)
    GameMessages.play_again_message
    again = gets.chomp.downcase
    if again == 'y'
      play_again
    else
      GameMessages.goodbye_message
    end
  end

  private

  def play_again
    GameMessages.separator
    @current_player = @player1
    @game_board = Board.new
    play
  end

  def end_game
    @game_board.draw_board
    GameMessages.draw_message if draw?
    GameMessages.winner_message(@current_player.name) if winner?
    set_score
  end

  def set_score
    @score[@current_player.name] += 1
  end

  def play_turn
    GameMessages.player_turn_message(@current_player.name, @current_player.symbol)

    input = nil
    loop do
      GameMessages.player_input_message(@current_player.name)
      input = gets.chomp.to_i
      GameMessages.invalid_input_message unless (1..9).include?(input) && valid_move?(input)
      break if (1..9).include?(input) && valid_move?(input)
    end

    @game_board.update_board(input, @current_player.symbol)
    GameMessages.separator
  end

  def valid_move?(input)
    @game_board.board.flatten.include?(input)
  end

  def game_over?
    @game_board.board.flatten.none?(Integer) || winner?
  end

  def draw?
    game_over? && !winner?
  end

  def winner?
    board_flattened = @game_board.board.flatten
    [@player1, @player2].any? do |player|
      WINNING_COMBINATIONS.any? do |combination|
        combination.all? { |position| board_flattened[position - 1] == player.symbol }
      end
    end
  end

  def change_player
    @current_player = if @current_player == @player1
                        @player2
                      else
                        @player1
                      end
  end
end
