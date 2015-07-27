require_relative './player.rb'
require_relative './state.rb'

class Game

  def initialize
    File.open('message.txt', 'w+'){|f| f.write("")}
    @white = Player.new("white")
    @black = Player.new("black")
    @state = State.new
    @active_player = @white
  end

  def game_loop
    loop do
      turn(@active_player)
      if won?(@active_player)
        break
      end
      toggle
    end
  end

  def toggle
    if @active_player == @white
      @active_player = @black
    else
      @active_player = @white
    end
  end

  def won?(player)
    # FU, TBI
  end

  def turn(player)
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
