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
    
    game_string_dump = params[:game1].dump
    puts game_string_dump
    @game_array = /(<game_number> Wordle \d{1,3})/.match (game_string_dump)
    puts @game_array.to_s
    puts @game_array[0]
    erb:game_reader, :locals => {:game_ID=>@game_array[game_number]}

end
