# frozen_string_literal: true

# 1. computer randomly selects 4 numbers (linked to colours)
# 2. ask the player to guess 4 colours
# 3. If colour in right place = O if right colour wrong place X
# 4. If person guesses color = win
# 5. 12 turns
# Note logic is wrong :

class Game
  attr_accessor :game_running

  def initialize(comp_selection, player_selection)
    @comp_selection = comp_selection
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
      if @comp_selection[index] == @player_selection[index]
        @board << 'O'
      elsif @player_selection[index] == @comp_selection[0] || @player_selection[index] == @comp_selection[1] ||@player_selection[index] == @comp_selection[2] ||@player_selection[index] == @comp_selection[3]
        @board << "X"
      end
    end
  end

  def display_board
    p @board
    puts "\n"
  end
end

class Computer
  def initialize
    @comp_selection = []
  end

  def random_selection
    i = 0
    until i == 4
      @rand_num = rand 0..5
      @colour_options = %w[Red Blue Yellow Orange Purple Green]
      @comp_selection << @colour_options[@rand_num]
      i += 1
    end
    p @comp_selection
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
For example: Red Blue Green Orange
If colour in right place, you get O. If it is the right colour, but wrong place you get X"
    @player_selection = gets.chomp
    @round += 1
    puts "round #{@round}"
  end

  def player_choice
    @player_selection = @player_selection.split(' ')
    puts "Player Selection:#{@player_selection}"
    @player_selection = @player_selection.map(&:capitalize)
    @player_selection
  end
end

class RunLogic
  
  def initialize 
    computer = Computer.new
    comp_selection = computer.random_selection
    player = Player.new

    until player.round == 12
      player.player_input
      player_choice = player.player_choice()
      game = Game.new(comp_selection, player_choice)
      game.check_win
      game.check_position_and_colour
      game.display_board
      break if game.game_running == false
    end
  end 
end

RunLogic.new
