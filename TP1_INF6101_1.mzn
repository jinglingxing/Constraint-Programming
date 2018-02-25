%-----------------------------------------------------------------------------%
% TP1---LNH match schedule
%-----------------------------------------------------------------------------%

include "globals.mzn";
%-----------------------------------------------------------------------------
nbTeams = 20;
pv = [|
2, 2, 1, 2, 1, 1, 2, 2, 2, 2, 2, 1, 2, 1, 1, 1, 2, 1, 1, 2|
1, 2, 2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1|
2, 1, 2, 1, 1, 2, 1, 1, 2, 2, 1, 2, 2, 1, 1, 2, 1, 2, 2, 2|
1, 2, 2, 2, 2, 1, 1, 2, 1, 2, 2, 2, 1, 1, 2, 2, 2, 2, 1, 2|
2, 2, 2, 1, 2, 2, 2, 1, 1, 2, 1, 2, 2, 1, 1, 1, 1, 2, 1, 1|
2, 2, 1, 2, 1, 2, 1, 2, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 1, 2|
1, 2, 2, 2, 1, 2, 2, 1, 1, 1, 2, 2, 1, 1, 1, 1, 1, 2, 2, 2|
1, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 2, 1, 2, 2, 2, 2, 2, 2, 1|
1, 1, 1, 2, 2, 1, 2, 2, 2, 1, 1, 2, 1, 1, 2, 2, 2, 1, 1, 2|
1, 2, 1, 1, 1, 2, 2, 1, 2, 2, 1, 2, 2, 2, 2, 1, 1, 1, 2, 1|
1, 2, 2, 1, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 2, 2|
2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 2, 1, 1, 1, 2, 2|
1, 2, 1, 2, 1, 1, 2, 2, 2, 1, 2, 2, 2, 2, 2, 1, 1, 1, 2, 2|
2, 2, 2, 2, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 2, 2, 1, 1, 2, 1|
2, 2, 2, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2, 1, 1, 2, 1, 2|
2, 1, 1, 1, 2, 1, 2, 1, 1, 2, 2, 2, 2, 1, 2, 2, 1, 2, 1, 1|
1, 1, 2, 1, 2, 1, 2, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2|
2, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 1, 1, 1, 2, 1, 1|
2, 1, 1, 2, 2, 2, 1, 1, 2, 1, 1, 1, 1, 1, 2, 2, 1, 2, 2, 2|
1, 2, 1, 1, 2, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 2, 1, 2, 1, 2|];

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
constraint forall (i in teams) (all_different ([game[i,r] | r in rounds] )::bounds); %any team plays one game each round
constraint forall (r in rounds) (all_different ([game[i,r] | i in teams])::bounds); 
constraint forall (i in teams, r in rounds) (game[game[i,r],r] = i);%each team palys against each other exactly once

array[teams,rounds] of var homeaway: heldplace; %heldplace[i,r] = 1 or 2, rely on team i plays at home or awayhome in round r
constraint forall (i in teams, r in rounds) (heldplace[i,r] = pv[i,game[i,r]]::bounds); %heldplace[i,r] = 1, in the meanwhile, pv[i,j]=1, j=game[i,r]


set of int: index = 1..nbTeams-3;
constraint forall (i in index)(sliding_sum(1, 3, 4, [heldplace[i, r] = 1 | r in rounds])::bounds); %Each team can not play more than three consecutive home games/away home games
constraint forall (i in index)(sliding_sum(2, 6, 4, [heldplace[i, r] = 2 | r in rounds])::bounds);

%-----------------------------------------------------------------------------
solve satisfy



