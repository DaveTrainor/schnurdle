<!-- 
    <p text-align: centre >The game is: <%=game_number_1%></p>
    <p text-align: centre >The game solution is: <%=solution_1%></p>
    <p text-align: centre >The array of possible characters is: <br><br> <%=poss_chars_1%></p>
    <p text-align: centre >Given this information, the list of possible first guess words is: <br><br> <%=poss_words_1%></p>
    -->

    <!--
    <p text-align: centre >The game is: <%=game_number_2%></p>
    <p text-align: centre >The game solution is: <%=solution_2%></p>
    <p text-align: centre >The array of possible characters from this game only is: <br><br> <%=poss_chars_2%></p>
    <p text-align: centre >The array of possible characters from all games so far is: <br><br> <%=combined_chars_1_2%></p>
    <p text-align: centre >Given this information, the list of possible first guess words is: <br><br> <%=poss_words_1_2%></p>
    -->






    :input_1=>game_1.input.undump,
        :game_number_1=>game_1.game_number, 
        :first_line_1=>game_1.guess_expressed_in_colours, 
        :solution_1=>game_1.get_solution,
        :poss_chars_1=>poss_chars_1,
        :poss_words_1=>get_possible_words(poss_chars_1),

        :input_2=>game_2.input.undump,
        :game_number_2=>game_2.game_number, 
        :first_line_2=>game_2.guess_expressed_in_colours, 
        :solution_2=>game_2.get_solution,
        :poss_chars_2=>poss_chars_2,
        :combined_chars_1_2=>combined_chars_1_2.join("<br>"),
        :poss_words_1_2=>get_possible_words(combined_chars_1_2),

        :input_3=>game_3.input.undump,
        :game_number_3=>game_3.game_number, 
        :first_line_3=>game_3.guess_expressed_in_colours, 
        :solution_3=>game_3.get_solution,
        :poss_chars_3=>poss_chars_3,
        :combined_chars_1_2_3=>combined_chars_1_2_3.join("<br>"),
        :poss_words_1_2_3=>get_possible_words(combined_chars_1_2_3),

        :input_4=>game_4.input.undump,
        :game_number_4=>game_4.game_number, 
        :first_line_4=>game_4.guess_expressed_in_colours, 
        :solution_4=>game_4.get_solution,
        :poss_chars_4=>poss_chars_4,
        :combined_chars_1_4=>combined_chars_1_4.join("<br>"),
        :poss_words_1_4=>get_possible_words(combined_chars_1_4),
        :error_message=>"none"