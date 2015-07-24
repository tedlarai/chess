class Player
  attr_reader(:color)
  def initialize(color)
    @color = color
  end

  def prompt_move #private
    puts "#{@color.capitalize}, your move: (ex.: a1 c4)"
    move = gets.chomp.downcase
  end

  def check_move(move) #private
      if move =~ /[a-z]\d\s[a-z]\d/
        return move
      else
        puts "Invalid format, try again."
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

  def player_move
    input_move = nil
    loop do
      input_move = check_move(prompt_move)
      break unless input_move.nil?
    end
    output_move = format_move(input_move)
  end
end
