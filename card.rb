class Card
  attr_accessor :value, :suit
  SUITS = %w[♠ ♥ ♣ ♦].freeze
  PICTURES = %w[J Q K A].freeze

  def initialize(suit, value)
    @value = value
    @suit = suit
  end

  def show_card
    " #{@suit}#{@value} "
  end
end
