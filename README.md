# Constraint-Programming
## TP1 problem:
The NHL (National Hurling League) in Ireland asks you to plan
the schedule of his matches.
Constraint programming is well known
leaders of this league, this approach is imposed on you.
For a number of teams n variable but always even, it is a question of organizing
a simple round-robin tournament (ie each team plays against each
others exactly once) and compact (ie it is composed
n-1 round; any team plays one game each round, without "bye"). For
a given pair of teams, the match will be played at home for one and away
for the other. However, this choice has already been made by the league: for each match,
we already know which team will play at home. Each team can not play
more than three consecutive home games and no more than three away. Find
a schedule satisfying all the requirements becomes so difficult and sometimes even
impossible.
You need to design and implement models in MiniZinc to solve
this issue. You do not have to touch branching strategies; we
we will use the default one.
