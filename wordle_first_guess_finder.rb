require 'sinatra'
require 'sinatra/reloader' if development?

# class Data_gathering
#     def game_receiver
#         puts "Paste your first game here:"
#         game1 = gets

#         return "you pasted" && game1
#     end
# end

get '/:game?' do |game|
    "Hellooo! You pasted this: #{game.to_s}"
end



