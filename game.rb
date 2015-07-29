require_relative './player.rb'
require_relative './state.rb'

class Game #responsibility: manage the flux of the game, mainly through game_loop

  def initialize
    File.open('message.txt', 'w+'){|f| f.write("")}
    @white = Player.new("white")
    @black = Player.new("black")
    @state = State.new
  end

  def game_loop
    @active_player = @white
    @not_active_player = @black

    loop do
      turn(@active_player)
      check = @state.king_in_check?(@not_active_player.color)
      if check
        File.open('message.txt', 'w+'){|f| f.write("The #{@not_active_player.color} King is in check!")}
      end
      if game_end?(check)
        break
      end
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

  def turn(player) #could not find a better way to keep showing the board through the errors than bring the tests to this class.
    loop do
      @state.show
      candidate_move = player.prompt_move
      if player.move_legal?(candidate_move)
        candidate_move = player.format_move(candidate_move)
      else
        next
      end
      if @state.move_legal?(@active_player, candidate_move[0], candidate_move[1])
        @state.move(candidate_move[0], candidate_move[1])
        break
      else
        next
      end
    end
  end

end
