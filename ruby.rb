# 1. computer randomly selects 4 numbers (linked to colours)
# 2. ask the player to guess 4 colours
# 3. If colour in right place = O if right colour wrong place X
# 4. If person guesses color = win 
# 5. 12 turns 
module Game

    def check_win
        if @@comp_selection[0] == "yellow"
            puts "WOO!"
        end 

    end 


end 

class Computer
    
    include Game
    
    def initialize
        @@comp_selection = Array.new()
    end 

    def random_selection
        @rand_num = rand 0..5
        @colour_options = ["Red", "Blue", "Yellow", "Orange", "Purple", "Green"]
        @rand_colour = @colour_options[@rand_num]
        puts @rand_colour
        @@comp_selection << @rand_colour
    end 

    def comp_choice
        random_selection()
        random_selection()
        random_selection()
        random_selection()
        p @@comp_selection
        @@comp_selection = ["yellow", "yellow", "yellow", "yellow"]
        p @@comp_selection

    end 

end 


class Player 
    
    include Game

    def player_selection
        puts "Guess a combination of 4 colours (Red, Blue, Yellow, Orange, Purple, Green) 
with each colour separated by a space. 
For example: red blue green orange"
        @player_selection = gets.chomp 
        @player_selection = player_selection.split(" ")
        p @player_selection
        @player_selection
    end 
        

end 




computer = Computer.new()
computer.comp_choice
player = Player.new()
player.player_selection()
game = Game.new()
player.check_win()