require 'capybara_helper'

RSpec.describe "the pages" do

    # include Rack::Test::Methods
    # include Rack::Session
    # Capybara.app = Sinatra::Application

    # def app
    #     Sinatra::Application
    # end    

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

    
    describe "happy_path", type: :feature do

               
        it "returns 200 from results_1" do
            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            click_button("")

            expect(status_code).to eq 200   
        end

        it "returns the correct word list in results_1" do
            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            click_button("")

            expect(page).to have_content "audio, ruddy"
            expect(page).to have_content "Paste another game here:"
        end
        
        it "returns the correct game solution in results_1" do
            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            post "/results_1"
            
            expect(last_response.body).to include "The game solution is: quart"
            
        end
            
        it "does results_2" do
            puts 'h1'
            within "form" do
            fill_in "game2", with: "Wordle 410 4/6 ⬜🟨⬜⬜🟨 ⬜🟨🟨🟨⬜ ⬜🟩🟩🟩🟨 🟩🟩🟩🟩🟩"
            click_button("")
            end

            expect(page).to have_content "audio, ruddy, rugby"
            expect(page).to have_content "You entered: Wordle 410"
        end

    end
    
        

    describe "results_1" do
        
        let!(:response) {post "/results_1", :game1 => "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"}

        it 'returns status 200 OK' do
            expect(last_response.status).to eq 200
        end

        it 'contains the game number in the body' do
            expect(last_response.body).to include("408")

        
        end
      
    end
    
    



end