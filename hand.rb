class Hand
  attr_accessor :cards, :score

  def initialize
    @cards = []
    @score = 0
  end

  def calculate
    @cards.each do |card|
      @score += 10 if Card::PICTURES.include? card.value and card.value != 'A'
      @score += 1 if card.value == 'A'
      @score += card.value.to_i if ('2'..'10').include? card.value
    end
  end

  def reset
    @cards = []
    @score = 0
  end

  def can_take_card?
    return true if @cards.size < 3
    false
  end

end