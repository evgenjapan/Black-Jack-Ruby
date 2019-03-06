class Hand
  attr_accessor :cards, :score, :opened

  CARD_LIMIT = 3
  BLACK_JACK = 21

  def initialize
    @cards = []
    @score = 0
    @opened = false
  end

  def calculate
    @score = 0
    @cards.each do |card|
      @score += 10 if Card::PICTURES.include? card.value and card.value != 'A'
      @score += 1 if card.value == 'A'
      @score += card.value.to_i if ('2'..'10').include? card.value
    end
    @score
  end

  def reset
    @cards = []
    @score = 0
  end

  def can_take_card?
    @cards.size < CARD_LIMIT
  end

  def lose?
    @score > BLACK_JACK
  end

  def open_hand
    @opened = true
  end

  def __str__
    @cards.each {|card| card.show_card}
    calculate
    puts "Current score #{@score}"
  end

end