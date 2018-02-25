%-----------------------------------------------------------------------------%
% TP1---LNH match schedule
%-----------------------------------------------------------------------------%

include "globals.mzn";
%-----------------------------------------------------------------------------
nbTeams = 8;
pv = [|
2, 1, 1, 2, 1, 2, 2, 1|
2, 2, 2, 1, 1, 2, 1, 1|
2, 1, 2, 1, 2, 1, 2, 2|
1, 2, 2, 2, 2, 1, 1, 2|
2, 2, 1, 1, 2, 1, 2, 2|
1, 1, 2, 2, 2, 2, 1, 1|
1, 2, 1, 2, 1, 2, 2, 2|
2, 2, 1, 1, 1, 2, 1, 2|];
%-----------------------------------------------------------------------------
% variables

int: nbTeams; %the number of teams
set of int: teams = 1..nbTeams;
int: num_games = nbTeams*(nbTeams-1) div 2; %the total number of games will be n*(n-1)/2
set of int: games = 1..num_games;

set of int: homeaway = 1..2;  %the game will be held at home or away home 
array[teams, teams] of var homeaway: pv; %in each game, we decided the game is held at home or away home

int: nbRounds;
int: num_rounds = nbTeams-1; %n-1 rounds compactly
set of int: rounds = 1..num_rounds;

array[teams,rounds] of var games: game; %the scheduled games

%-----------------------------------------------------------------------------
% constraints

constraint forall (i in teams, r in rounds) (game[i,r] != i::bounds);  % a team cannot play against itself

%any team plays one game each round, replace all_different
constraint forall (i,j in teams where i<j) (
                  forall (r in rounds )(game[i,r]!=game[j,r])::bounds);  
                             
constraint forall (r1,r2 in rounds where r1<r2) (
                  forall (i in teams )(game[i,r1]!=game[i,r2])::bounds);
                                    
constraint forall (i in teams, r in rounds) (game[game[i,r],r] = i::bounds);%each team palys against each other exactly once

array[teams,rounds] of var homeaway: heldplace; %heldplace[i,r] = 1 or 2, rely on team i plays at home or awayhome in round r
constraint forall (i in teams, r in rounds) (heldplace[i,r] = pv[i,game[i,r]]::bounds); %heldplace[i,r] = 1, in the meanwhile, pv[i,j]=1, j=game[i,r]

% Each team can not play more than three consecutive home games and no more than three away.
% the DFA (for regular)
int: n_states = 7;
int: input_max = 2;
int: initial_state = 1;
set of int: accepting_states = 1..7;
%transition function
array[1..n_states, 1..input_max] of int: transition_fn =
 array2d(1..n_states, 1..input_max,
  [
      % home(1),away(2)
        2,3,
        4,3,
        2,5, 
        6,3,
        2,7,
        0,3,
        2,0
  ]);
  
constraint
   forall(i in teams) (
       regular([heldplace[i,r] | r in rounds], n_states, input_max, transition_fn,
                   initial_state, accepting_states)::bounds);
%-----------------------------------------------------------------------------
solve satisfy




