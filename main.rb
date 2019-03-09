require_relative 'game'
require_relative 'deck'

puts 'Добро пожаловать в игру Black Jack'
Game.new(Deck.new).start_game
