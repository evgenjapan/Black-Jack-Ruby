class Interface
  def init_user
    puts 'Введите имя'
    gets.chomp
  end

  def round_start(player, dealer)
    puts 'Текущая ситуация:'
    show_hand(player)
    show_masked(dealer)
    round_dialog
  end

  def round_dialog
    puts '1. Пропустить ход'
    puts '2. Взять карту'
    puts '3. Открыть карты'
  end

  def show_hand(player)
    puts "#{player.name}:"
    player.hand.show
  end

  def show_cash(player)
    puts "На счету игрока #{player.name}: #{player.cash}"
  end

  def show_masked(player)
    puts "Player #{player.name} has #{player.hand.cards.size} cards"
  end

  def again(game)
    puts 'Сыграть еще раз?'
    puts 'Введите 1, если хотите сыграть еще'
    case gets.to_i
    when 1 then game.play_again
    when 2 then end_session
    end
  end

  def end_session
    puts 'Спасибо за игру'
  end
end
