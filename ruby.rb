# 1. computer randomly selects 4 numbers (linked to colours)
# 2. ask the player to guess 4 colours
# 3. If colour in right place = O if right colour wrong place X
# 4. If person guesses color = win 
# 5. 12 turns 


class Computer

    def random_selection
        rand_num = rand 0..5
        colour_options = ["Red", "Blue", "Yellow", "Orange", "Purple", "Green"]
        rand_colour = colour_options[rand_num]
        puts rand_colour
        rand_colour
    end 

end 


class Player 

    def player_selection
        puts "Guess a combination of 4 colours (Red, Blue, Yellow, Orange, Purple, Green) 
with each colour separated by a space. 
For example: red blue green orange"
        player_selection = gets.chomp 
        player_selection = player_selection.split(" ")
        p player_selection
        player_selection
    end 
        

end 

class Game

    def check_selection

        
    end 


end 


computer = Computer.new()
computer.random_selection
player = Player.new()
player.player_selection()
