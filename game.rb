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
      turn_results = turn(@active_player)
      switch
    end
  end

  def switch
    @active_player, @not_active_player = @not_active_player, @active_player
  end

  def game_end?(check)
    ended = !(@state.has_legal_moves?(@not_active_player))
    if ended && check
      @result = "#{@active_player} is the winner!!"
    elsif ended && !check
      puts "enterded here!!"
      puts "#{ended}"
      @result = "It is a draw!"
    end
    ended
  end

  def turn #could not find a better way to keep showing the board through the errors than bring the tests to this class.
    loop do
      move_results = nil
      action = prompt_action(@active_player)
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
        @state.show
      end
    end
  end

end
