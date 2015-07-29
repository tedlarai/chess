#require_relative './player.rb'
require_relative './state.rb'

class Game #responsibility: manage the flux of the game, mainly through game_loop

  def initialize
    File.open('message.txt', 'w+'){|f| f.write("")}
    @active_player = "white"
    @inactive_player = "black"
    @state = State.new
  end

  def game_loop
    loop do
      turn_results = turn
      check_for_special_conditions(turn_results)
      if turn_results[:game_ended]
        break
      end
      switch
    end
    game_end
  end

  def switch
    @active_player, @inactive_player = @inactive_player, @active_player
  end

  def game_end
    @state.show
    puts "Great Game!! press 'Enter' to return to Menu"
    gets
  end

  def turn
    loop do
      move_results = nil
      @state.show
      action = prompt_action
      if action =~ /[a-z]\d\s[a-z]\d/
      #when "s"
        #save game
      #when 'q'
        #quit game *** needs to dump this game
      #when "valid_move"#{################}input =~ /[a-z]\d\s[a-z]\d/
        move_results = @state.move(@active_player, action)
        if move_results[:moved]
          return move_results
        end
      else
        File.open('message.txt', 'w+'){|f| f.write("Invalid Option, try again")}
      end
    end
  end

  def prompt_action
    puts "#{@active_player.capitalize}, your turn. (s)ave game, (q)uit to menu, or enter your move (ex. a1 c4):"
    gets.chomp
  end

  def check_for_special_conditions(turn_results)
    puts turn_results
    if turn_results[:delivered_check] #check
      if turn_results[:game_ended] #mate
        File.open('message.txt', 'w+'){|f| f.write("#{@inactive_player.capitalize} King is dead!! Mate!!")}
      else
        File.open('message.txt', 'w+'){|f| f.write("#{@inactive_player.capitalize} King is under siege!! Check!!")}
      end
    elsif turn_results[:game_ended] #draw
      File.open('message.txt', 'w+'){|f| f.write("#{@inactive_player.capitalize} do not have any valid move and the #{@inactive_player.capitalize} King is not in check. Boring draw...")}
    end
 end

end
