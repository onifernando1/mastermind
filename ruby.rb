# frozen_string_literal: true

# 1. computer randomly selects 4 numbers (linked to colours)
# 2. ask the player to guess 4 colours
# 3. If colour in right place = O if right colour wrong place X
# 4. If person guesses color = win
# 5. 12 turns

class Game
  attr_accessor :game_running

  def initialize(comp_selection, player_selection)
    @comp_selection = comp_selection
    @player_selection = player_selection
    # p "#{@comp_selection} from Game class "
    # p @player_selection
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
 
    @player_selection.each_index {|index| 
      if @comp_selection[index] == @player_selection[index] 
        @board << "O"
      elsif @player_selection.include? @comp_selection[index]
        @board << "X" 
      end 
    }

  end 
 



  def display_board
    p @board
    puts "\n" 
  end 

end

class Computer
  # attr_accessor :comp_selection

  def initialize
    @comp_selection = []
  end

  def random_selection
    i = 0
    until i == 4
      @rand_num = rand 0..5
      @colour_options = %w[Red Blue Yellow Orange Purple Green]
      @comp_selection << @colour_options[@rand_num]
      # p @comp_selection
      i += 1
    end

    @comp_selection
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
For example: Red Blue Green Orange"
    @player_selection = gets.chomp
    @round += 1 
    puts "round #{@round}"
  end

  def player_choice
    @player_selection = @player_selection.split(' ')
    p "Player Selection:#{@player_selection}"
    @player_selection = @player_selection.map(&:capitalize)
    @player_selection
  end

  def game_check
    if game.game_running == false 
      puts "ASDLJAKSDLKASJD"
    end 
  end 
end

class RunLogic

  computer = Computer.new
  comp_selection = computer.random_selection
  player = Player.new

  until player.round == 12 || 
    player.player_input
    player_choice = player.player_choice()
    game = Game.new(comp_selection, player_choice)
    game.check_win
    game.check_position_and_colour
    game.display_board
    if game.game_running == false 
      break
    end 
  end 

end 

RunLogic.new()
