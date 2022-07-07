# # frozen_string_literal: true

# # 1. computer randomly selects 4 numbers (linked to colours)
# # 2. ask the player to guess 4 colours
# # 3. If colour in right place = O if right colour wrong place X
# # 4. If person guesses color = win
# # 5. 12 turns

class Game
  attr_accessor :game_running

  def initialize(comp_selection, player_selection, duplicate)
    @comp_selection = comp_selection
    @duplicate = duplicate
    @player_selection = player_selection
    @game_running = true
    @board = []
  
  end

  def check_win
    if @comp_selection == @player_selection
      puts 'You win!'
      @game_running = false
    end
  end



  def check_position_and_colour
    @player_selection.each_index do |index|
      # p "#{index} INDEX "
      # p "#{@comp_selection[index]} comp selection index"
      # p "#{@player_selection[index]} player selection index"

      if @comp_selection[index] == @player_selection[index]
        # p "#{index} same alert "
        # p "#{@comp_selection} original"
        # @duplicate.delete(@player_selection[index])
        # p "#{@duplicate} dupli dupli "
        @board << 'O'
      elsif @duplicate.include?(@player_selection[index])
        @board << "X"
        @duplicate.delete(@player_selection[index])
      end 

    end 
  end 





  def display_board
    p @board
    puts "\n"
  end
end

class Computer
  attr_accessor :round

  def initialize
    @comp_selection = []
    @round = 0 
    
  end

  def random_selection
    i = 0
    until i == 4
      @rand_num = rand 0..5
      @colour_options = %w[Red Blue Yellow Orange Purple Green]
      @comp_selection << @colour_options[@rand_num]
      i += 1
    end
    # p @comp_selection
    @comp_selection
  end

  def guess_code
    @comp_guess = ["Red", "Red", "Red", "Red"]
  end 
end

class Player
  attr_accessor :round

  def initialize
    @round = 0
  end

  def player_input
    puts "Guess a combination of 4 colours (Red, Blue, Yellow, Orange, Purple, Green)
with each colour separated by a space.
For example: Red Blue Green Orange
If colour in right place, you get O. If it is the right colour, but wrong place you get X"
    @player_selection = gets.chomp
    @round += 1
    puts "round #{@round}"
    @player_selection
  end

  def player_choice(player_selection)
    @player_selection = player_selection
    @player_selection = @player_selection.split(' ')
    puts "Player Selection:#{@player_selection}"
    @player_selection = @player_selection.map(&:capitalize)
    @player_selection
  end

  def player_code
    puts "Select a code for the computer to guess. Write a combination of 4 colours (Red, Blue, Yellow, Orange, Purple, Green)
with each colour separated by a space. For example: Red Blue Yellow Orange"
    @player_code = gets.chomp
    puts "#{player_choice(@player_code)}"
    @player_code

    

  end 




end


class RunLogic
  
  def initialize 
    @computer = Computer.new
    @comp_selection = @computer.random_selection
    @code_guesser = false 
    @code_maker = false 
    @player = Player.new

  
  end

  def select_mode
    puts "Would you like to be the code maker or code guesser. Type maker/guesser"
    @mode = gets.chomp
    if @mode.downcase == "maker" 
      @code_maker = true 
      @code_guesser = false
    elsif @mode.downcase == "guesser"
      @code_maker = false 
      @code_guesser = true 
    end 
  end 

  def round 

    if @code_guesser == true 
      until @player.round == 12
        @duplicate = []
        @comp_selection.each {|colour| @duplicate << colour}
        player_selection = @player.player_input
        @player_choice = @player.player_choice(player_selection)
        game = Game.new(@comp_selection, @player_choice, @duplicate)
        game.check_win
        game.check_position_and_colour
        game.display_board
        break if game.game_running == false
        end
      end 
    
    
    if @code_maker == true 
      until @computer.round == 12 
        @duplicate = []
        @player_selection = @player.player_code()
        @player_selection = @player.player_choice(@player_selection)
        @player_selection.each {|colour| @duplicate << colour}
        @comp_selection = @computer.guess_code()
        game = Game.new(@player_selection, @comp_selection, @duplicate) #reversed to get match as code maker 
        game.check_win
        game.check_position_and_colour
        game.display_board
        break if game.game_running == false
        end 
      end 
    end
    
    
  end 


  


end 


run = RunLogic.new
run.select_mode
run.round()


