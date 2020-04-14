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

aiOnlyData = subset(pd, condition=="ai")
humanOnlyData = subset(pd, condition=="human")

ppoOnlyData = subset(aiOnlyData, opponent=="ppo")
vpgOnlyData = subset(aiOnlyData, opponent=="vpg")
dqnOnlyData = subset(aiOnlyData, opponent=="dqn")


hist(aiOnlyData$coordination_altruistic_average, col=rgb(1,0,0,0.5), xlim=c(0,10), ylim=c(0,50), main="Cooperation", xlab="Average Mutual Cooperation")
hist(aiOnlyData$coordination_selfish_average, col=rgb(0,0,1,0.5), xlim=c(0,10), ylim=c(0,50), main="Defection", xlab="Average Mutual Non-Cooperation")

scatterplot(non_coordination_selfish_average ~ non_coordination_altruistic_average, data=aiOnlyData, xlab="Human betrays AI", ylab="AI betrays Human", main="Betrayals")

#independent t-test
result <- t.test(coordination_altruistic_average ~ condition, data = pd)

#anova
ppo_v_vpg_and_dqn <- c(-2/3, 1/3, 1/3)
vpg_v_dqn <- c(0, -1/2, 1/2)
contrasts(aiOnlyData$opponent) <- cbind(ppo_v_vpg_and_dqn, vpg_v_dqn)

model1 <- aov(coordination_altruistic_average ~ opponent, data = aiOnlyData)

summary(model1)

model2 <- aov(non_coordination_selfish_average ~ opponent, data = aiOnlyData)

summary(model2)

model3 <- aov(non_coordination_altruistic_average ~ opponent, data = aiOnlyData)

summary(model3)