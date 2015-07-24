require_relative './player.rb'
require_relative './state.rb'

class Game

  def initialize
    @white = Player.new("white")
    @black = Player.new("black")
    @state = State.new
    @active_player = @white
  end


  def game_loop
    loop do
      turn(active_player)
      if won?(active_player)
        break
      end
      toggle(@active_player)
    end
  end

  def toggle(player)
    if player == @white
      player = @black
    else
      player = @white
    end
  end

  def won?(player)
    # FU, TBI
  end

  def turn(player)
    
  end

end
