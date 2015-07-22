class Pieces
  #common methods
end

class Pawn
  def initialize(color)
    @color = color
    if color = "white"
      @icon_code = "\u2659"
    else
      @icon_code = "\u265F"
    end
    @moved = false
  end

  def move_legal?(move) #hash keys{from_row from_col to_row to_col}
    if @color = "white"
      if @moved = false
  #    if (move[to_row] == move[from_row] + 1 || move[to_row] == move[from_row] + 2) && move[to_col] == move[from_col]
      else #moved

      end
    else #black
      if @moved = false
  #      if (move[to_row] == move[from_row] + 1 || move[to_row] == move[from_row] + 2) && move[to_col] == move[from_col]
      else #moved

      end
    end
end
