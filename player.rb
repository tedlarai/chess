class Player
  attr_reader(:color)
  def initialize(color)
    @color = color
  end

  def prompt_move #private
    puts "#{@color.capitalize}, your move: (ex.: a1 c4)"
    move = gets.chomp.downcase
  end


  def move_legal?(move) #private
    if move =~ /[a-z]\d\s[a-z]\d/
      return true
    else
      puts "Invalid format, try again." ############### to file
      return false
    end
  end

  def format_move(input_move)
    output = input_move.split("")-[" "] #creates an array [from_row, from_col, to_row, to_col]
    output_move = [[output[1].to_i, map_col(output[0])], [output[3].to_i, map_col(output[2])]]
  end

  def map_col(col)
    letters = Array("a".."z")
    letters.find_index(col)+1
  end

end
