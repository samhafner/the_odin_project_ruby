module GameMessages
  def self.welcome_message
    puts "Welcome to Tic Tac Toe!"
  end

  def self.separator
    puts "-------------------------------"
  end

  def self.draw_message
    puts "It's a draw!"
  end

  def self.winner_message(winner)
    puts "#{winner} won!"
  end

  def self.player_turn_message(player, symbol)
    puts "#{player}'s turn. --> #{symbol}"
  end

  def self.player_input_message(player)
    puts "#{player}, please enter a number between 1 and 9."
  end

  def self.invalid_input_message
    puts "Invalid input. Please try again."
  end

  def self.play_again_message
    puts "Would you like to play again? (y/n)"
  end

  def self.goodbye_message
    puts "Thanks for playing!"
  end

  def self.current_score(score)
    puts "Score:"
    score.each do |name,score|
      puts "#{name}: #{score}"
    end
  end
end
