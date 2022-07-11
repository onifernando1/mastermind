# frozen_string_literal: true

# # frozen_string_literal: true

# # 1. computer randomly selects 4 numbers (linked to colours)
# # 2. ask the player to guess 4 colours
# # 3. If colour in right place = O if right colour wrong place X
# # 4. If person guesses color = win
# # 5. 12 turns

class Game
  attr_accessor :game_running, :board

  def initialize(comp_selection, player_selection, duplicate)
    @comp_selection = comp_selection
    @duplicate = duplicate
    @player_selection = player_selection
    @game_running = true
    @board = []
  end

  def check_win
    if @comp_selection == @player_selection
      puts 'Code breaker wins!'
      @game_running = false
    end
  end

  def check_position_and_colour
    @player_selection.each_index do |index|
      if @comp_selection[index] == @player_selection[index]
        @board << 'O'
      elsif @duplicate.include?(@player_selection[index])
        @board << 'X'
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
    @sum_of_circles = 0
    @sum_of_xs = 0
    @comp_guess = %w[Red Red Red Red]
  end

  def random_colour
    @rand_num = rand 0..5
    @colour_options = %w[Red Blue Yellow Orange Purple Green]
    @rand_colour = @colour_options[@rand_num]
    @rand_colour
  end

  def random_selection
    i = 0
    until i == 4
      random_colour
      @comp_selection << @rand_colour
      i += 1
    end
    # p @comp_selection
    @comp_selection
  end

  def sum_of_circles(board)
    @sum_of_circles = 0
    board.each_index do |index|
      @sum_of_circles += 1 if board[index] == 'O'
    end
    @sum_of_circles
  end

  def sum_of_xs(board)
    @sum_of_xs = 0
    board.each_index do |index|
      @sum_of_xs += 1 if board[index] == 'O'
    end
    @sum_of_xs
  end

  def guess_algorithim
    @comp_guess = %w[Red Red Red Red] if @round.zero?

    case @sum_of_circles
    when 0
      @comp_guess[0] = random_colour
      @comp_guess[1] = random_colour
      @comp_guess[2] = random_colour
      @comp_guess[3] = random_colour
    when 1
      @comp_guess[0] = @comp_guess[0]
      @comp_guess[1] = random_colour
      @comp_guess[2] = random_colour
      @comp_guess[3] = random_colour
    when 2
      @comp_guess[0] = @comp_guess[0]
      @comp_guess[1] = @comp_guess[1]
      @comp_guess[2] = random_colour
      @comp_guess[3] = random_colour
    when 3
      @comp_guess[0] = @comp_guess[0]
      @comp_guess[1] = @comp_guess[1]
      @comp_guess[2] = @comp_guess[2]
      @comp_guess[3] = random_colour
    end

    case @sum_of_xs
    when 0
      @comp_guess[0] = @comp_guess[0]
      @comp_guess[1] = @comp_guess[1]
      @comp_guess[2] = @comp_guess[2]
      @comp_guess[3] = @comp_guess[3]
    when 1
      @comp_guess[0] = @comp_guess[0]
      @comp_guess[1] = @comp_guess[1]
      @comp_guess[2] = @comp_guess[2]
      @comp_guess[3] = @comp_guess[2]
    when 2
      @comp_guess[0] = @comp_guess[3]
      @comp_guess[1] = @comp_guess[1]
      @comp_guess[2] = @comp_guess[2]
      @comp_guess[3] = @comp_guess[0]
    when 3
      @comp_guess[0] = @comp_guess[3]
      @comp_guess[1] = @comp_guess[2]
      @comp_guess[2] = @comp_guess[1]
      @comp_guess[3] = @comp_guess[3]
    end
    p @comp_guess
    @round += 1
    @comp_guess
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
    puts player_choice(@player_code).to_s
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
    puts 'Would you like to be the code maker or code guesser. Type maker/guesser'
    @mode = gets.chomp
   if @mode == 'maker'
    @code_maker = true 
   end 
   if @mode == 'guesser'
    @code_guesser = true
   end  
  end

  def round
    if @code_guesser == true
      until @player.round == 12
        @duplicate = []
        @comp_selection.each { |colour| @duplicate << colour }
        player_selection = @player.player_input
        @player_choice = @player.player_choice(player_selection)
        game = Game.new(@comp_selection, @player_choice, @duplicate)
        game.check_win
        game.check_position_and_colour
        game.display_board
        break if game.game_running == false
      end
    end

    if @code_maker == false
      @duplicate = []
      @player_selection = @player.player_code
      @player_selection = @player.player_choice(@player_selection)
      @player_selection.each { |colour| @duplicate << colour }
      # @comp_selection = ["Red", "Red", "Red", "Red"]
      until @computer.round == 12
        # @comp_selection = @computer.guess_code
        @comp_selection = @computer.guess_algorithim
        game = Game.new(@player_selection, @comp_selection, @duplicate) # reversed to get match as code maker
        game.check_win
        game.check_position_and_colour
        game.display_board
        board = game.board
        @computer.sum_of_circles(board)
        break if game.game_running == false
      end
    end
  end
end

run = RunLogic.new
run.select_mode
run.round
