require 'capybara_helper'

RSpec.describe "the pages" do

    describe "main page" do
       
        it 'returns status 200 OK' do
            get "/"
            expect(last_response.status).to eq 200
        end

        it 'shows the main page' do
            get "/"
            expect(last_response.body).to include("Schnurdle")
        end

        
    end

    
    describe "happy_path" do

               
        it "returns 200 from results_1" do
            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            click_button("Submit")

            expect(status_code).to eq 200   
        end

        it "returns the correct content in results_1" do
            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            click_button("Submit")

            expect(page).to have_content "audio"
            expect(page).to have_content "ruddy"
            expect(page).to have_content "Paste another game here:"
            expect(page).to have_content "You entered: Wordle 408"
        end
        
        it "returns the correct game solution in results_1" do
            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            click_button("Submit")
            
            expect(page).to have_content "The game solution is: quart"
            expect(page).not_to have_content "NoMethodError"
            
        end
            
        it "returns the correct content in results_2" do
            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            click_button("Submit")
            fill_in "game2", with: "Wordle 410 4/6 ⬜🟨⬜⬜🟨 ⬜🟨🟨🟨⬜ ⬜🟩🟩🟩🟨 🟩🟩🟩🟩🟩"
            click_button("Submit")
            
            expect(page).to have_content "audio" 
            expect(page).to have_content "ruddy"
            expect(page).to have_content "rugby"
            expect(page).to have_content "You entered: Wordle 410"
            expect(page).not_to have_content "NoMethodError"
        end

        it "returns the correct content in results_3" do
            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            click_button("Submit")
            fill_in "game2", with: "Wordle 410 4/6 ⬜🟨⬜⬜🟨 ⬜🟨🟨🟨⬜ ⬜🟩🟩🟩🟨 🟩🟩🟩🟩🟩"
            click_button("Submit")
            fill_in "game3", with: "Juliet Pearce: Wordle 412 3/6 ⬜🟩⬜⬜⬜ ⬜🟩⬜⬜⬜ 🟩🟩🟩🟩🟩"
            click_button("Submit")
            expect(page).to have_content "audio"
            expect(page).to have_content "You entered: Juliet Pearce: Wordle 412"
            expect(page).not_to have_content "Error"
            expect(page).not_to have_content "Sorry what?"
                        
        end

        it "returns the correct content in results_4" do

            visit "/"
            fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
            click_button("Submit")
            fill_in "game2", with: "Wordle 410 4/6 ⬜🟨⬜⬜🟨 ⬜🟨🟨🟨⬜ ⬜🟩🟩🟩🟨 🟩🟩🟩🟩🟩"
            click_button("Submit")
            fill_in "game3", with: "Juliet Pearce: Wordle 409 X/6 ⬜⬜⬜⬜🟨 ⬜⬜⬜🟨⬜ ⬜⬜🟨⬜⬜ ⬜⬜🟨🟩⬜ ⬜🟩⬜🟩🟩 🟩🟩⬜🟩🟩"
            click_button("Submit")
            fill_in "game4", with: "Juliet Pearce: Wordle 412 3/6 ⬜🟩⬜⬜⬜ ⬜🟩⬜⬜⬜ 🟩🟩🟩🟩🟩"
            click_button("Submit")
            

            expect(page).to have_content "audio"
            expect(page).to have_content "You entered: Juliet Pearce: Wordle 412"
            expect(page).not_to have_content "NoMethodError"
            
        end

    end

    describe "Error handling" do
        
        context "main page" do 
            it 'returns an error message if an invalid input is entered' do
                visit "/"
                fill_in "game1", with: "dle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
                
                click_button("Submit")
                expect(page).to have_content "Sorry what?"
            end
        end

        context "results_1" do
            it "returns an error message if an invalid input is entered" do

                visit "/"
                fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
                click_button("Submit")
                fill_in "game2", with: "bleurgh"
                click_button("Submit")
                
                expect(page).to have_content "Sorry what?"
                expect(page).not_to have_content "NoMethodError"
            end   
        end

        context "results_2" do

            it "returns an error message if an invalid input is entered" do

                visit "/"
                fill_in "game1", with: "Wordle 408 2/6              🟨🟩⬜⬜⬜             🟩🟩🟩🟩🟩"
                click_button("Submit")
                fill_in "game2", with: "Wordle 410 4/6 ⬜🟨⬜⬜🟨 ⬜🟨🟨🟨⬜ ⬜🟩🟩🟩🟨 🟩🟩🟩🟩🟩"
                click_button("Submit")
                fill_in "game3", with: "hecky thump"
                click_button("Submit")

                expect(page).to have_content "Sorry what?"
                expect(page).not_to have_content "NoMethodError"
            end   
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
