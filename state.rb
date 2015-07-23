class State


end

class Board
  def initialize

  end

  def gen_board
    board = {}
    tile = {row: nil, col: nil}
    rows = Array(1..8)
    cols = Array(1..8)
    rows.each do |row|
      tile[:row] = row
      cols.each do |col|
        tile[:col] = col
        board[tile]=nil
      end
    end
    return board
  end

end
