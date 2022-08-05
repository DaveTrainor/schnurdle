ENV['APP_ENV'] = 'test'

require_relative '../wordle_first_guess_finder'
require 'rspec'
require 'rack/test'


describe 'rspec' do
    it 'works' do
        expect(1).to eq(1)
    end
end

describe 'game_array' do
    it 'returns an array' do
        new_game_array = game_array("Wordle 392 3/6 ⬜🟨⬜🟩⬜ ⬜⬜⬜🟩⬜ 🟩🟩🟩🟩🟩")
        expect(new_game_array).to be_a MatchData
    end

    it 'returns the game number at 1:' do
        new_game_array = game_array("Wordle 392 3/6 ⬜🟨⬜🟩⬜ ⬜⬜⬜🟩⬜ 🟩🟩🟩🟩🟩")
        expect(new_game_array[1]).to eq('392')
    end

end


RSpec.describe "wordle" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end    

 
    it 'shows the main page' do
        get '/'
        expect(last_response.body).to include("Schnurdle")
    end

    it 'returns the game number' do
        get '/game_reader'
        #expect(last_response.body).to include("Wordle /\d{1,4}/")
        expect(last_response.body).to include(/\AThe game is: \d{1,4}\Z/).to_s
    end

    



end

