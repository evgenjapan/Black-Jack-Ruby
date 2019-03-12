class Hand
  attr_accessor :score, :opened

  CARD_LIMIT = 3
  BLACK_JACK = 21

  def initialize
    @cards = []
    @score = 0
  end

  def add_card(card)
    @cards << card
    @score += 10 if Card::PICTURES.include?(card.value) && (card.value != 'A')
    @score += 1 if card.value == 'A'
    @score += card.value.to_i if ('2'..'10').include? card.value
  end

  def size
    @cards.size
  end

  def reset
    @cards = []
    @score = 0
  end

  def __str__
    str = ''
    @cards.each {|card| str += card.show_card}
    str += " Текущее кол-во очков - #{@score}"
  end

  alias show __str__
end
