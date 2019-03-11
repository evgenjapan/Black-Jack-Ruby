require_relative 'game'
require_relative 'deck'

puts 'Добро пожаловать в игру Black Jack'
puts '*игра закончится, если на вашем счету не останется средств'
game = Game.new(Deck.new)
game.start_game
loop do
  if game.can_play_again? && game.interface.again?
    game.start_game
  else
    game.interface.end_session
    break
  end
end
