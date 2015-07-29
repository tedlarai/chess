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

end
