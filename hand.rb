class Hand
  attr_accessor :cards, :score, :opened

  CARD_LIMIT = 3
  BLACK_JACK = 21

  def initialize
    @cards = []
    @score = 0
  end

  def calculate
    @score = 0
    @cards.each do |card|
      @score += 10 if Card::PICTURES.include?(card.value) && (card.value != 'A')
      @score += 1 if card.value == 'A'
      @score += card.value.to_i if ('2'..'10').include? card.value
    end
    @score
  end

  def reset
    @cards = []
    @score = 0
  end

  def __str__
    @cards.each(&:show_card)
    calculate
    puts "Текущее кол-во очков #{@score}"
  end

  alias show __str__
end
