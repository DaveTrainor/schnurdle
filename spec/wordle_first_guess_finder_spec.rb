ENV['APP_ENV'] = 'test'

require_relative '../wordle_first_guess_finder'
require 'rspec'
require 'rack/test'

RSpec.describe "wordle" do
    include Rack::Test::Methods

    def app
        Sinatra::Application
    end

    describe 'rspec' do
        it 'works' do
            expect(1).to eq(1)
        end
    end

    describe 'Data gathering' do
        it 'receives something' do
            dataset1 = Data_gathering.new
            expect(dataset1.game_receiver.class).to eq(String)
        end
    end
end

