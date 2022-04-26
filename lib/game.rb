class Game

  attr_accessor :human_player, :enemies_in_sight, :players_left

  def initialize(human_player)
    @human_player = HumanPlayer.new(human_player)
    @enemies_in_sight = []
    @players_left = 10
  end

  def kill_enemy(enemy)
    @enemies_in_sight.delete(enemy)
    @players_left -=1
  end
  
  def is_still_ongoing?
    @human_player.life_points > 0 && @players_left > 0
  end

  def show_players
    puts "-"*50
    puts "Voici l'état du joueur :"
    puts @human_player.show_state
    puts "\n"
    puts "Il reste #{@players_left} adversaires."
  end

  def menu
    puts "-"*50
    puts "Quelle action veux-tu effectuer ?"
    puts "a - chercher une meilleure arme"
    puts "s - chercher à se soigner"
    puts "\n"
    puts "attaquer un joueur en vue :"
    
    @enemies_in_sight.each_with_index do |enemy, i|
      enemy.life_points >= 0 ? (puts "#{i.to_i+1} #{enemy.show_state}") : next
    end
    puts "\n"
  end
  
  def menu_choice(input)
    case input
    when "a"
      @human_player.search_weapon    
    when "s"
      @human_player.search_health_pack
    when (1..(@enemies_in_sight.length))
      @human_player.attack(@enemies_in_sight[input-1])
      @enemies_in_sight[input-1].life_points <= 0 ? kill_enemy(@enemies_in_sight[input-1]) : nil
     else
      puts "Try another input"
      return "Try another input"
    end
  end
  
  def enemies_attack
    puts "Les autres joueurs t'attaquent !"
    @enemies_in_sight.each do |enemy|
      enemy.attack(@human_player)
    end
  end
  
  def end
    puts "-"*50
    @human_player.life_points > 0 ? (puts"BRAVO ! TU AS GAGNE !") : ( puts"Loser ! Tu as perdu !")

  end

  def new_players_in_sight
    if @players_left == @enemies_in_sight.length
      puts "Tous les joueurs sont déjà en vue"
    else
      dice = rand(1..6)
      case dice
      when 1
        puts "Pas de nouveaux adversaires."
      when (2..4)
        player_name = "Player_#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
        enemy1 = Player.new (player_name)
        @enemies_in_sight << enemy1
        puts "Le joueur #{player_name} arrive"
      when (5..6)
        if @players_left == 1
          player_name3 = "Player_#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
        enemy4 = Player.new (player_name)
        @enemies_in_sight << enemy4
        puts "Le joueur #{player_name3} arrive et c'est le dernier!"
        else
          player_name1 = "Player_#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
          enemy2 = Player.new (player_name1)
          @enemies_in_sight << enemy2
          player_name2 = "Player_#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}#{rand(0..9)}"
          enemy3 = Player.new (player_name2)
          @enemies_in_sight << enemy3
          puts "Les joueurs #{player_name1} et #{player_name2} arrivent"
        end
      else
        "Error"
      end
    end
  end
end