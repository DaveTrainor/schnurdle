require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'solutionlist'



# class Data_gathering
#     def game_receiver
#         puts "Paste your first game here:"
#         game1 = gets

#         return "you pasted" && game1
#     end
# end

# get '/:game?' do |game|
#     "Hellooo! You pasted this: #{game.to_s}"
# end


get '/' do

    erb:main
    
end

def get_solution(game_number)
    solutions_array = Solutions.pasted_solutions.split(" ")
    solutions_array_2 = solutions_array.each_slice(4).to_a
    #solutions_array_2.each { |subarray| subarray.slice!(2..3)}
    solutions_hash = Hash[solutions_array_2.each { |subarray| subarray.slice!(2..3)}]
    solutions_hash[game_number]
end


post '/game_reader' do
    
    game_string_dump = params[:game1].dump
    # puts "game_string_dump: #{game_string_dump}"
    game_array = game_string_dump.match /Wordle (\d{1,3})\s+\S{2,4}\s+(\S+).+/
    first_line_array = game_array[2].split ('\\')
    # puts first_line_array
    translation = {'u2B1C': 'grey', 'u{1F7E8}': 'yellow', 'u{1F7E9}': 'green'}
    # first_line_english = []
    first_line_english = first_line_array[1..5].map {|square| translation[square.to_sym]}
    #puts "first line english: #{first_line_english}"
    game_solution = get_solution(game_array[1])
    puts "Game solution: #{game_solution}"
    erb:game_reader, :locals => {:game_ID=>game_array[1], :first_line=>first_line_english.to_s, :solution=>game_solution}

end
