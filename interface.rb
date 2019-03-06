
class Interface

  def init_user
    puts 'Введите имя'
    gets.chomp
  end

  def show_player_balance(player)
    puts "Баланс: #{player.cash}"
  end

  def show_hand(player)
    player.hand.__str__
  end

  def round_dialog
    puts '1. Пропустить ход'
    puts '2. Взять карту'
    puts '3. Открыть карты'
  end

end