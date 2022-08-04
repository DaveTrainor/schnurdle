## A wordle first guess finder

Paste in your wordle results and this app will attempt to establish what word you use for your first guess

Incomplete: Only accepts one wordle game at the moment, and numerous issues to resolve.

### Questions / Issues:

- Testing: TDD went out the window :-( 
    I felt like it was slowing me down and i was over-excited. Recovery plan needed!

- Refactoring:
    - naming of methods is difficult to follow i think?!
    - methods to break into smaller methods:
        - list_possible_characters (this is large and horrible and needs work!)
        - get_solution ?
    - the way methods are called is inconsistent in post '/game_reader' do, not sure what is the best way to do this
    - variable names and method names overlap in a horrible way