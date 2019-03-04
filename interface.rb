require_relative 'player'
require_relative 'deck'
require_relative 'player'
require_relative 'game'
require_relative 'dealer'
require_relative 'hand'
def init_user
  puts 'Введите свое имя'
  name = gets.chomp
  @player = Player.new(name)
  start_new_game
end
def start_new_game
  dealer = Dealer.new('Dealer')
  deck = Deck.new
  @game = Game.new(@player, dealer, deck)
end
def play_again?
  puts 'Сыграть еще?'
  puts '1. Да'
  puts '2. Нет'
end
init_user