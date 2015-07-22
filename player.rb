class Player
  attr_reader(:color)
  def initialize(color)
    @color = color.capitalize
  end

  def prompt_move #private
    puts "#{@color}, your move: (ex.: a1 c4)"
    move = gets.chomp.downcase
  end

  def check_move(move) #private
      if move =~ /[a-z]\d\s[a-z]\d/
        return move
      else
        puts "Invalid format, try again."
      end
  end

  def move
    input_move = nil
    loop do
      input_move = check_move(prompt_move)
      break unless input_move.nil?
    end
    output = input_move.split(" ")
    output_move = {from: output[0], to: output[1]}
  end
end
