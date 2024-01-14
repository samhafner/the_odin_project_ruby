require_relative 'messages'
require 'colorize'

# rubocop:disable Metrics/MethodLength
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

  def give_feedback(guess) # rubocop:disable Metrics/AbcSize
    matches = {
      exact: 0,
      partial: 0
    }
    matched_numbers = []
    ignore_index = []
    guess.each_with_index do |number, index|
      next unless @code[index] == number

      matches[:exact] += 1
      matched_numbers << number
      ignore_index << index
    end
    guess.each_with_index do |number, index| # rubocop:disable Style/CombinableLoops
      next if ignore_index.include?(index)

      if @code.include?(number) && matched_numbers.count(number) < @code.count(number)
        matches[:partial] += 1
        matched_numbers << number
      end
    end
    GameMessages.feedback_message(matches[:exact], matches[:partial])
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
    [1, 1, 3, 3]
  end

  def draw_code(guess)
    guess.each do |number|
      print "#{"  #{number}  ".to_s.colorize(background: AVAILABLE_COLORS[number].to_sym, mode: :bold)} "
    end
    puts ''
  end
end

# rubocop:enable Metrics/MethodLength
