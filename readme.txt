# Experiment 1 (prisoners dilemma)

this experiment is based on the prisoner's dilemma. Two criminals commit a crime and are arrested separately and each taken to a different room so the police can get a confession. The police offers a reduced sentence in exchange for a confession to each criminal in order to get them to both confess against each other so they can both go to jail for a long time. If both prisoners stay silent, they get a reduced sentence. If either player confesses and the other doesn't, the player who confessed walks away free and the other gets the death penalty. 

there are 2 players: each player has 2 moves (cooperate, betray) for a total of 4 possible outcomes (both players cooperate, both players betray each other, player A betrays player B, player B betrayes player A)

each human participant is paired against an AI to play 3 sets of 10 turns. They are also either told they are playing against a human or against an AI

the experiment is 3x2: 3 types of AIs (ppo, dqn, vpg) and 2 team-expectations conditions (human, ai) for a total of 6 conditions. 

the expectation bc of game theory is that the human and the AI will always both betray each other even though the best outcome for the team is if they both cooperate. This is why the data is not normally distributed. 

# Experiment 2 (battle of the sexes)

this experiment is based on the battle of the sexes. Alice and Bob are going on a data but they can't communicate and they can't remember if they decided to go to the Opera or the football Game. Alice prefers the Opera, Bob prefers the Game. They both prefer being with each other than being apart at their preferred event. They need to coordinate. 

there are 2 players: each player has 2 moves (Opera, Game) for a total of 4 possible outcomes (both go to the Opera, both go to the Game, player A goes to the Opera and player B goes to the Game, player A goes to the Game and player B goes to the Opera). 

each human participant is paired against an AI to play 3 sets of 10 turns. They are also either told they are playing against a human or against an AI

the experiment is 3x2: 3 types of AIs (ppo, dqn, vpg) and 2 team-expectations conditions (human, ai) for a total of 6 conditions. 

the expecation of game theory is that they two players will oscillated between both going to the Opera and both going to the Game, but they could stay in the same place together throughout all the depending on how good they are coordinating. 

# Overall comments

the data for each experiment is the folder named after the game taking place in the experiment

the paper is currently using a generalized-model with mixed effects because the data is not normally distributed and running an ANOVA results in crazy p-values. 


