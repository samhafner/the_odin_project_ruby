require 'colorize'

module GameMessages
  def self.welcome_message
    puts 'Welcome to Mastermind!'.colorize(color: :green, mode: :bold)
  end

  def self.explainer_message
    puts 'In this game, you will be the codebreaker and the computer will be the codemaker.'
    puts 'The computer will generate a 4-digit code consisting of numbers 1-6.'
    puts 'Your job is to guess the code within 12 turns.'
    puts 'After each guess, the computer will give you feedback on your guess.'
    puts 'The feedback will tell you how many exact matches and partial matches you have.'
    puts 'An exact match is a number that is in the correct position.'
    puts 'A partial match is a number that is in the code, but not in the correct position.'
    puts 'Please note that a digit can be used more than once in the code.'.colorize(mode: :bold)
    puts 'Good luck!'
  end

  def self.ask_for_guess
    puts 'Please enter your guess: (4-digit number, 1-6)'.colorize(color: :blue, mode: :bold)
  end

  def self.turns_left_message(turns)
    puts "You have #{turns} turns left."
  end

  def self.invalid_input_message
    puts 'Invalid input. Please try again.'.colorize(color: :red, mode: :bold)
  end

  def self.win_message
    puts 'Congratulations, you have cracked the code!'.colorize(color: :green, mode: :bold)
  end

  def self.lose_message
    puts 'Sorry, you lose!'.colorize(color: :red, mode: :bold)
  end

  def self.play_again_message
    puts 'Would you like to play again? (y/n)'.colorize(color: :blue, mode: :bold)
  end

  def self.feedback_message(exact_match, partial_match)
    puts "You have #{exact_match} exact matche(s) and #{partial_match} partial matche(s)."
  end
end
