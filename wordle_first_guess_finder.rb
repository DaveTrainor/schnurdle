require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'solutionlist'
require_relative 'validwords'


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
            possible_chars[i] = sol_arr.join #each{|char| possible_chars[i] << char.dup}
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



post '/game_reader' do
    
    input = params[:game1].dump
    game_array = game_array(input)
    poss_chars = list_possible_characters(get_solution(game_array[1]), guess_in_colours(game_array))
    possible_words = find_matching_words(poss_chars).sort()

    erb:game_reader, :locals => {
        :game_ID=>game_number(game_array), 
        :first_line=>guess_in_colours(game_array).to_s, 
        :solution=>get_solution(game_array[1]),
        :poss_chars=>poss_chars.join("<br>"),
        :poss_words=>possible_words.join(", ")
        
    }

end
