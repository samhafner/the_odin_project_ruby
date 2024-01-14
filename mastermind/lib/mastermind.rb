require_relative 'messages'
require 'colorize'
require 'pry'

AVAILABLE_COLORS = {
  1 => 'red',
  2 => 'green',
  3 => 'blue',
  4 => 'yellow',
  5 => 'cyan',
  6 => 'magenta'
}.freeze
NUMBER_OF_PEGS = 4
NUMBER_OF_TURNS = 12

class Mastermind
  def initialize
    @code = generate_code
    @turns = NUMBER_OF_TURNS
  end

  def play
    GameMessages.welcome_message
    draw_code([1, 2, 3, 4, 5, 6])
    GameMessages.explainer_message
    guess = []

    loop do
      guess = ask_for_guess
      break if win?(guess)

      draw_code(guess)
      give_feedback(guess)
      @turns -= 1
      break if @turns.zero?

      GameMessages.turns_left_message(@turns)
    end

    if win?(guess)
      GameMessages.win_message
    else
      GameMessages.lose_message
      puts 'The code was:'
      draw_code(@code)
    end
  end

  def give_feedback(guess)
    partial_match = 0
    exact_match = 0
    @code.each_with_index do |number, index|
      if guess[index] == number
        exact_match += 1
      elsif guess.include?(number)
        partial_match += 1
      end
    end
    GameMessages.feedback_message(exact_match, partial_match)
  end

  def win?(guess)
    guess == @code
  end

  def ask_for_guess
    GameMessages.ask_for_guess
    guess = ''
    until valid_input?(guess)
      guess = gets.chomp.strip.gsub(/\s+/, '')

      GameMessages.invalid_input_message unless valid_input?(guess)
    end
    guess.split('').map(&:to_i)
  end

  def valid_input?(guess)
    guess.length == NUMBER_OF_PEGS && guess.chars.all? { |c| c.to_i.between?(1, 6) }
  end

  def generate_code
    code = []
    NUMBER_OF_PEGS.times do
      code << AVAILABLE_COLORS.keys.sample
    end
    code
  end

  def draw_code(guess)
    guess.each do |number|
      print "#{"  #{number}  ".to_s.colorize(background: AVAILABLE_COLORS[number].to_sym, mode: :bold)} "
    end
    puts ''
  end
end
