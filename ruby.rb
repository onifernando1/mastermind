# 1. computer randomly selects 4 numbers (linked to colours)
# 2. ask the player to guess 4 colours
# 3. If colour in right place = O if right colour wrong place X
# 4. If person guesses color = win 
# 5. 12 turns 

class Game 

    attr_accessor :comp_selection

    def initialize(comp_selection)
        @player = Player.new
        @comp_selection = comp_selection
    end 

    def comp_reveal
        puts "#{@comp_selection} from comp reveal"
    end 


end 


class Computer 

    attr_accessor :comp_selection

    def initialize
        @@comp_selection = Array.new()

    end 

    def random_selection
        i = 0 
        until i == 4 
            @rand_num = rand 0..5
            @colour_options = ["Red", "Blue", "Yellow", "Orange", "Purple", "Green"]
            @@comp_selection << @colour_options[@rand_num]
            i += 1 
         
        end 
        
         @@comp_selection
    end

end 


class Player 
    

    def player_input
        puts "Guess a combination of 4 colours (Red, Blue, Yellow, Orange, Purple, Green) 
with each colour separated by a space. 
For example: red blue green orange"
        @@player_selection = gets.chomp 
    end 

    def player_choice
        @@player_selection = @@player_selection.split(" ")
        p @@player_selection
        @@player_selection
    end 
        

end 

computer = Computer.new()
game = Game.new(computer.random_selection)
game.comp_reveal