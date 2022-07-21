ENV['APP_ENV'] = 'test'

require_relative '../wordle_first_guess_finder'
require 'rspec'
require 'rack/test'


describe 'rspec' do
    it 'works' do
        expect(1).to eq(1)
    end
end

# describe 'get_game_info' do
#     it 'returns a hash' do
#         expect get_game_info("Wordle 392 3/6 ⬜🟨⬜🟩⬜ ⬜⬜⬜🟩⬜ 🟩🟩🟩🟩🟩").should be_an_instance_of Hash
#     end
# end


RSpec.describe "wordle" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end    

 
    it 'shows the main page' do
        get '/'
        expect(last_response.body).to include("Schnurdle")
    end

    # it 'returns the game number' do
    #     get '/game_reader'
    #     #expect(last_response.body).to include("Wordle /\d{1,4}/")
    #     expect(last_response.body).to include(/\AThe game is: \d{1,4}\Z/)
    # end

    



end

