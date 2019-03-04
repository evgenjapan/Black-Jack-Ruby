class Game
  BET = 10

  def initialize(player, dealer, deck)
    @player = player
    @dealer = dealer
    @deck = deck
    @bank = 0
    @deck_counter = 0
    start_game
  end

  def start_game
    deal_cards
    make_bets
    dealer_move
  end

  def deal_card(player)
    player.hand.cards << @deck.cards[@deck_counter]
    @deck_counter += 1
  end

  def deal_cards
    2.times do
      deal_card(@player)
      deal_card(@dealer)
    end
  end

  def make_bets
    [@player, @dealer].each {|player| player.make_bet(BET)}
    @bank += 20
  end

  def dealer_move
    return next_move if @dealer.hand.score >= 17
    deal_card(@dealer)
  end

  def next_move
    puts 'Выбор'
    choise = gets.to_i
    case choise
    when 1 then player_pass
    when 2 then player_add_card
    when 3 then open_cards
    end
  end

  def player_pass
    dealer_move
  end

  def player_add_card
    deal_card(@player)
  end

  def open_cards
    @dealer.hand.cards.each {|card| card.show_card}
  end

  def end_game?
    if @player.hand.cards.size = 3 and @dealer.hand.cards.size = 3
      end_game
    end
  end

  def end_game
    puts 'end'
  end

  def play_again
    @deck.reset_deck
    @deck.fill_deck
    [@player, @dealer].each {|player| player.hand.reset}
    start_game
  end

end