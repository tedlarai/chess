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

  def move_legal?(from, to) #hash keys{:from_row :from_col :from_row :to_col}
    if @color == "white"
      if from[0] == 2#starting position
       (to[0] == from[0] + 1 || to[0] == from[0] + 2) && to[1] == from[1]
      else #moved
        to[0] == from[0] + 1 && to[1] == from[1]
      end
    else #black
      if from[0] == 7 #starting position
        (to[0] == from[0] - 1 || to[0] == from[0] - 2) && to[1] == from[1]
      else #moved
        to[0] == from[0] - 1 && to[1] == from[1]
      end
    end
  end

  def capture_legal?(from, to)
    if @color == 'white'
      to[0] == from[0] + 1 && (to[1] == from[1] + 1 || to[1] == from[1] - 1)
    else#black
      to[0] == from[0] - 1 && (to[1] == from[1] + 1 || to[1] == from[1] - 1)
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

  def move_legal?(from, to)
    from[0]-to[0] == from[1]-to[1] || from[0]-to[0] == -(from[1]-to[1])
  end

  def capture_legal?(from, to)
    move_legal?(from, to)
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

  def move_legal?(from, to)
    #divided in parts
    a = (from[0]-to[0] == -2 && (from[1]-to[1] == -1 || from[1]-to[1] == 1))
    b = (from[0]-to[0] == -1 && (from[1]-to[1] == -2 || from[1]-to[1] == 2))
    c = (from[0]-to[0] ==  1 && (from[1]-to[1] == -2 || from[1]-to[1] == 2))
    d = (from[0]-to[0] ==  2 && (from[1]-to[1] == -1 || from[1]-to[1] == 1))
    a||b||c||d
  end

  def capture_legal?(from, to)
    move_legal?(from, to)
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

  def move_legal?(from, to)
    from[0] == to[0] || from[1] == to[1]
  end

  def capture_legal?(from, to)
    move_legal?(from, to)
  end

  #def path(from, to) to queen, bishop and rook, returns an array with all tiles in their path, to test if they are jumping someone
  #
  #
  #
  #

end

class Queen
  def initialize(color)
    @color = color
    if color == "white"
      @icon_code = "\u2655"
    else
      @icon_code = "\u265B"
    end
  end

  def move_legal?(from, to)
    l_bishop = from[0]-to[0] == from[1]-to[1] || from[0]-to[0] == -(from[1]-to[1])
    l_rook = from[0] == to[0] || from[1] == to[1]
    l_bishop || l_rook
  end

  def capture_legal?(from, to)
    move_legal?(from, to)
  end
end

class King
  def initialize(color)
    @color = color
    if color == "white"
      @icon_code = "\u2654"
    else
      @icon_code = "\u265A"
    end
  end

  def move_legal?(from, to)
    (from[0]-to[0]).abs <=1 && (from[1]-to[1]).abs <=1
  end

  def capture_legal?(from, to)
    move_legal?(from, to)
  end
end
