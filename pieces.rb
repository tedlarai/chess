class Pieces
  #common methods
end

class Pawn
  attr_reader(:icon_code)
  def initialize(color)
    @color = color
    if color == "black"
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

  def path(from, to)
    path = []
    if (from[0]-to[0]).abs == 2
      path_row = (to[0]-from[0])/2 + from[0]
      path << [path_row, from[1]]
    end
    return path
  end

end

class Bishop
  attr_reader(:icon_code)
  def initialize(color)
    @color = color
    if color == "black"
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

  def path(from, to)
    path = []
    path_rows = Bishop.path_range(from[0], to[0])
    path_cols = Bishop.path_range(from[1], to[1])
    path_rows.each_with_index {|x,i| path << [x, path_cols[i]]}
    return path
  end

  def Bishop.path_range(num1, num2) #returns all numbers between them, in the same order as nums
    path = []
    if num1 > num2
      return Bishop.path_range(num2, num1).reverse
    else
      c = num1+1
      while c < num2
        path << c
        c += 1
      end
      return path
    end
  end

end

class Knight
  attr_reader(:icon_code)
  def initialize(color)
    @color = color
    if color == "black"
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

  def path(from, to) #duckTyping, no path for knight
    []
  end
end

class Rook
  attr_reader(:icon_code)
  def initialize(color)
    @color = color
    if color == "black"
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

  def path(from, to)
    path = []
    if from[0] == to[0]#same row
      aux = Bishop.path_range(from[1], to[1])
      aux.each {|x| path << [from[0], x]}
    else#same col
      aux = Bishop.path_range(from[0], to[0])
      aux.each {|x| path << [x,from[1]]}
    end
    return path
  end

end

class Queen
  attr_reader(:icon_code)
  def initialize(color)
    @color = color
    if color == "black"
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

  def path(from, to)
    path = []
    if from[0] == to[0] || from[1] == to[1] ##rook-like move
      if from[0] == to[0]#same row
        aux = Bishop.path_range(from[1], to[1])
        aux.each {|x| path << [from[0], x]}
      else#same col
        aux = Bishop.path_range(from[0], to[0])
        aux.each {|x| path << [x,from[1]]}
      end
      return path
    else ##bishop like move
      path_rows = Bishop.path_range(from[0], to[0])
      path_cols = Bishop.path_range(from[1], to[1])
      path_rows.each_with_index {|x,i| path << [x, path_cols[i]]}
      return path
    end
  end
end


class King
  attr_reader(:icon_code)
  def initialize(color)
    @color = color
    if color == "black"
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

  def path(a,b)#duckTyping
    []
  end

end
