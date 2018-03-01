%-----------------------------------------------------------------------------%
% TP1---LNH match schedule
%-----------------------------------------------------------------------------%
include "globals.mzn";
%-----------------------------------------------------------------------------
% variables

int: nbTeams; %the number of teams
set of int: teams = 1..nbTeams;
int: num_games = nbTeams*(nbTeams-1) div 2; %the total number of games will be n*(n-1)/2
set of int: games = 1..num_games;

set of int: homeaway = 1..2;  %the game will be held at home or away home 

%in each game, we decided the game is held at home or away home
array[teams, teams] of var homeaway: pv; 

int: nbRounds = nbTeams-1;
int: num_rounds = nbTeams-1; %n-1 rounds compactly
set of int: rounds = 1..num_rounds;

array[teams,rounds] of var games: game; %the scheduled games

%-----------------------------------------------------------------------------
% constraints

% a team cannot play against itself
constraint forall (i in teams, r in rounds) (game[i,r] != i::domain); 

%any team plays one game each round
constraint forall (i in teams) (all_different ([game[i,r] | r in rounds] )::domain); 
constraint forall (r in rounds) (all_different ([game[i,r] | i in teams])::domain); 

%each team palys against each other exactly once
constraint forall (i in teams, r in rounds) (game[game[i,r],r] = i::domain);

%heldplace[i,r] = 1 or 2, rely on team i plays at home or awayhome in round r
array[teams,rounds] of var homeaway: heldplace; 

%heldplace[i,r] = 1, in the meanwhile, pv[i,j]=1, j=game[i,r]
constraint forall (i in teams, r in rounds) (heldplace[i,r] = pv[i,game[i,r]]::domain); 

% Each team can not play more than three consecutive home games and no more than three away.
int: index_rounds = nbRounds-3; %n-1 rounds compactly
set of int: index = 1..index_rounds;

%???                                          
%constraint forall(i in teams) (
%                  (sliding_sum(5,7,4,[heldplace[i,r] | r in index])));
constraint
   forall(i in teams) (
         forall (r in index)(
            sum([heldplace[i,r+j] | j in 0..3]) >= 5
            /\
            sum([heldplace[i,r+j] | j in 0..3]) <=7::domain)
   );                      
%-------------------------------------------------------------------------
solve satisfy;
output[show(game[i,r])++ "("++show(heldplace[i,r])++ ")"++
  if r==nbTeams-1 then "\n" else ""  endif
  | i in teams, r in rounds] ++ ["\n"];


