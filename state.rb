require_relative './pieces.rb'

class State #manage the state of the game (pieces positions and moves), checking it for special positions (check, mate, draw)
  #note to myself: I examined the possibity of extraction of the moving methods to a separate module, because this class is so big (in sheer code length). I will not do this because: 1, For now, I think they fit here, they are  this class responsibility. 2, The code length, not pure design, gave birth to my doubts about this. Following one principle of design, I will postpone my decision until I know more, or have a better understanding of the problem.
  def initialize
    @board = gen_board
    fill_board
    @captured = []
  end

  def gen_board
    board = {}
    rows = Array(1..8)
    cols = Array(1..8)
    tiles = rows.product(cols)
    board = Hash[tiles.map { |tile| [tile, nil]}]
    return board
  end

  def fill_board
    puts "hey!! fill_board!!"
    @board.keys.each do |r, c|
          case r
          when 1
            case c
            when 1
              @board[[r,c]] = Rook.new("white")
            when 2
              @board[[r,c]] = Knight.new("white")
            when 3
              @board[[r,c]] = Bishop.new("white")
            when 4
              @board[[r,c]] = Queen.new("white")
            when 5
              @board[[r,c]] = King.new("white")
            when 6
              @board[[r,c]] = Bishop.new("white")
            when 7
              @board[[r,c]] = Knight.new("white")
            when 8
              @board[[r,c]] = Rook.new("white")
            end
          when 2
            @board[[r,c]] = Pawn.new('white')
          when 7
            @board[[r,c]] = Pawn.new('black')
          when 8
            case c
            when 1
              @board[[r,c]] = Rook.new("black")
            when 2
              @board[[r,c]] = Knight.new("black")
            when 3
              @board[[r,c]] = Bishop.new("black")
            when 4
              @board[[r,c]] = Queen.new("black")
            when 5
              @board[[r,c]] = King.new("black")
            when 6
              @board[[r,c]] = Bishop.new("black")
            when 7
              @board[[r,c]] = Knight.new("black")
            when 8
              @board[[r,c]] = Rook.new("black")
            end
          end
    end
  end

  def show
    a = "   " + "_" * 49 + "\n"

    e = "   |     |#####|     |#####|     |#####|     |#####|\n"
    c = "x|  x  |# x #|  x  |# x #|  x  |# x #|  x  |# x #|\n"
    g = "   |_____|#####|_____|#####|_____|#####|_____|#####|\n"

    b = "   |#####|     |#####|     |#####|     |#####|     |\n"
    f = "x|# x #|  x  |# x #|  x  |# x #|  x  |# x #|  x  |\n"
    d = "   |#####|_____|#####|_____|#####|_____|#####|_____|\n"

    board_show = (@board.map do |k,v|
      if v.nil?
        [k, " "]
      else
        [k,v.icon_code]
      end
    end).to_h

    print a
    for i in (1..8) do
      x = 9-i
      if x % 2 == 0
        print b
        print " #{x} |# #{board_show[[x,1]]} #|  #{board_show[[x,2]]}  |# #{board_show[[x,3]]} #|  #{board_show[[x,4]]}  |# #{board_show[[x,5]]} #|  #{board_show[[x,6]]}  |# #{board_show[[x,7]]} #|  #{board_show[[x,8]]}  |\n"
        print d
      else
        print e
        print " #{x} |  #{board_show[[x,1]]}  |# #{board_show[[x,2]]} #|  #{board_show[[x,3]]}  |# #{board_show[[x,4]]} #|  #{board_show[[x,5]]}  |# #{board_show[[x,6]]} #|  #{board_show[[x,7]]}  |# #{board_show[[x,8]]} #|\n"
        print g
      end
    end
    puts
    print "   "
    for i in ("a".."h") do
      print "   #{i}  "
    end
    print "\n\n"
    message = ""
    File.open('message.txt', 'r'){|f| message =  f.gets}
    unless message.nil?
      print "#{message} \n\n"
    end

  end

  # from here, there will be a bunch os helper testing methods used by #move_legal?
  def move_to_different_tile?(from,to)
    if from == to
      File.open('message.txt', 'w+'){|f| f.write("Destination has to be different from origin try again!")}
      return false
    else
      true
    end
  end

  def from_has_a_piece?(from)
    if @board[from].nil?
      File.open('message.txt', 'w+'){|f| f.write("There is no piece on that tile! try again!")}
      return false
    else
      true
    end
  end

  def piece_same_color_as_player?(piece, player)
    if player.color != piece.color
      File.open('message.txt', 'w+'){|f| f.write("Not your piece!!")}
      return false
    else
      true
    end
  end

  def in_bounds?(tile)
    in_rows = tile[0] <= 8 && tile[0] >= 1
    in_cols = tile[1] <= 8 && tile[1] >= 1
    in_rows && in_cols
  end

  def to_in_bounds?(to)
    unless in_bounds?(to)
      File.open('message.txt', 'w+'){|f| f.write("Destination tile out of bounds")}
      return false
    else
      true
    end
  end

  def capture_try?(to) #type checking, refactor???
    !(@board[to].nil?)
  end

  def not_capturing_own_piece?(player, to)
    if capture_try?(to) && player.color == @board[to].color
      File.open('message.txt', 'w+'){|f| f.write("Cannot capture a piece of the same color!")}
      return false
    else
      true
    end
  end

  def piece_capable_of_move?(piece, from, to)
    unless capture_try?(to) #no capture
      unless piece.move_legal?(from, to)
        File.open('message.txt', 'w+'){|f| f.write("#{piece.class} is not capable of this move!")}
        return false
      else
        true
      end
    else #capture
      unless piece.capture_legal?(from, to)
        File.open('message.txt', 'w+'){|f| f.write("#{piece.class} is not capable of this capture!")}
        return false
      else
        true
      end
    end
  end

  def not_jumping_other_pieces?(piece, from, to)
    path = piece.path(from, to)
    path.each do |tile|
      unless @board[tile].nil?
        File.open('message.txt', 'w+'){|f| f.write("#{piece.class} can't jump the #{@board[tile].class}")}
        return false
      else
        true
      end
    end
  end

  def leaving_tile_between_kings?(piece, to)
    if piece.instance_of?(King)
      other_king_position = nil
      @board.each do |k,v|
        if (v.instance_of?(King) && !(v.equal?(piece)))
          other_king_position = k
          break
        end
      end
      unless (other_king_position[0] - to[0]).abs > 1 || (other_king_position[1] - to[1]).abs > 1
        File.open('message.txt', 'w+'){|f| f.write("Kings too close!! Illegal move, try again!")}
        return false
      end
    else
      true
    end
  end

  def not_leaving_own_king_in_check?(player, from, to)
    save_board = @board.clone
    move(from, to)
    if king_in_check?(player.color)
      @board = save_board
      File.open('message.txt', 'w+'){|f| f.write("Leaving own king in check!!")}
      return false
    else
      @board = save_board
      return true
    end
  end

  def move_legal?(player, from, to)
    piece = @board[from]

    #The next code line will be huge, and will execute the following testing methods, returning true if all of them are true
    #move_to_different_tile?
    #from_has_a_piece?
    #piece_same_color_as_player?
    #to in_bounds?
    #not_capturing_own_piece?
    #piece_capable_of_move?
    #not_jumping_other_pieces?
    #leaving_tile_between_kings?
    #not_leaving_own_king_in_check?

    return (move_to_different_tile?(from, to) && from_has_a_piece?(from) && piece_same_color_as_player?(piece, player) && to_in_bounds?(to) && not_capturing_own_piece?(player, to) && piece_capable_of_move?(piece, from, to) && not_jumping_other_pieces?(piece, from, to) && leaving_tile_between_kings?(piece, to) && not_leaving_own_king_in_check?(player, from, to))
  end

  def move(from, to)
    unless @board[to].nil? ## capture
      @captured << @board[to]
    end
    @board[to] = @board[from]
    @board[from] = nil
  end

  def find_king_position(player)
    @board.each do |k,v|
      if v.instance_of?(King) && v.color == player.color
        return k
      end
    end
  end

  def king_in_check?(player)
    king_color = player.color
    if king_color == "white"
      other_color = "black"
    else
      other_color = "white"
    end

    king_position = find_king_position(player)

    @board.each do |k,v|
      if !(v.nil?) && v.color == other_color
        if move_legal?()
          return true
        end
      end
    end
    return false

  end

  def has_legal_moves?(player)
    pieces_to_check = @board.select do |k,v|
      !(v.nil?) && v.color == player.color
    end
    pieces_to_check.each do |k,v|
      @board.each do |bk, bv|
        if move_legal?(player, k, bk)
          return true
        end
      end
    end
    return false
  end

end
