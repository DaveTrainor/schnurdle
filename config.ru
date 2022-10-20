require './wordle_first_guess_finder'
require './solution_scraper'

SolutionScraper.scrape_solutions

run Sinatra::Application