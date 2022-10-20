require 'open-uri'
require 'nokogiri'

class SolutionScraper

    def self.scrape_solutions
        
        html = URI.open("https://wordfinder.yourdictionary.com/wordle/answers/")

        doc = Nokogiri::HTML(html)
        
        
        solution_table = doc.css("tbody").text
        
        solution_table_array = solution_table.split(" ").each_slice(4).to_a
       
        solutions_hash = Hash[solution_table_array.each { |subarray| subarray.slice!(0..1)}]

        
        File.write('solution_list.rb', 
            "class Solution_list
        def self.time_updated
            "+Time.now.to_i.to_s+"
        end
        def self.list
            "+solutions_hash.to_s+"
        end
    end"
        )

    end
end