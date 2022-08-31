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
        solutions_hash[self.game_number]
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

    def get_possible_words
        word_list_array = Valid_words.word_list.split(" ")
        possible_chars = self.get_possible_chars
        possible_words = word_list_array.select {|word| 
            possible_chars[0].include?(word[0]) &&
            possible_chars[1].include?(word[1]) &&
            possible_chars[2].include?(word[2]) &&
            possible_chars[3].include?(word[3]) &&
            possible_chars[4].include?(word[4])}
             # == /^[possible_chars[0]][possible_chars[1]][possible_chars[2]][possible_chars[3]][possible_chars[4]]$/}
        possible_words.sort().join(", ")
    end

end


post '/results_1' do
    
    input_1 = params[:game1].dump
    game_1 = Game.new(input_1)
   
    # puts "line 78 #{session.inspect}"
    # session[:input_1] = input_1.undump
    # session[:poss_chars_1] = poss_chars_1
    # session[:game_number_1] = game_number_1
    # session[:solution_1] = solution_1
    # session[:first_line_1] = first_line_1
    # session[:poss_words_1] = possible_words_1

    # puts "line 84 #{session.inspect}"

    erb:results_1, :locals => {
        :game_number_1=>game_1.game_number, 
        :first_line_1=>game_1.guess_expressed_in_colours, 
        :solution_1=>game_1.get_solution,
        :poss_chars_1=>game_1.get_possible_chars.join("<br>"),
        :poss_words_1=>game_1.get_possible_words
        
    }

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

post '/results_2' do
    poss_chars_1 = session[:poss_chars_1]
    poss_words_1 = find_matching_words(poss_chars_1).sort()

    input_2 = params[:game2].dump
    game_array_2 = game_array(input_2)
    solution_2 = get_solution(game_array_2[1])
    game_number_2 = game_number(game_array_2)
    poss_chars_2 = list_possible_characters(get_solution(game_array_2[1]), guess_in_colours(game_array_2))
    combined_chars_1_2 = combine_poss_chars(poss_chars_1, poss_chars_2)
    possible_words_2 = find_matching_words(combined_chars_1_2).sort()
    
    
    session[:input_2] = input_2.undump
    session[:combined_chars_1_2] = combined_chars_1_2
    session[:game_number_2] = game_number_2
    session[:solution_2] = solution_2
    

    erb:results_2, :locals => {
        :input_1=>session[:input_1],
        :game_number_1=>session[:game_number_1],
        :solution_1=>session[:solution_1],
        :first_line_1=>session[:first_line_1],
        :poss_chars_1=>poss_chars_1.join("<br>"),
        :poss_words_1=>poss_words_1.join(", "),

        :input_2=>input_2.undump,
        :game_number_2=>game_number(game_array_2), 
        :first_line_2=>guess_in_colours(game_array_2).to_s, 
        :solution_2=>get_solution(game_array_2[1]),
        :poss_chars_2=>poss_chars_2.join("<br>"),
        :combined_chars_1_2=>combined_chars_1_2.join("<br>"),
        :poss_words_2=>possible_words_2.join(", ")
        
    }

end

post '/results_3' do
    poss_chars_1 = session[:poss_chars_1]
    poss_words_1 = find_matching_words(poss_chars_1).sort()

    combined_chars_1_2 = session[:combined_chars_1_2]
    poss_words_2 = find_matching_words(combined_chars_1_2).sort()

    input_3 = params[:game3].dump
    game_array_3 = game_array(input_3)
    poss_chars_3 = list_possible_characters(get_solution(game_array_3[1]), guess_in_colours(game_array_3))
    combined_chars_1_2_3 = combine_poss_chars(combined_chars_1_2, poss_chars_3)
    possible_words_3 = find_matching_words(combined_chars_1_2_3).sort()
    
    

    erb:results_3, :locals => {
        :input_1=>session[:input_1],
        :game_number_1=>session[:game_number_1],
        :solution_1=>session[:solution_1],
        :first_line_1=>session[:first_line_1],
        :poss_chars_1=>poss_chars_1.join("<br>"),
        :poss_words_1=>poss_words_1.join(", "),
        
        :input_2=>session[:input_2],
        :game_number_2=>session[:game_number_2],
        :solution_2=>session[:solution_2],
        :first_line_2=>session[:first_line_2],
        :combined_chars_1_2=>combined_chars_1_2.join("<br>"),
        :poss_words_2=>poss_words_2.join(", "),
        
        :input_3=>input_3.undump,
        :game_number_3=>game_number(game_array_3), 
        :first_line_3=>guess_in_colours(game_array_3).to_s, 
        :solution_3=>get_solution(game_array_3[1]),
        :poss_chars_3=>poss_chars_3.join("<br>"),
        :combined_chars_1_2_3=>combined_chars_1_2_3.join("<br>"),
        :poss_words_3=>possible_words_3.join(", ")
        
    }

end
