ENV['APP_ENV'] = 'test'

require_relative '../wordle_first_guess_finder'
require 'rspec'
require 'rack/test'
require 'capybara/rspec'


describe 'rspec' do
    it 'works' do
        expect(1).to eq(1)
    end
end


describe 'the_Game_class' do
    
    test_game = Game.new(("Wordle 392 3/6 ⬜🟨⬜🟩⬜ ⬜⬜⬜🟩⬜ 🟩🟩🟩🟩🟩").dump)
        
    describe 'game_array' do
        it 'returns an array' do
            expect(test_game.game_array).to be_a MatchData
        end

        it 'returns the game number at 1:' do
            expect(test_game.game_array[1]).to eq('392')
        end
    end

    describe 'guess_expressed_in_colours' do
        it 'returns the correct colours' do
            expect(
                test_game.guess_expressed_in_colours).to eq(
                    ["grey", "yellow", "grey", "green", "grey"]
            )
    
        end
    end

    describe 'game_number' do
        it 'returns correct number' do
            expect(test_game.game_number).to eq('392')
        end
    end

    describe 'get_solution' do
        it 'returns the right solution' do
            expect(test_game.get_solution).to eq('roomy')
        end
    end

    describe 'get_possible_chars' do
        it 'returns the right characters' do
            expect(test_game.get_possible_chars).to eq(
                ["abcdefghijklnpqstuvwxz",
                "rmy",
                "abcdefghijklnpqstuvwxz",
                "m",
                "abcdefghijklnpqstuvwxz"]
            )
        end
    end

    describe 'get_possible_words' do
        it 'returns the right list of words' do
            expect(test_game.get_possible_words).to eq( 
                'cramp, creme, crime, crimp, crumb, crump, drama, frame, grime, prime, tramp, trams, trump'


            )
        end
    end

end


RSpec.describe "the pages" do

    include Rack::Test::Methods
    include Rack::Session
    Capybara.app = Sinatra::Application

    def app
        Sinatra::Application
    end    

    describe "main page" do
       
        it 'returns status 200 OK'do
            get "/"
            expect(last_response.status).to eq 200
        end

        it 'shows the main page' do
            get "/"
            expect(last_response.body).to include("Schnurdle")
        end

       
    end

    
    describe "results_1", type: :feature do

        it "does the capybara" do
            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            # click_button "submit"
            expect(last_response.status).to eq 200
            expect(last_response.body).to include "audio"
        end


        
        let!(:response) {post "/results_1", :game1 => "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"}

        it 'returns status 200 OK' do
            expect(last_response.status).to eq 200
        end

        it 'contains the game number in the body' do
            expect(last_response.body).to include("408")
        end
      
    end

    describe "results_2", type: :feature do
        

        let! (:response) {post "/results_2", :game2 => "Wordle 409 X/6 ⬜⬜⬜⬜🟨 ⬜⬜⬜🟨⬜ ⬜⬜🟨⬜⬜ ⬜⬜🟨🟩⬜ ⬜🟩⬜🟩🟩 🟩🟩⬜🟩🟩"}

        it 'returns status 200 OK' do
            expect(last_response.status).to eq 200
        end
    end

    

    # it 'returns the game number' do
    #     get '/results_1'
    #     #expect(last_response.body).to include("Wordle /\d{1,4}/")
    #     expect(last_response.body).to include(/\AThe game is: \d{1,4}\Z/).to_s
    # end

    



end



