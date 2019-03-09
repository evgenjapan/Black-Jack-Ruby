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
    @winner = nil
  end

  def start_game
    deal_cards
    make_bets
    dealer_move
  end

  def refund_bet
    @winner.cash += @bank unless @winner.nil?
    @bank = 0
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
    [@player, @dealer].each { |player| player.make_bet(BET) }
    @bank += 20
  end

  def start_game
    init_game
    rounds
    game_ends
  end

  def rounds
    loop do
      @interface.round_start(@player, @dealer)
      choise = gets.to_i
      case choise
      when 2 then player_add_card
      when 3 then break
      end
      deal_card(@dealer) if @dealer.take_card?
      break if !@player.can_take_card? && !@dealer.can_take_card?
    end
  end

  def init_game
    make_bets
    deal_cards
  end

  def player_add_card
    if !@player.can_take_card?
      puts 'Полная рука'
    else
      deal_card(@player)
    end
  end

  def game_ends
    @interface.show_hand(@player)
    @interface.show_hand(@dealer)
    p_score = @player.hand.score
    d_score = @dealer.hand.score
    autolose? ? autolose : choice_winner(p_score, d_score)
    refund_bet
    @interface.show_cash(@player)
    @player.enought_cash?(BET) ? @interface.again(self) : @interface.end_session
  end

  def autolose?
    @player.lose? || @dealer.lose?
  end

  def autolose
    puts 'Перенабор карт'
    if @player.lose? && @dealer.lose?
      puts 'Ничья'
      @winner = nil
    elsif @player.lose?
      puts 'Вы проиграли'
      @winner = @dealer
    else
      puts 'Вы победили'
      @winner = @player
    end
  end

  def choice_winner(p_score, d_score)
    if p_score == d_score
      puts 'Ничья'
      @winner = nil
    elsif p_score > d_score
      puts 'Вы победили'
      @winner = @player
    else
      puts 'Вы проиграли'
      @winner = @dealer
    end
  end

  def play_again
    @deck.shuffle!
    @deck_counter = 0
    [@player, @dealer].each { |player| player.hand.reset }
    start_game
  end
end
