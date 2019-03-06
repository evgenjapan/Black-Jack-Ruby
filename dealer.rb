class Dealer < Player

  SCORE_LIMIT = 17

  def initialize
    super('Dealer')
  end

  def take_card?
    hand.calculate
    hand.can_take_card? and hand.score < SCORE_LIMIT
  end

end