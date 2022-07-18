require 'sinatra'
require 'sinatra/reloader' if development?

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

post '/game_reader' do
    
    # puts params[:game1].dump
    game_string_dump = params[:game1].dump
    puts "game_string_dump: #{game_string_dump}"
    game_array = game_string_dump.match /(Wordle \d{1,3})\s+\S{2,4}\s+(\S+).+/
    first_line_array = game_array[2].split ('\\')
    puts first_line_array
    translation = {"u2B1C": "grey", 'u{1F7E8}': 'yellow', 'u{1F7E9}': 'green'}
    first_line_english = []
    first_line_english = first_line_array.map {|square| translation[square]}
    puts "first line english: #{first_line_english}"
    erb:game_reader, :locals => {:game_ID=>game_array[1], :first_line=>game_array[2]}

end
