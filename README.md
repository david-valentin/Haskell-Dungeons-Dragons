# Haskell-Dungeons-Dragons
Peer to Peer Dungeons and Dragons Game

# Abstract:

Dungeons of Dragons is fun. The purpose of the project is to create a Dungeons and Dragons like game that is peer to peer.  Users will login into a server and will be pooled into groups of two players. Players will start off in co-operative group and will only be able to make a single decision in each Minor event. Eventually players will face a Major event that will decide whether the players will continue co-operating or diverge into different storylines. 

The work will primarily be divided based off of comfortability with certain subjects i.e. David is more comfortable with working databases and SQL scripting. Kristin has worked with servers and parsing. Work will be done together on each topic; however, the individual who feels more comfortable with the topic will define goals for each hour spent on the part of the project. 

# Goals and Objectives:

Designing the actual data and potential types should be the primary and initial focus as we want to design the database around how the data is structured. The secondary goal is implementing a peer to peer network and database. The Dungeons and Dragons like game will present randomized events and game theory like problems for all players and these choices will be recorded in the database. The decisions made will cause certain events to occur between players’ storylines and alter the randomization of events and will ultimately affect the outcome of the storyline. 

# Gamplay Aspects:

## Standard IO interaction:

After much wandering in the poorly lit mine, the heroes spot a pack of goblins around a chest in the abandoned mine. 

## Terms to define:

### Major Events:
* Major events will include a game theory problem in which each player will make their own decision. The outcome of the decision will decide whether or not the players will continue co-operating in a single storyline or diverge into their own storylines. 

### Minor Events:
1. Minor events will involve an IO interaction:
* Involves combat with a creature(s) 
* Entering a new destination
* Engaging with random individuals in the game


### Main Storyline:
*	The main storyline will be a tree structure which will store the weights accrued from other the players' storylines. These weights will be passed into a finality function along with player stats which will produce an ending involving both players or if the players choose to separate to single player during the major event.



### General Resources: 
*	https://en.wikipedia.org/wiki/List_of_games_in_game_theory

# Project Plan: 

Week 1-2:

*	Build Library for Dungeons and Dragons data structures and types i.e. Orcs, Wizards, Dragons?
*	Define how events are generated and passed - Parameters to pass certain conditions
*	Attributes and skills for characters
*	Create main-plot line and how decisions affect other players events/storyline → Game Theory tests 
*	Create certain functions to interact between the data and types - and IO friendly

Resources:

*	Randomization Library: https://hackage.haskell.org/package/random-1.1/docs/System-Random.html
*	Tree Library in Haskell:
*	https://hackage.haskell.org/package/containers-0.5.8.1/docs/Data-Tree.html

Week 3-4:

1.	Build a web server and database in Haskell
  * Test server out between users 
  *	Understand how users interact with each other 
2.	Build a SQLite Database in Haskell 
  *	Upload test data in database 
  *	Test basic queries on db - create standard queries going to be used to be processed through get/post requests
  *	Send data to server chat session
3.	Integrate both projects and test out sessions between users.

Resources:

*	Building database: http://book.realworldhaskell.org/read/using-databases.html 
*	SQLite Database Library: https://hackage.haskell.org/package/sqlite-simple-0.4.9.0/docs/Database-SQLite-Simple.html
*	Library processing post/get requests: https://hackage.haskell.org/package/http-streams-0.8.4.0/docs/Network-Http-Client.html 












