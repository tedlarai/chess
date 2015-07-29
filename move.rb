module Move

  def other_color(color)
    if color == "white"
      "black"
    else
      "white"
    end
  end

  def prompt_move(player_color)
    puts "#{player_color.capitalize}, your move: (ex.: a1 c4)"
    move = gets.chomp.downcase
  end

  def correct_input?(input) #private
    if input =~ /[a-z]\d\s[a-z]\d/
      return true
    else
      File.open('message.txt', 'w+'){|f| f.write("Invalid format, try again!")}
      return false
    end
  end

  def format_input_move(input)
    output = input.split("")-[" "] #creates an array [from_row, from_col, to_row, to_col]
    output_move = [[output[1].to_i, map_col(output[0])], [output[3].to_i, map_col(output[2])]]
  end

  def map_col(col)
    letters = Array("a".."z")
    letters.find_index(col)+1
  end


  
end
