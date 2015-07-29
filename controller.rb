require_relative './game.rb'
require_relative './menu.rb'


menu = Menu.new
loop do
  menu.show
  option = menu.get_option
  case option
  when "1"
    game = Game.new
    game.game_loop
    next
  when "2"
    game = Marshal.load(File.read('saved_game'))
    game.game_loop
    next
  when "3"
    puts "Quit. Are you sure? (y/n)"
    ans = gets.chomp
    if ans == 'y'
      exit
    else
      next
    end
  else
    puts "Wrong option! You must choose 1, 2 or 3. Press any key to continue:"
    gets
    next
  end
end
