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
    game_array = game_string_dump.match /(Wordle \d{1,3}).+(\\u\S+).+/
    game_array_2 = game_string_dump.match /(\\u\S+)/
    puts "game_array: #{game_array}"
    puts "game_array[1]: #{game_array[1]}"
    erb:game_reader, :locals => {:game_ID=>game_array[1], :first_line=>game_array[2]}

end
