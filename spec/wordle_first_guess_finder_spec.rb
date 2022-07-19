ENV['APP_ENV'] = 'test'

require_relative '../wordle_first_guess_finder'
require 'rspec'
require 'rack/test'


describe 'rspec' do
    it 'works' do
        expect(1).to eq(1)
    end
end

RSpec.describe "wordle" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end    

    # describe 'Data gathering' do
    #     it 'receives something' do
    #         dataset1 = Data_gathering.new
    #         expect(dataset1.game_receiver.class).to eq(String)
    #     end
    # end

    it 'shows the main page' do
        get '/'
        expect(last_response.body).to include("Schnurdle")
    end

    it 'returns the game number' do
        get '/'
        #expect(last_response.body).to include("Wordle /\d{1,4}/")
        expect(@game_array[1]).to eq(/\AWordle \d{1,4}\Z/)
    end

    



end

