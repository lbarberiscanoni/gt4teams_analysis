library(ggplot2)
library(pastecs)
library(QuantPsyc)
library(carData)
library(caret)
library(car)
library(Hmisc)
library(plyr)
library(mvtnorm)
library(WRS2)
library(multcomp)

aiOnlyData = subset(bos, condition=="ai")
humanOnlyData = subset(bos, condition=="human")

ppoOnlyData = subset(aiOnlyData, opponent=="ppo")
vpgOnlyData = subset(aiOnlyData, opponent=="vpg")
dqnOnlyData = subset(aiOnlyData, opponent=="dqn")




hist(aiOnlyData$coordination_selfish_average, col=rgb(0,0,1,0.5), xlim=c(0,10), ylim=c(0,50), main="Coordination", xlab="Average Coordination Between Rounds")
hist(aiOnlyData$coordination_altruistic_average, col=rgb(1,0,0,0.5), add=T)
legend("topright", c("Human-preferred", "AI-preferred"), fill=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)))

hist(aiOnlyData$non_coordination_selfish_average, col=rgb(0,0,1,0.5), xlim=c(0,10), ylim=c(0,50), main="Failure to Coordinate", xlab="Average Non-Coordination Between Rounds")
hist(aiOnlyData$non_coordination_altruistic_average, col=rgb(1,0,0,0.5), add=T)
legend("topright", c("Human-preferred", "AI-preferred"), fill=c(rgb(0,0,1,0.5), rgb(1,0,0,0.5)))

scatterplot(non_coordination_selfish_average ~ non_coordination_altruistic_average, data=aiOnlyData, xlab="Human betrays AI", ylab="AI betrays Human", main="Betrayals")


#anova
ppo_v_vpg_and_dqn <- c(-2/3, 1/3, 1/3)
vpg_v_dqn <- c(0, -1/2, 1/2)
contrasts(aiOnlyData$opponent) <- cbind(ppo_v_vpg_and_dqn, vpg_v_dqn)

model1 <- aov(coordination_altruistic_average ~ opponent, data = aiOnlyData)

summary(model1)

model2 <- aov(coordination_selfish_average ~ opponent, data = aiOnlyData)

summary(model2)

model3 <- aov(non_coordination_selfish_average ~ opponent, data = aiOnlyData)

summary(model3)

model4 <- aov(non_coordination_altruistic_average ~ opponent, data = aiOnlyData)

summary(model4)