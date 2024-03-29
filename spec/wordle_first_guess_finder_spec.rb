require 'spec_helper'


describe 'rspec' do
    it 'works' do
        expect(1).to eq(1)
    end
end


describe 'the_Game_class' do
    
    test_game = Game.new(("Wordle 392 3/6 ⬜🟨⬜🟩⬜ ⬜⬜⬜🟩⬜ 🟩🟩🟩🟩🟩").dump)
    bad_test_game = Game.new(("rdle 392 3/6 ⬜🟨⬜🟩⬜ ⬜⬜⬜🟩⬜ 🟩🟩🟩🟩🟩").dump)
        
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
            expect(get_possible_words(test_game.get_possible_chars)).to eq(
                'arame, arums, brame, breme, brims, brume, crame, cramp, crams, crema, creme, crems, crime, crimp, crims, crumb, crump, drama, drams, drums, frame, fremd, frump, grama, grame, gramp, grams, grime, grume, grump, imams, krump, lyams, nyams, prams, prems, prima, prime, primi, primp, prims, tramp, trams, trema, trems, trims, trump, umami'
            )
            # short list:    'cramp, creme, crime, crimp, crumb, crump, drama, frame, grime, prime, tramp, trams, trump'
        end
    end

end


RSpec.describe "the pages" do

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

end



