class Menu
  def show
    system('clear')
    puts "Welcome to Chess!\n\n"
    puts "1...New Game"
    puts "2..Load Game"
    puts "3..Quit Game"
    print "\nEnter your option: "
  end
  def get_option
    option = gets.chomp
  end
end
