require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'solutionlist'


get '/' do

    erb:main
    
end

def get_solution(game_number)
    solutions_array = Solutions.pasted_solutions.split(" ")
    solutions_array_2 = solutions_array.each_slice(4).to_a
    solutions_hash = Hash[solutions_array_2.each { |subarray| subarray.slice!(2..3)}]
    solutions_hash[game_number]
end

def game_array (game_string_dump)
    game_array = game_string_dump.match /Wordle (\d{1,3})\s+\S{2,4}\s+(\S+).+/
end

def game_number(game_array)
    game_array[1]
end

def first_line_english(game_array)
    translation = {'u2B1C': 'grey', 'u{1F7E8}': 'yellow', 'u{1F7E9}': 'green'}
    first_line_array = game_array[2].split ('\\')
    first_line_colours = first_line_array[1..5].map {|square| translation[square.to_sym]}
end

def list_possible_guesses(solution, first_line_english)
    possible_chars = [('a'..'z').to_a]*5
    sol_arr = solution.scan /\w/
    first_line_english.each_with_index {|square, i| 
        if square == "green"
            possible_chars[i] = solution[i]
        elsif square =="yellow"
            possible_chars[i] = sol_arr
        else 
            possible_chars[i].reject! {|char| sol_arr.index(char)}  
        
        end
        }
        possible_chars
        print possible_chars




end



post '/game_reader' do
    
    game_string_dump = params[:game1].dump
    game_array = game_array(game_string_dump)
    list_possible_guesses(get_solution(game_array[1]), first_line_english(game_array))
      
    erb:game_reader, :locals => {
        :game_ID=>game_number(game_array), 
        :first_line=>first_line_english(game_array).to_s, 
        :solution=>get_solution(game_array[1])
        
    }

end
