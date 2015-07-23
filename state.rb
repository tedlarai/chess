require_relative './pieces.rb'

class State
  include Enumerable
  def initialize
    @board = gen_board
    fill_board
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
              @board[[r,c]] = King.new("white")
            when 5
              @board[[r,c]] = Queen.new("white")
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
              @board[[r,c]] = King.new("black")
            when 5
              @board[[r,c]] = Queen.new("black")
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

  def in_bounds?(tile)#tile[row, col]
    in_rows = tile[0] <= 8 && tile[0] >= 1
    in_cols = tile[1] <= 8 && tile[1] >= 1
    in_rows && in_cols
  end

  def show
    a = "   " + "_" * 49 + "\n"

    b = "   |     |#####|     |#####|     |#####|     |#####|\n"
    c = "x|  x  |# x #|  x  |# x #|  x  |# x #|  x  |# x #|\n"
    d = "   |_____|#####|_____|#####|_____|#####|_____|#####|\n"

    e = "   |#####|     |#####|     |#####|     |#####|     |\n"
    f = "x|# x #|  x  |# x #|  x  |# x #|  x  |# x #|  x  |\n"
    g = "   |#####|_____|#####|_____|#####|_____|#####|_____|\n"

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
        print " #{x} |  #{board_show[[x,1]]}  |# #{board_show[[x,2]]} #|  #{board_show[[x,3]]}  |# #{board_show[[x,4]]} #|  #{board_show[[x,5]]}  |# #{board_show[[x,6]]} #|  #{board_show[[x,7]]}  |# #{board_show[[x,8]]} #|\n"
        print d
      else
        print e
        print " #{x} |# #{board_show[[x,1]]} #|  #{board_show[[x,2]]}  |# #{board_show[[x,3]]} #|  #{board_show[[x,4]]}  |# #{board_show[[x,5]]} #|  #{board_show[[x,6]]}  |# #{board_show[[x,7]]} #|  #{board_show[[x,8]]}  |\n"
        print g
      end
    end
    puts
    print "   "
    for i in ("a".."h") do
      print "   #{i}  "
    end
    print "\n\n"

  end

end
