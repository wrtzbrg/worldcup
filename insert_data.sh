#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

TRUNR=$($PSQL "TRUNCATE TABLE teams, games")
echo $TRUNR



cat games.csv |  while IFS="," read YEAR ROUND  WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
if [[ $YEAR != "year" ]]
then
  #look up winner team NAME
    LURESW=$($PSQL "SELECT name FROM teams WHERE name='$WINNER';")
    echo $LURESW

    #if not found 
    if [[ -z $LURESW ]]
    then
      #create winner team id
      CWTR=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      #echo $CWTR Winner: $WINNER
    fi

  #look up opponent team id
    LURESO=$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT';")
    echo $LURESO
    
    #if not found 
    if [[ -z $LURESO ]]
    then
      #create opponent team id
      CRTO=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      #echo $CRTO Opponent: $OPPONENT
    fi
  echo "GET ID'S"
  WIID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
  OPID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
  #insert game 
  echo "INSERT GAMES"
  IG=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WIID, $OPID, $WINNER_GOALS, $OPPONENT_GOALS)")
  echo $IG

fi
done


