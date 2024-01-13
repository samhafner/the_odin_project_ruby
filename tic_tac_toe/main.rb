require_relative 'lib/tic_tac_toe'

game = TicTacToe.new

begin
  game.play
rescue Interrupt
  puts "\nGoodbye!"
end
