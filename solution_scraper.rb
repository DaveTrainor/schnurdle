require 'open-uri'
require 'nokogiri'

class SolutionScraper

    def self.scrape_solutions
        
        html = URI.open ("https://wordfinder.yourdictionary.com/wordle/answers/")

        doc = Nokogiri::HTML(html)

        solution_table = doc.xpath("/html/body/div[1]/main/div/div[2]/section/h1")
        # ("/html/body/main/div/div[2]/section/table[1]/tbody")

        puts solution_table

    end
end