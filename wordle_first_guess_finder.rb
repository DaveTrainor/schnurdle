require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'solutionlist'
require_relative 'validwords'
enable :sessions

get '/' do
    erb:main
end

class Game
    def initialize (form_input)
        @input_c = form_input
    end

    def input
        @input_c
    end

    
    def game_array
        @input_c.match /Wordle (\d{1,3})\s+\S{2,4}\s+(\S+).+/
    end

    def guess_expressed_in_colours
        translation = {'u2B1C': 'grey', 'u{1F7E8}': 'yellow', 'u{1F7E9}': 'green'}
        first_line_array = self.game_array[2].split('\\')
        first_line_array[1..5].map {|square| translation[square.to_sym]}
    end

    
    def game_number
        game_array[1]
    end
    

    def get_solution
        solutions_array = Solutions.past_solutions.split(" ").each_slice(4).to_a
        solutions_hash = Hash[solutions_array.each { |subarray| subarray.slice!(2..3)}]
        solutions_hash[self.game_number].downcase
    end

 
    def get_possible_chars
        possible_chars = []
        sol_arr = self.get_solution.scan /\w/
        
        self.guess_expressed_in_colours.each_with_index {|square, i| 
            
            if square == "green"
                possible_chars[i] = sol_arr[i]
            elsif square =="yellow"
                possible_chars[i] = sol_arr.join 
                possible_chars[i].delete! sol_arr[i]
            elsif square == "grey"
                possible_chars[i] = ('a'..'z').to_a.join()
                possible_chars[i].delete! self.get_solution          
            end
        }
        return possible_chars   
            
    end

    
    # def get_possible_words
    #     word_list_array = Valid_words.extended_list.split(" ")
    #     possible_chars = self.get_possible_chars
    #     possible_words = word_list_array.select {|word| 
    #         possible_chars[0].include?(word[0]) &&
    #         possible_chars[1].include?(word[1]) &&
    #         possible_chars[2].include?(word[2]) &&
    #         possible_chars[3].include?(word[3]) &&
    #         possible_chars[4].include?(word[4])}
    #          # == /^[possible_chars[0]][possible_chars[1]][possible_chars[2]][possible_chars[3]][possible_chars[4]]$/}
    #     possible_words.sort().join(", ")
    # end

end

def combine_poss_chars(poss_chars_1, poss_chars_2)
    poss_chars_1_arr = []
    poss_chars_1.each {|str| poss_chars_1_arr.push str.split("")}
    poss_chars_2_arr = []
    poss_chars_2.each {|str| poss_chars_2_arr.push str.split("")}
    combined_chars = []
    for i in 0..4 do
        combined_chars[i] = (poss_chars_1_arr[i] & poss_chars_2_arr[i]).join()
    end
    combined_chars
end


def get_possible_words(possible_chars)
    word_list_array = Valid_words.extended_list.split(" ")
    possible_words = word_list_array.select {|word| 
        possible_chars[0].include?(word[0]) &&
        possible_chars[1].include?(word[1]) &&
        possible_chars[2].include?(word[2]) &&
        possible_chars[3].include?(word[3]) &&
        possible_chars[4].include?(word[4])}
         # == /^[possible_chars[0]][possible_chars[1]][possible_chars[2]][possible_chars[3]][possible_chars[4]]$/}
    possible_words.sort().join(", ")
end

post '/results_1' do

    # begin

    input_1 = params[:game1].dump
    game_1 = Game.new(input_1)
    poss_chars_1 = game_1.get_possible_chars
    session[:game_1] = game_1

    erb:results_1st, :locals => {
        :game_number_1=>game_1.game_number, 
        :first_line_1=>game_1.guess_expressed_in_colours, 
        :solution_1=>game_1.get_solution,
        :poss_chars_1=>poss_chars_1.join("<br>"),
        :poss_words_1=>get_possible_words(poss_chars_1)
        
    }
    # rescue
    #    erb:invalid_input
    
    # end

end



post '/results_2' do
    game_1 = session[:game_1]
    puts "Session: #{session.inspect}"
    input_2 = params[:game2].dump
    game_2 = Game.new(input_2)
    poss_chars_1 = game_1.get_possible_chars.join("<br>")
    poss_chars_2 = game_2.get_possible_chars.join("<br>")
    combined_chars_1_2 = combine_poss_chars(game_1.get_possible_chars, game_2.get_possible_chars)
        
    session[:game_2] = game_2
        
    erb:results_2, :locals => {
  
        :input_1=>game_1.input.undump,
        :game_number_1=>game_1.game_number, 
        :first_line_1=>game_1.guess_expressed_in_colours, 
        :solution_1=>game_1.get_solution,
        :poss_chars_1=>poss_chars_1,
        :poss_words_1=>get_possible_words(poss_chars_1),

        :input_2=>game_2.input.undump,
        :game_number_2=>game_2.game_number, 
        :first_line_2=>game_2.guess_expressed_in_colours, 
        :solution_2=>game_2.get_solution,
        :poss_chars_2=>poss_chars_2,
        :combined_chars_1_2=>combined_chars_1_2.join("<br>"),
        :poss_words_1_2=>get_possible_words(combined_chars_1_2)
        
    }

end

post '/results_3' do
    game_1 = session[:game_1]
    game_2 = session[:game_2]
    input_3 = params[:game3].dump
    game_3 = Game.new(input_3)
    session[:game_3] = game_3

    poss_chars_1 = game_1.get_possible_chars.join("<br>")
    poss_chars_2 = game_2.get_possible_chars.join("<br>")
    poss_chars_3 = game_3.get_possible_chars.join("<br>")
    combined_chars_1_2 = combine_poss_chars(game_1.get_possible_chars, game_2.get_possible_chars)
    combined_chars_1_2_3 = combine_poss_chars(combined_chars_1_2, game_3.get_possible_chars)
 

    erb:results_3, :locals => {
  
        :input_1=>game_1.input.undump,
        :game_number_1=>game_1.game_number, 
        :first_line_1=>game_1.guess_expressed_in_colours, 
        :solution_1=>game_1.get_solution,
        :poss_chars_1=>poss_chars_1,
        :poss_words_1=>get_possible_words(poss_chars_1),

        :input_2=>game_2.input.undump,
        :game_number_2=>game_2.game_number, 
        :first_line_2=>game_2.guess_expressed_in_colours, 
        :solution_2=>game_2.get_solution,
        :poss_chars_2=>poss_chars_2,
        :combined_chars_1_2=>combined_chars_1_2.join("<br>"),
        :poss_words_1_2=>get_possible_words(combined_chars_1_2),

        :input_3=>game_3.input.undump,
        :game_number_3=>game_3.game_number, 
        :first_line_3=>game_3.guess_expressed_in_colours, 
        :solution_3=>game_3.get_solution,
        :poss_chars_3=>poss_chars_3,
        :combined_chars_1_2_3=>combined_chars_1_2_3.join("<br>"),
        :poss_words_1_2_3=>get_possible_words(combined_chars_1_2_3)
        
    }

end


post '/results_4' do
    game_1 = session[:game_1]
    game_2 = session[:game_2]
    game_3 = session[:game_3]
    input_4 = params[:game4].dump
    game_4 = Game.new(input_4)

    poss_chars_1 = game_1.get_possible_chars.join("<br>")
    poss_chars_2 = game_2.get_possible_chars.join("<br>")
    poss_chars_3 = game_3.get_possible_chars.join("<br>")
    poss_chars_4 = game_4.get_possible_chars.join("<br>")
    combined_chars_1_2 = combine_poss_chars(game_1.get_possible_chars, game_2.get_possible_chars)
    combined_chars_1_2_3 = combine_poss_chars(combined_chars_1_2, game_3.get_possible_chars)
    combined_chars_1_4 = combine_poss_chars(combined_chars_1_2_3, game_4.get_possible_chars)
    

    erb:results_4, :locals => {
    
        :input_1=>game_1.input.undump,
        :game_number_1=>game_1.game_number, 
        :first_line_1=>game_1.guess_expressed_in_colours, 
        :solution_1=>game_1.get_solution,
        :poss_chars_1=>poss_chars_1,
        :poss_words_1=>get_possible_words(poss_chars_1),

        :input_2=>game_2.input.undump,
        :game_number_2=>game_2.game_number, 
        :first_line_2=>game_2.guess_expressed_in_colours, 
        :solution_2=>game_2.get_solution,
        :poss_chars_2=>poss_chars_2,
        :combined_chars_1_2=>combined_chars_1_2.join("<br>"),
        :poss_words_1_2=>get_possible_words(combined_chars_1_2),

        :input_3=>game_3.input.undump,
        :game_number_3=>game_3.game_number, 
        :first_line_3=>game_3.guess_expressed_in_colours, 
        :solution_3=>game_3.get_solution,
        :poss_chars_3=>poss_chars_3,
        :combined_chars_1_2_3=>combined_chars_1_2_3.join("<br>"),
        :poss_words_1_2_3=>get_possible_words(combined_chars_1_2_3),

        :input_4=>game_4.input.undump,
        :game_number_4=>game_4.game_number, 
        :first_line_4=>game_4.guess_expressed_in_colours, 
        :solution_4=>game_4.get_solution,
        :poss_chars_4=>poss_chars_4,
        :combined_chars_1_4=>combined_chars_1_4.join("<br>"),
        :poss_words_1_4=>get_possible_words(combined_chars_1_4)
        
    }




end
