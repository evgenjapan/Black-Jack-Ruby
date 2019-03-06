require_relative 'deck'
require_relative 'interface'
require_relative 'player'
require_relative 'dealer'
class Game
  BET = 10

  def initialize(deck)
    @interface = Interface.new
    username = @interface.init_user
    @player = Player.new(username)
    @dealer = Dealer.new
    @bank = 0
    @deck = deck
    @deck_counter = 0
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
    puts @player.hand.cards
  end

  def make_bets
    [@player, @dealer].each {|player| player.make_bet(BET)}
    @bank += 20
  end

  def start_game
    init_game
    rounds
    game_ends
  end

  def rounds
    loop do
      puts 'Текущая ситуация'
      @player.hand.__str__
      @interface.round_dialog
      choise = gets.to_i
      case choise
      when 2 then player_add_card
      when 3 then break
      end
      deal_card(@dealer) if @dealer.take_card?
      puts "Очки дилера #{@dealer.hand.score}"
      break if !@player.hand.can_take_card? and !@dealer.hand.can_take_card?
    end
  end

  def init_game
    make_bets
    deal_cards
  end

  def player_add_card
    if !@player.hand.can_take_card?
      puts 'Полная рука'
    else
      deal_card(@player)
    end
  end

  def game_ends
    p_score = @player.hand.calculate
    d_score = @dealer.hand.calculate
    @dealer.hand.__str__
    @player.hand.__str__
    if @player.lose? and @dealer.lose?
      puts 'Ничья, оба проиграли'
    elsif @player.lose?
      puts 'Вы проиграли!!!'
    elsif @dealer.lose?
      puts 'Вы выиграли!!!'
    else
      choice_winner(p_score, d_score)
    end
  end

  def choice_winner(p_score, d_score)
    puts "Очки дилера #{d_score}"
    puts "Ваши очки #{p_score}"
    if p_score == d_score
      puts 'Ничья'
    elsif p_score > d_score
      puts 'Вы победили'
    else
      puts 'Вы проиграли'
    end
  end

  def open_cards
    @dealer.hand.cards.each {|card| card.show_card}
  end

  def play_again
    @deck.reset_deck
    @deck.fill_deck
    [@player, @dealer].each {|player| player.hand.reset}
    start_game
  end

end

Game.new(Deck.new).start_game