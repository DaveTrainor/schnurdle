require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'solutionlist'
require_relative 'validwords'
enable :sessions



get '/' do
    erb:main
end

def get_solution(game_number)
    solutions_array = Solutions.pasted_solutions.split(" ").each_slice(4).to_a
    solutions_hash = Hash[solutions_array.each { |subarray| subarray.slice!(2..3)}]
    solutions_hash[game_number]
end

def game_array (input)
    input.match /Wordle (\d{1,3})\s+\S{2,4}\s+(\S+).+/
end

def game_number(game_array)
    game_array[1]
end

def guess_in_colours(game_array)
    translation = {'u2B1C': 'grey', 'u{1F7E8}': 'yellow', 'u{1F7E9}': 'green'}
    first_line_array = game_array[2].split ('\\')
    first_line_array[1..5].map {|square| translation[square.to_sym]}
end

def list_possible_characters(solution, guess_in_colours)
    possible_chars = []
    sol_arr = solution.scan /\w/
    
    guess_in_colours.each_with_index {|square, i| 
        
        if square == "green"
            possible_chars[i] = sol_arr[i]
        elsif square =="yellow"
            possible_chars[i] = sol_arr.join 
            possible_chars[i].delete! sol_arr[i]
        elsif square == "grey"
            possible_chars[i] = ('a'..'z').to_a.join()
            possible_chars[i].delete! solution          
        end
    }
    return possible_chars   
        
end

def find_matching_words(possible_chars)
    word_list_array = Valid_words.word_list.split(" ")
    
    possible_words = word_list_array.select {|word| 
        possible_chars[0].include?(word[0]) &&
        possible_chars[1].include?(word[1]) &&
        possible_chars[2].include?(word[2]) &&
        possible_chars[3].include?(word[3]) &&
        possible_chars[4].include?(word[4])}
         # == /^[possible_chars[0]][possible_chars[1]][possible_chars[2]][possible_chars[3]][possible_chars[4]]$/}
    possible_words
end



post '/results_1' do
    
    input_1 = params[:game1].dump
    game_array_1 = game_array(input_1)
    first_line_1 = guess_in_colours(game_array_1).to_s
    solution_1 = get_solution(game_array_1[1])
    game_number_1 = game_number(game_array_1)
    poss_chars_1 = list_possible_characters(get_solution(game_array_1[1]), guess_in_colours(game_array_1))
    possible_words_1 = find_matching_words(poss_chars_1).sort()
    
    puts "line 78 #{session.inspect}"
    session[:input_1] = input_1.undump
    session[:poss_chars_1] = poss_chars_1
    session[:game_number_1] = game_number_1
    session[:solution_1] = solution_1
    session[:first_line_1] = first_line_1
    session[:poss_words_1] = possible_words_1

    puts "line 84 #{session.inspect}"
    
    
    
    erb:results_1, :locals => {
        :game_number_1=>game_number_1, 
        :first_line_1=>first_line_1, 
        :solution_1=>solution_1,
        :poss_chars_1=>poss_chars_1.join("<br>"),
        :poss_words_1=>possible_words_1.join(", ")
        
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
    puts "line 113 #{session.inspect}"
    puts "line 114 #{session[:poss_chars_1]}"
    poss_chars_1 = session[:poss_chars_1]
    puts "line 112 pc1 #{poss_chars_1}"
    # game_number_1 = session[:game_number_1]
    input_2 = params[:game2].dump
    game_array_2 = game_array(input_2)
    poss_chars_2 = list_possible_characters(get_solution(game_array_2[1]), guess_in_colours(game_array_2))
    puts "######################### poss chars 1 #{poss_chars_1.inspect} pc2 #{poss_chars_2.inspect}"
    combined_chars_1_2 = combine_poss_chars(poss_chars_1, poss_chars_2)
    puts combined_chars_1_2.inspect
    possible_words_2 = find_matching_words(combined_chars_1_2).sort()

    erb:results_2, :locals => {
        :input_1=>session[:input_1],
        :game_number_1=>session[:game_number_1],
        :solution_1=>session[:solution_1],
        :first_line_1=>session[:first_line_1],
        :poss_chars_1=>session[:poss_chars_1],
        :poss_words_1=>session[:poss_words_1],
        :game_number_2=>game_number(game_array_2), 
        :first_line_2=>guess_in_colours(game_array_2).to_s, 
        :solution_2=>get_solution(game_array_2[1]),
        :poss_chars_2=>poss_chars_2.join("<br>"),
        :combined_chars_1_2=>combined_chars_1_2.join("<br>"),
        :poss_words_2=>possible_words_2.join(", ")
        
    }

end
