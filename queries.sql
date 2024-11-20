-- SQL JOINS EXERCISE --

-- TABLES:

-- joins_exercise=# SELECT * FROM owners;
--  id | first_name | last_name 
-- ----+------------+-----------
--   1 | Bob        | Hope
--   2 | Jane       | Smith
--   3 | Melody     | Jones
--   4 | Sarah      | Palmer
--   5 | Alex       | Miller
--   6 | Shana      | Smith
--   7 | Maya       | Malarkin
-- (7 rows)

-- joins_exercise=# SELECT * FROM vehicles;
--  id |  make  |  model  | year |  price   | owner_id 
-- ----+--------+---------+------+----------+----------
--   1 | Toyota | Corolla | 2002 |  2999.99 |        1
--   2 | Honda  | Civic   | 2012 | 12999.99 |        1
--   3 | Nissan | Altima  | 2016 | 23999.99 |        2
--   4 | Subaru | Legacy  | 2006 |  5999.99 |        2
--   5 | Ford   | F150    | 2012 |  2599.99 |        3
--   6 | GMC    | Yukon   | 2016 | 12999.99 |        3
--   7 | GMC    | Yukon   | 2014 | 22999.99 |        4
--   8 | Toyota | Avalon  | 2009 | 12999.99 |        4
--   9 | Toyota | Camry   | 2013 | 12999.99 |        4
--  10 | Honda  | Civic   | 2001 |  7999.99 |        5
--  11 | Nissan | Altima  | 1999 |  1899.99 |        6
--  12 | Lexus  | ES350   | 1998 |  1599.99 |        6
--  13 | BMW    | 300     | 2012 | 22999.99 |        6
--  14 | BMW    | 700     | 2015 | 52999.99 |        6
-- (14 rows)

--+++++++++++++++++++++++++++PART ONE +++++++++++++++++++++++++++

-------------------------------------- first query:-------------------------------

-- Join the two tables so that every column and record appears, regardless of if there is not an owner_id .

SELECT *
    FROM owners o
    LEFT JOIN vehicles v
    ON o.id = v.owner_id;

    --OR:
    -- SELECT * FROM owners o 
    --     FULL OUTER JOIN vehicles v 
    --     ON o.id = v.owner_id;

--     joins_exercise=# SELECT *
-- joins_exercise-#     FROM owners o
-- joins_exercise-#     LEFT JOIN vehicles v
-- joins_exercise-#     ON o.id = v.owner_id;
--  id | first_name | last_name | id |  make  |  model  | year |  price   | owner_id 
-- ----+------------+-----------+----+--------+---------+------+----------+----------
--   1 | Bob        | Hope      |  1 | Toyota | Corolla | 2002 |  2999.99 |        1
--   1 | Bob        | Hope      |  2 | Honda  | Civic   | 2012 | 12999.99 |        1
--   2 | Jane       | Smith     |  3 | Nissan | Altima  | 2016 | 23999.99 |        2
--   2 | Jane       | Smith     |  4 | Subaru | Legacy  | 2006 |  5999.99 |        2
--   3 | Melody     | Jones     |  5 | Ford   | F150    | 2012 |  2599.99 |        3
--   3 | Melody     | Jones     |  6 | GMC    | Yukon   | 2016 | 12999.99 |        3
--   4 | Sarah      | Palmer    |  7 | GMC    | Yukon   | 2014 | 22999.99 |        4
--   4 | Sarah      | Palmer    |  8 | Toyota | Avalon  | 2009 | 12999.99 |        4
--   4 | Sarah      | Palmer    |  9 | Toyota | Camry   | 2013 | 12999.99 |        4
--   5 | Alex       | Miller    | 10 | Honda  | Civic   | 2001 |  7999.99 |        5
--   6 | Shana      | Smith     | 11 | Nissan | Altima  | 1999 |  1899.99 |        6
--   6 | Shana      | Smith     | 12 | Lexus  | ES350   | 1998 |  1599.99 |        6
--   6 | Shana      | Smith     | 13 | BMW    | 300     | 2012 | 22999.99 |        6
--   6 | Shana      | Smith     | 14 | BMW    | 700     | 2015 | 52999.99 |        6
--   7 | Maya       | Malarkin  |    |        |         |      |          |         
-- (15 rows)


--------------------------------second query:---------------------------------------

-- Count the number of cars for each owner. Display the owners first_name , last_name and count of vehicles. The first_name should be ordered in ascending order.

SELECT first_name, last_name, COUNT(owner_id)
    FROM owners o
    JOIN vehicles v
    ON o.id = v.owner_id
    GROUP BY first_name, last_name
    ORDER BY first_name;

-- joins_exercise=# SELECT first_name, last_name, COUNT(owner_id)
-- joins_exercise-#     FROM owners o
-- joins_exercise-#     JOIN vehicles v
-- joins_exercise-#     ON o.id = v.owner_id
-- joins_exercise-#     GROUP BY first_name, last_name
-- joins_exercise-#     ORDER BY first_name;
--  first_name | last_name | count 
-- ------------+-----------+-------
--  Alex       | Miller    |     1
--  Bob        | Hope      |     2
--  Jane       | Smith     |     2
--  Melody     | Jones     |     2
--  Sarah      | Palmer    |     3
--  Shana      | Smith     |     4
-- (6 rows)

-----------------------------------------third query:--------------------------

-- Count the number of cars for each owner and display the average price for each of the cars as integers. Display the owners first_name , last_name, average price and count of vehicles. The first_name should be ordered in descending order. Only display results with more than one vehicle and an average price greater than 10000.

SELECT first_name, last_name, ROUND(AVG(price)) AS average_price, COUNT(owner_id)
    FROM owners o
    JOIN vehicles v
    ON o.id = v.owner_id
    GROUP BY first_name, last_name
    HAVING COUNT(owner_id) > 1 AND ROUND(AVG(price)) > 10000
    ORDER BY first_name DESC;

-- joins_exercise=# SELECT first_name, last_name, ROUND(AVG(price)) AS average_price, COUNT(owner_id)
-- joins_exercise-#     FROM owners o
-- joins_exercise-#     JOIN vehicles v
-- joins_exercise-#     ON o.id = v.owner_id
-- joins_exercise-#     GROUP BY first_name, last_name
-- joins_exercise-#     HAVING COUNT(owner_id) > 1 AND ROUND(AVG(price)) > 10000
-- joins_exercise-#     ORDER BY first_name DESC;
--  first_name | last_name | average_price | count 
-- ------------+-----------+---------------+-------
--  Shana      | Smith     |         19875 |     4
--  Sarah      | Palmer    |         16333 |     3
--  Jane       | Smith     |         15000 |     2
-- (3 rows)


--+++++++++++++++++++++PART TWO++++++++++++++++++++++++++++++++
-- Complete the exercises in the Tutorials steps 6 and 7 in https://sqlzoo.net/

------------------ TUTORIAL 6 ---------------------

------------------      1.      ----------------------

-- The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

-- Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'

SELECT matchid, player FROM goal 
  WHERE teamid = 'GER';

--   Correct answer
-- matchid	player
-- 1008	Mario Gómez
-- 1010	Mario Gómez
-- 1010	Mario Gómez
-- 1012	Lukas Podolski
-- 1012	Lars Bender
-- 1026	Philipp Lahm
-- 1026	Sami Khedira
-- 1026	Miroslav Klose
-- 1026	Marco Reus
-- 1030	Mesut Özil


-------------------     2.     -------------------------

-- From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.

-- Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.

-- Show id, stadium, team1, team2 for just game 1012

SELECT id,stadium,team1,team2
  FROM game 
  WHERE id = 1012;

-- Correct answer
-- id	stadium	team1	team2
-- 1012	Arena Lviv	DEN	GER


-------------------     3.     -------------------------

-- You can combine the two steps into a single query with a JOIN.

-- SELECT *
--   FROM game JOIN goal ON (id=matchid)
-- The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say
-- ON (game.id=goal.matchid)

-- The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.

-- Modify it to show the player, teamid, stadium and mdate for every German goal.

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
WHERE teamid = 'GER';

-- Correct answer
-- player	teamid	stadium	mdate
-- Mario Gómez	GER	Arena Lviv	9 June 2012
-- Mario Gómez	GER	Metalist Stadium	13 June 2012
-- Mario Gómez	GER	Metalist Stadium	13 June 2012
-- Lukas Podolski	GER	Arena Lviv	17 June 2012
-- Lars Bender	GER	Arena Lviv	17 June 2012
-- Philipp Lahm	GER	PGE Arena Gdansk	22 June 2012
-- Sami Khedira	GER	PGE Arena Gdansk	22 June 2012
-- Miroslav Klose	GER	PGE Arena Gdansk	22 June 2012
-- Marco Reus	GER	PGE Arena Gdansk	22 June 2012
-- Mesut Özil	GER	National Stadium, Warsaw	28 June 2012



-------------------     4.     -------------------------

-- Use the same JOIN as in the previous question.

-- Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'

SELECT team1, team2, player
  FROM game JOIN goal ON (id=matchid)
WHERE player LIKE 'Mario%';

-- Correct answer
-- team1	team2	player
-- GER	POR	Mario Gómez
-- NED	GER	Mario Gómez
-- NED	GER	Mario Gómez
-- IRL	CRO	Mario Mandžukic
-- IRL	CRO	Mario Mandžukic
-- ITA	CRO	Mario Mandžukic
-- ITA	IRL	Mario Balotelli
-- GER	ITA	Mario Balotelli
-- GER	ITA	Mario Balotelli


-------------------     5.     -------------------------

-- The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10

SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON teamid=id
 WHERE gtime<=10;

-- Correct answer
-- player	teamid	coach	gtime
-- Petr Jirácek	CZE	Michal Bílek	3
-- Václav Pilar	CZE	Michal Bílek	6
-- Mario Mandžukic	CRO	Slaven Bilic	3
-- Fernando Torres	ESP	Vicente del Bosque	4


-------------------     6.     -------------------------

-- To JOIN game with eteam you could use either
-- game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

-- Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id

-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.

SELECT mdate, teamname
FROM game JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos';

-- Correct answer
-- mdate	teamname
-- 12 June 2012	Greece
-- 16 June 2012	Greece



-------------------     7.     -------------------------

-- List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'

SELECT player 
FROM goal 
JOIN game ON game.id = goal.matchid
WHERE stadium = 'National Stadium, Warsaw';

-- Correct answer
-- player
-- Robert Lewandowski
-- Dimitris Salpingidis
-- Alan Dzagoev
-- Jakub Blaszczykowski
-- Giorgos Karagounis
-- Cristiano Ronaldo
-- Mario Balotelli
-- Mario Balotelli
-- Mesut Özil


-------++++++ MORE DIFFICULT QUESTIONS +++++-------

---------------      8.       ------------------------

-- The example query shows all goals scored in the Germany-Greece quarterfinal.
-- Instead show the name of all players who scored a goal against Germany.

-- HINT
-- Select goals scored only by non-German players in matches where GER was the id of either team1 or team2.

-- You can use teamid!='GER' to prevent listing German players.

-- You can use DISTINCT to stop players being listed twice.

SELECT DISTINCT(player)
  FROM game JOIN goal ON matchid = id
  WHERE teamid != 'GER' AND (team1 = 'GER' OR team2 = 'GER');

--   Correct answer
-- player
-- Robin van Persie
-- Michael Krohn-Dehli
-- Georgios Samaras
-- Dimitris Salpingidis
-- Mario Balotelli


---------------      9.       ------------------------

-- Show teamname and the total number of goals scored.
-- COUNT and GROUP BY
-- You should COUNT(*) in the SELECT line and GROUP BY teamname

SELECT teamname, COUNT(*) AS total_goals
  FROM eteam JOIN goal ON id=teamid
  GROUP BY teamname;

-- Correct answer
-- teamname	total_goals
-- Croatia	4
-- Czech Republic	4
-- Denmark	4
-- England	5
-- France	3
-- Germany	10
-- Greece	5
-- Italy	6
-- Netherlands	2
-- Poland	2
-- Portugal	6
-- Republic of Ireland	1
-- Russia	5
-- Spain	12
-- Sweden	5
-- Ukraine	2


---------------      10.       ------------------------

-- Show the stadium and the number of goals scored in each stadium.

SELECT stadium, COUNT(player) AS total_goals
FROM game JOIN goal ON id=matchid
GROUP BY stadium;

-- Correct answer
-- stadium	total_goals
-- Arena Lviv	9
-- Donbass Arena	7
-- Metalist Stadium	7
-- National Stadium, Warsaw	9
-- Olimpiyskiy National Sports Complex	14
-- PGE Arena Gdansk	13
-- Stadion Miejski (Poznan)	8
-- Stadion Miejski (Wroclaw)	9


---------------      11.       ------------------------

-- For every match involving 'POL', show the matchid, date and the number of goals scored.

SELECT matchid, mdate, COUNT(player)
FROM game JOIN goal ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid;

-- Correct answer
-- matchid	mdate	COUNT(player)
-- 1001	8 June 2012	2
-- 1004	12 June 2012	2
-- 1005	16 June 2012	1


---------------      12.       ------------------------

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(player)
FROM game JOIN goal ON matchid = id 
WHERE teamid='GER' AND (team1 = 'GER' OR team2 = 'GER')
GROUP BY matchid;

-- Correct answer
-- matchid	mdate	COUNT(player)
-- 1008	9 June 2012	1
-- 1010	13 June 2012	2
-- 1012	17 June 2012	2
-- 1026	22 June 2012	4
-- 1030	28 June 2012	1


---------------      13.       ------------------------

-- List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
-- mdate	team1	score1	team2	score2
-- 1 July 2012	ESP	4	ITA	0
-- 10 June 2012	ESP	1	ITA	1
-- 10 June 2012	IRL	1	CRO	3
-- ...
-- Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2.

SELECT 
  mdate,
  team1,
  SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
  team2,
  SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game
JOIN goal ON matchid = id
GROUP BY matchid
ORDER BY mdate, matchid, team1, team2;

-- Result:
-- mdate	team1	score1	team2	score2
-- 1 July 2012	ESP	4	ITA	0
-- 10 June 2012	ESP	1	ITA	1
-- 10 June 2012	IRL	1	CRO	3
-- 11 June 2012	FRA	1	ENG	1
-- 11 June 2012	UKR	2	SWE	1
-- 12 June 2012	GRE	1	CZE	2
-- 12 June 2012	POL	1	RUS	1
-- 13 June 2012	DEN	2	POR	3
-- 13 June 2012	NED	1	GER	2
-- 14 June 2012	ITA	1	CRO	1
-- 14 June 2012	ESP	4	IRL	0
-- 15 June 2012	UKR	0	FRA	2
-- 15 June 2012	SWE	2	ENG	3
-- 16 June 2012	CZE	1	POL	0
-- 16 June 2012	GRE	1	RUS	0
-- 17 June 2012	POR	2	NED	1
-- 17 June 2012	DEN	1	GER	2
-- 18 June 2012	CRO	0	ESP	1
-- 18 June 2012	ITA	2	IRL	0
-- 19 June 2012	ENG	1	UKR	0
-- 19 June 2012	SWE	2	FRA	0
-- 21 June 2012	CZE	0	POR	1
-- 22 June 2012	GER	4	GRE	2
-- 23 June 2012	ESP	2	FRA	0
-- 28 June 2012	GER	1	ITA	2
-- 8 June 2012	POL	1	GRE	1
-- 8 June 2012	RUS	4	CZE	1
-- 9 June 2012	NED	0	DEN	1
-- 9 June 2012	GER	1	POR	0
-- Show what the answer should be...
-- mdate	team1	score1	team2	score2
-- 1 July 2012	ESP	4	ITA	0
-- 10 June 2012	ESP	1	ITA	1
-- 10 June 2012	IRL	1	CRO	3
-- 11 June 2012	FRA	1	ENG	1
-- 11 June 2012	UKR	2	SWE	1
-- 12 June 2012	GRE	1	CZE	2
-- 12 June 2012	POL	1	RUS	1
-- 13 June 2012	DEN	2	POR	3
-- 13 June 2012	NED	1	GER	2
-- 14 June 2012	ITA	1	CRO	1
-- 14 June 2012	ESP	4	IRL	0
-- 15 June 2012	UKR	0	FRA	2
-- 15 June 2012	SWE	2	ENG	3
-- 16 June 2012	CZE	1	POL	0
-- 16 June 2012	GRE	1	RUS	0
-- 17 June 2012	POR	2	NED	1
-- 17 June 2012	DEN	1	GER	2
-- 18 June 2012	CRO	0	ESP	1
-- 18 June 2012	ITA	2	IRL	0
-- 19 June 2012	ENG	1	UKR	0
-- 19 June 2012	SWE	2	FRA	0
-- 21 June 2012	CZE	0	POR	1
-- 22 June 2012	GER	4	GRE	2
-- 23 June 2012	ESP	2	FRA	0
-- 24 June 2012	ENG	0	ITA	0
-- 27 June 2012	POR	0	ESP	0
-- 28 June 2012	GER	1	ITA	2
-- 8 June 2012	POL	1	GRE	1
-- 8 June 2012	RUS	4	CZE	1
-- 9 June 2012	NED	0	DEN	1
-- 9 June 2012	GER	1	POR	0


------------------     TUTORIAL 7      ---------------------

------------------     1.     ---------------------

--List the films where the yr is 1962 [Show id, title]

SELECT id, title
 FROM movie
 WHERE yr=1962

-- Correct answer
-- id	title
-- 10212	A Kind of Loving
-- 10329	A Symposium on Popular Songs
-- 10347	A Very Private Affair (Vie PrivÃ©e)
-- 10648	An Autumn Afternoon
-- 10868	Atraco a las tres
-- 11006	Barabbas
-- 11053	Battle Beyond the Sun (ÐÐµÐ±Ð¾ Ð·Ð¾Ð²ÐµÑ‚)
-- 11199	Big and Little Wong Tin Bar
-- 11230	Billy Budd
-- 11234	Billy Rose's Jumbo
-- 11242	Birdman of Alcatraz
-- 11373	Boccaccio '70
-- 11391	Bon Voyage!
-- 11439	Boys' Night Out
-- 11692	Cape Fear
-- 11735	Carnival of Souls
-- 11753	Carry On Cruising
-- 12368	David and Lisa
-- 12384	Days of Wine and Roses
-- 12710	Dr. No
-- 12817	L'Eclisse
-- 12967	Tutti a casa
-- 12992	Experiment in Terror
-- 13010	Eyes Without a Face
-- 13484	Gay Purr-ee
-- 13534	Gigot
-- 13641	Gorath
-- 13727	Gypsy
-- 13741	Half Ticket
-- 13798	Harakiri
-- 14317	In Search of the Castaways
-- 14454	It's Only Money
-- 14550	Jigsaw
-- 14718	Kid Galahad
-- 14860	La commare secca
-- 14873	La notte
-- 14972	Lawrence of Arabia
-- 15088	Life for Ruth
-- 15173	Lolita
-- 15182	Long Day's Journey into Night
-- 15247	Love at Twenty
-- 15297	Lycanthropus
-- 15397	Mamma Roma
-- 15564	Merrill's Marauders
-- 15752	Mother Joan of the Angels
-- 15779	Mr. Hobbs Takes a Vacation
-- 15840	Mutiny on the Bounty
-- 16203	On the Beat
-- 16295	Os Cafajestes
-- 16367	Panic in Year Zero!


------------------     2.  When was Citizen Kane released?   --------------------

-- Give year of 'Citizen Kane'.

SELECT yr FROM movie WHERE title = 'Citizen Kane';

-- Correct answer
-- yr
-- 1941


------------------     3. Star Trek movies  --------------------

-- List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.

SELECT id, title, yr FROM movie WHERE title LIKE "%Star Trek%" ORDER BY yr;

-- Correct answer
-- id	title	yr
-- 17772	Star Trek: The Motion Picture	1979
-- 17775	Star Trek II: The Wrath of Khan	1982
-- 17776	Star Trek III: The Search for Spock	1984
-- 17777	Star Trek IV: The Voyage Home	1986
-- 17779	Star Trek V: The Final Frontier	1989
-- 17780	Star Trek VI: The Undiscovered Country	1991
-- 17774	Star Trek Generations	1994
-- 17770	Star Trek: First Contact	1996
-- 17771	Star Trek: Insurrection	1998
-- 17778	Star Trek Nemesis	2002
-- 17773	Star Trek	2009


------------------     4. id for actor Glenn Close  --------------------

-- What id number does the actor 'Glenn Close' have?

SELECT id FROM actor WHERE name = 'Glenn Close';

-- Correct answer
-- id
-- 140


------------------     5. id for Casablanca --------------------

-- What is the id of the film 'Casablanca'

SELECT id FROM movie WHERE title = 'Casablanca';

-- Correct answer
-- id
-- 11768


------------------     6.Cast list for Casablanca    --------------------

-- Obtain the cast list for 'Casablanca'.

-- what is a cast list?
--The cast list is the names of the actors who were in the movie.

-- Use movieid=11768, (or whatever value you got from the previous question)

SELECT a.name
 FROM movie m
 JOIN casting c ON m.id=c.movieid
 JOIN actor a ON a.id=c.actorid
 WHERE c.movieid=11768;

--  Correct answer
-- name
-- Peter Lorre
-- John Qualen
-- Madeleine LeBeau
-- Jack Benny
-- Dan Seymour
-- Norma Varden
-- Ingrid Bergman
-- Conrad Veidt
-- Leon Belasco
-- Humphrey Bogart
-- Sydney Greenstreet
-- Helmut Dantine
-- Leonid Kinskey
-- Wolfgang Zilzer
-- Claude Rains
-- Curt Bois
-- Leo White
-- Ludwig StÃ¶ssel
-- Marcel Dalio
-- Paul Henreid
-- Joy Page
-- S. Z. Sakall
-- Dooley Wilson
-- William Edmunds
-- Gregory Gaye
-- Torben Meyer
-- Georges Renavent
-- Jean Del Val
-- Louis V. Arco
-- Trude Berliner
-- Ilka GrÃ¼nig
-- Richard Ryen
-- Hans Twardowski


------------------     7. Alien cast list     ----------------

-- Obtain the cast list for the film 'Alien'

SELECT a.name
 FROM movie m
 JOIN casting c ON m.id=c.movieid
 JOIN actor a ON a.id=c.actorid
 WHERE m.title = 'Alien';

--  Correct answer
-- name
-- John Hurt
-- Sigourney Weaver
-- Yaphet Kotto
-- Harry Dean Stanton
-- Ian Holm
-- Tom Skerritt
-- Veronica Cartwright


------------------     8. Harrison FOrd movies    ----------------

-- List the films in which 'Harrison Ford' has appeared

SELECT m.title
 FROM movie m
 JOIN casting c ON m.id=c.movieid
 JOIN actor a ON a.id=c.actorid
 WHERE a.name='Harrison Ford';

--  Correct answer
-- title
-- A Hundred and One Nights
-- Air Force One
-- American Graffiti
-- Apocalypse Now
-- Clear and Present Danger
-- Cowboys & Aliens
-- Crossing Over
-- Dead Heat on a Merry-Go-Round
-- Extraordinary Measures
-- Firewall
-- Force 10 From Navarone
-- Hanover Street
-- Hawthorne of the U.S.A.
-- Hollywood Homicide
-- Indiana Jones and the Kingdom of the Crystal Skull
-- Indiana Jones and the Last Crusade
-- Indiana Jones and the Temple of Doom
-- Jimmy Hollywood
-- K-19: The Widowmaker
-- More American Graffiti
-- Morning Glory
-- Patriot Games
-- Presumed Innocent
-- Raiders of the Lost Ark
-- Random Hearts
-- Regarding Henry
-- Sabrina
-- Sally of the Sawdust
-- Shadows
-- Six Days Seven Nights
-- Smilin' Through
-- Star Wars Episode IV: A New Hope
-- Star Wars Episode V: The Empire Strikes Back
-- Star Wars Episode VI: Return of the Jedi
-- The Conversation
-- The Devil's Own
-- The Fugitive
-- The Mosquito Coast
-- The Star Wars Holiday Special
-- What Lies Beneath
-- Witness
-- Working Girl


------------------     9. Harrison Ford as supporting actor   ----------------

-- List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]

SELECT m.title
 FROM movie m
 JOIN casting c ON m.id=c.movieid
 JOIN actor a ON a.id=c.actorid
 WHERE a.name='Harrison Ford' AND c.ord != 1;

--  Correct answer
-- title
-- A Hundred and One Nights
-- American Graffiti
-- Apocalypse Now
-- Cowboys & Aliens
-- Dead Heat on a Merry-Go-Round
-- Extraordinary Measures
-- Force 10 From Navarone
-- Hawthorne of the U.S.A.
-- Jimmy Hollywood
-- More American Graffiti
-- Morning Glory
-- Sally of the Sawdust
-- Shadows
-- Smilin' Through
-- Star Wars Episode IV: A New Hope
-- Star Wars Episode V: The Empire Strikes Back
-- Star Wars Episode VI: Return of the Jedi
-- The Conversation
-- Working Girl


------------------    10. Lead actors in 1962 movies   ----------------

-- List the films together with the leading star for all 1962 films.

SELECT m.title, a.name
 FROM movie m
 JOIN casting c ON m.id=c.movieid
 JOIN actor a ON a.id=c.actorid
 WHERE m.yr = 1962 AND c.ord = 1;

--  Correct answer
-- title	name
-- A Kind of Loving	Alan Bates
-- A Symposium on Popular Songs	Paul Frees
-- A Very Private Affair (Vie PrivÃ©e)	Brigitte Bardot
-- An Autumn Afternoon	Chishu Ryu
-- Atraco a las tres	JosÃ© Luis LÃ³pez VÃ¡zquez
-- Barabbas	Anthony Quinn
-- Battle Beyond the Sun (ÐÐµÐ±Ð¾ Ð·Ð¾Ð²ÐµÑ‚)	Aleksandr Shvorin
-- Big and Little Wong Tin Bar	Jackie Chan
-- Billy Budd	Terence Stamp
-- Billy Rose's Jumbo	Doris Day
-- Birdman of Alcatraz	Burt Lancaster
-- Boccaccio '70	Anita Ekberg
-- Bon Voyage!	Fred MacMurray
-- Boys' Night Out	Kim Novak
-- Cape Fear	Gregory Peck
-- Carnival of Souls	Candace Hilligoss
-- Carry On Cruising	Sid James
-- David and Lisa	Keir Dullea
-- Days of Wine and Roses	Jack Lemmon
-- Dr. No	Sean Connery
-- L'Eclisse	Alain Delon
-- Tutti a casa	Alberto Sordi
-- Experiment in Terror	Glenn Ford
-- Eyes Without a Face	Pierre Brasseur
-- Gay Purr-ee	Judy Garland
-- Gigot	Jackie Gleason
-- Gorath	Ryo Ikebe
-- Gypsy	Rosalind Russell
-- Half Ticket	Kishore Kumar
-- Harakiri	Tatsuya Nakadai
-- In Search of the Castaways	Hayley Mills
-- It's Only Money	Jerry Lewis
-- Jigsaw	Jack Warner
-- Kid Galahad	Elvis Presley
-- La commare secca	Marisa Solinas
-- La notte	Marcello Mastroianni
-- Life for Ruth	Michael Craig
-- Lolita	James Mason
-- Long Day's Journey into Night	Katharine Hepburn
-- Love at Twenty	Jean-Pierre LÃ©aud
-- Lycanthropus	Barbara Lass
-- Mamma Roma	Anna Magnani
-- Merrill's Marauders	Jeff Chandler
-- Mother Joan of the Angels	Lucyna Winnicka
-- Mr. Hobbs Takes a Vacation	James Stewart
-- Mutiny on the Bounty	Marlon Brando
-- On the Beat	Norman Wisdom
-- Os Cafajestes	Daniel Filho
-- Panic in Year Zero!	Ray Milland
-- Period of Adjustment	Anthony Franciosa


-----------+++++++    HARDER QUESTIONS     +++++++--------------

------------------    11. Busy years for Rock Hudson  ----------------

-- Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.

SELECT yr,COUNT(title) 
FROM movie 
JOIN casting ON movie.id=movieid
JOIN actor ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2;

-- Correct answer
-- yr	COUNT(title)
-- 1953	5
-- 1961	3


------------------    12. Lead actor in Julie Andrews movies  ----------------

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in.

-- Did you get "Little Miss Marker twice"?

SELECT title, name
  FROM movie 
  JOIN casting ON (movieid=movie.id AND ord=1)
  JOIN actor ON (actorid=actor.id)
  WHERE movie.id IN (SELECT movieid 
   FROM casting
   WHERE actorid IN (
    SELECT id
    FROM actor
    WHERE name='Julie Andrews'));

--     Correct answer
-- title	name
-- 10	Dudley Moore
-- Darling Lili	Julie Andrews
-- Despicable Me	Steve Carell
-- Duet for One	Julie Andrews
-- Hawaii	Julie Andrews
-- Little Miss Marker	Walter Matthau
-- Mary Poppins	Julie Andrews
-- Relative Values	Julie Andrews
-- S.O.B.	Julie Andrews
-- Shrek the Third	Mike Myers
-- Star!	Julie Andrews
-- The Americanization of Emily	James Garner
-- The Pink Panther Strikes Again	Peter Sellers
-- The Princess Diaries	Anne Hathaway
-- The Princess Diaries 2: Royal Engagement	Anne Hathaway
-- The Sound of Music	Julie Andrews
-- The Tamarind Seed	Julie Andrews
-- Thoroughly Modern Millie	Julie Andrews
-- Tooth Fairy	Dwayne Johnson
-- Torn Curtain	Paul Newman
-- Victor Victoria	Julie Andrews


------------------    13. Actors with 15 leading roles  ----------------

-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles.

SELECT a.name
  FROM actor a
  JOIN casting c ON a.id = actorid
  JOIN movie m ON m.id = movieid
  WHERE c.ord = 1
  GROUP BY a.name
  HAVING COUNT(m.title) >= 15;

-- Correct answer
-- name
-- Adam Sandler
-- Al Pacino
-- Anthony Hopkins
-- Antonio Banderas
-- Arnold Schwarzenegger
-- Barbara Stanwyck
-- Basil Rathbone
-- Ben Affleck
-- Bette Davis
-- Betty Grable
-- Bing Crosby
-- Bruce Willis
-- Bud Abbott
-- Burt Lancaster
-- Burt Reynolds
-- Buster Keaton
-- Cary Grant
-- Charles Bronson
-- Charlton Heston
-- Clark Gable
-- Claudette Colbert
-- Clint Eastwood
-- Dean Martin
-- Dennis Quaid
-- Denzel Washington
-- Dirk Bogarde
-- Dustin Hoffman
-- Edward G. Robinson
-- Elvis Presley
-- Errol Flynn
-- Frank Sinatra
-- Fred Astaire
-- Fredric March
-- Gary Cooper
-- GÃ©rard Depardieu
-- Gene Hackman
-- George Clooney
-- Glenn Ford
-- Gregory Peck
-- Greta Garbo
-- Harrison Ford
-- Henry Fonda
-- Humphrey Bogart
-- Ingrid Bergman
-- Jack Lemmon
-- Jack Nicholson
-- Jackie Chan
-- James Cagney
-- James Mason
-- James Stewart


  ------------------    14. released in the year 1978 ----------------

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title.

SELECT m.title, COUNT(actorid)
 FROM movie m
 JOIN casting c ON m.id=c.movieid
 JOIN actor a ON a.id=c.actorid
 WHERE m.yr = 1978
 GROUP BY m.title
 ORDER BY COUNT(actorid) DESC, title ASC;

--  Correct answer
-- title	COUNT(actorid)
-- The Bad News Bears Go to Japan	50
-- The Swarm	37
-- Grease	28
-- American Hot Wax	27
-- The Boys from Brazil	26
-- Heaven Can Wait	25
-- Big Wednesday	21
-- A Night Full of Rain	19
-- A Wedding	19
-- Orchestra Rehearsal	19
-- The Cheap Detective	19
-- Go Tell the Spartans	18
-- Death on the Nile	17
-- Movie Movie	17
-- Superman	17
-- The Cat from Outer Space	17
-- The Driver	17
-- The Star Wars Holiday Special	17
-- Blue Collar	16
-- Ice Castles	16
-- International Velvet	16
-- J.R.R. Tolkien's The Lord of the Rings	16
-- Alexandria... Why?	15
-- Bye Bye Monkey	15
-- Coming Home	15
-- David	15
-- Gray Lady Down	15
-- Occupation in 26 Pictures	15
-- Revenge of the Pink Panther	15
-- The Brink's Job	15
-- The Chant of Jimmie Blacksmith	15
-- The Water Babies	15
-- Violette NoziÃ¨re	15
-- Who'll Stop The Rain	15
-- Without Anesthesia	15
-- Bread and Chocolate	14
-- Closed Circuit	14
-- Damien: Omen II	14
-- I Wanna Hold Your Hand	14
-- The Empire of Passion	14
-- Almost Summer	13
-- An Unmarried Woman	13
-- Foul Play	13
-- Goin' South	13
-- The Left-Handed Woman	13
-- California Suite	12
-- Force 10 From Navarone	12
-- In Praise of Older Women	12
-- Jaws 2	12
-- Midnight Express	12


------------------    15. with 'Art Garfunkel ----------------

--   List all the people who have worked with 'Art Garfunkel'.

SELECT name
  FROM movie 
  JOIN casting ON (movieid=movie.id)
  JOIN actor ON (actorid=actor.id)
  WHERE movie.id IN (SELECT movieid 
   FROM casting
   WHERE actorid IN (
    SELECT id
    FROM actor
    WHERE name='Art Garfunkel'))
  AND actor.name != 'Art Garfunkel';

-- Correct answer
-- name
-- Mark Ruffalo
-- Ryan Phillippe
-- Mike Myers
-- Neve Campbell
-- Salma Hayek
-- Sela Ward
-- Breckin Meyer
-- Sherry Stringfield
-- Cameron Mathison
-- Heather Matarazzo
-- Skipp Sudduth
-- Lauren Hutton
-- Michael York
-- Ellen Albertini Dow
-- Thelma Houston
-- Ron Jeremy
-- Elio Fiorucci
-- Sheryl Crow
-- Georgina Grenville
-- Cindy Crawford
-- Heidi Klum
-- Donald Trump
-- Cecilie Thomsen
-- Frederique van der Wal
-- Veronica Webb
-- Peter Bogdanovich
-- Beverly Johnson
-- Bruce Jay Friedman
-- Lorna Luft
-- Valerie Perrine
-- Stars on 54
-- Julian Sands
-- Bill Paxton
-- Sherilyn Fenn
-- Kurtwood Smith
-- Harris Yulin
-- Robert DoQui
