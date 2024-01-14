require_relative 'lib/mastermind'

game = Mastermind.new

begin
  game.play
rescue Interrupt
  puts "\nGoodbye!"
end
