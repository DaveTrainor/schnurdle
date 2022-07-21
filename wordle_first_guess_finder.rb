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
    solution.each { |char| }

post '/game_reader' do
    
    game_string_dump = params[:game1].dump
    game_array = game_array(game_string_dump)
      
    erb:game_reader, :locals => {
        :game_ID=>game_number(game_array), 
        :first_line=>first_line_english(game_array).to_s, 
        :solution=>get_solution(game_array[1])
    }

end
