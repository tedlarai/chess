class Pieces
  #common methods
end

class Pawn
  def initialize(color)
    @color = color
    if color == "white"
      @icon_code = "\u2659"
    else
      @icon_code = "\u265F"
    end
  end

  def move_legal?(move) #hash keys{:from_row :from_col :from_row :to_col}
    if @color == "white"
      if move[:from_row] == 2#starting position
       (move[:to_row] == move[:from_row] + 1 || move[:to_row] == move[:from_row] + 2) && move[:to_col] == move[:from_col]
      else #moved
        move[:to_row] == move[:from_row] + 1 && move[:to_col] == move[:from_col]
      end
    else #black
      if move[:from_row] == 7 #starting position
        (move[:to_row] == move[:from_row] - 1 || move[:to_row] == move[:from_row] - 2) && move[:to_col] == move[:from_col]
      else #moved
        move[:to_row] == move[:from_row] - 1 && move[:to_col] == move[:from_col]
      end
    end
  end

  def capture_legal?(move)
    if @color == 'white'
      move[:to_row] == move[:from_row] + 1 && (move[:to_col] == move[:from_col] + 1 || move[:to_col] == move[:from_col] - 1)
    else#black
      move[:to_row] == move[:from_row] - 1 && (move[:to_col] == move[:from_col] + 1 || move[:to_col] == move[:from_col] - 1)
    end
  end

end

class Bishop
  def initialize(color)
    @color = color
    if color == "white"
      @icon_code = "\u2657"
    else
      @icon_code = "\u265D"
    end
  end

  def move_legal?(move)
    move[:from_row]-move[:to_row] == move[:from_col]-move[:to_col] || move[:from_row]-move[:to_row] == -(move[:from_col]-move[:to_col])
  end

  def capture_legal?(move)
    move_legal?(move)
  end

end

class Knight
  def initialize(color)
    @color = color
    if color == "white"
      @icon_code = "\u2658"
    else
      @icon_code = "\u265E"
    end
  end

  def move_legal?(move)
    #divided in parts
    a = (move[:from_row]-move[:to_row] == -2 && (move[:from_col]-move[:to_col] == -1 || move[:from_col]-move[:to_col] == 1))
    b = (move[:from_row]-move[:to_row] == -1 && (move[:from_col]-move[:to_col] == -2 || move[:from_col]-move[:to_col] == 2))
    c = (move[:from_row]-move[:to_row] ==  1 && (move[:from_col]-move[:to_col] == -2 || move[:from_col]-move[:to_col] == 2))
    d = (move[:from_row]-move[:to_row] ==  2 && (move[:from_col]-move[:to_col] == -1 || move[:from_col]-move[:to_col] == 1))
    a||b||c||d
  end

  def capture_legal?(move)
    move_legal?(move)
  end
end

class Rook
  def initialize(color)
    @color = color
    if color == "white"
      @icon_code = "\u2656"
    else
      @icon_code = "\u265C"
    end
  end

  def move_legal?(move)
    move[:from_row] == move[:to_row] || move[:from_col] == move[:to_col]
  end

  def capture_legal?(move)
    move_legal?(move)
  end

  #def path(move) to queen, bishop and rook, returns an array with all tiles in their path, to test if they are jumping someone
  #
  #
  #
  #

end
