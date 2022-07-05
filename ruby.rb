# frozen_string_literal: true

# 1. computer randomly selects 4 numbers (linked to colours)
# 2. ask the player to guess 4 colours
# 3. If colour in right place = O if right colour wrong place X
# 4. If person guesses color = win
# 5. 12 turns

class Game
  # attr_accessor :comp_selection

  def initialize(comp_selection, player_selection)
    @comp_selection = comp_selection
    @player_selection = player_selection
    p @comp_selection
    p @player_selection
    @game_running = true
  end

  def check_win
    if @comp_selection == @player_selection
      puts 'You win!'
      @game_running = false
    end
  end

  def check_colours
    @player_selection.each do |colour|
      puts "#{colour} colour right!" if @comp_selection.include? colour
    end
  end
end

class Computer
  # attr_accessor :comp_selection

  def initialize
    @@comp_selection = []
  end

  def random_selection
    i = 0
    until i == 4
      @rand_num = rand 0..5
      @colour_options = %w[Red Blue Yellow Orange Purple Green]
      @@comp_selection << @colour_options[@rand_num]
      p @@comp_selection
      i += 1
    end

    @@comp_selection
  end
end

class Player
  def player_input
    puts "Guess a combination of 4 colours (Red, Blue, Yellow, Orange, Purple, Green)
with each colour separated by a space.
For example: Red Blue Green Orange"
    @@player_selection = gets.chomp
  end

  def player_choice
    @@player_selection = @@player_selection.split(' ')
    p @@player_selection
    @@player_selection = @@player_selection.map(&:capitalize)
    @@player_selection
  end
end

computer = Computer.new
comp_selection = computer.random_selection
player = Player.new
player.player_input
player_choice = player.player_choice()
game = Game.new(comp_selection, player_choice)
game.check_win
game.check_colours
