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

aiOnlyData = subset(hawkdove, condition=="ai")
humanOnlyData = subset(hawkdove, condition=="human")

nSmallTest <- function(specData, x) {
	by(specData$x, specData$opponent, stat.desc, basic=F, norm=T)
	leveneTest(specData$x, specData$opponent, center=median)
}

nLargePlot <- function(specData, varY) {
	Adata <- specData
	ggplot(Adata, aes(varY)) + geom_histogram(aes(y=..density..), binwidth=1, color="black", fill="white") + stat_function(fun = dnorm, args = list(mean = mean(Adata$varY), sd = sd(Adata$varY)))
	qplot(sample = Adata$varY, stat="qq")
}

ppoOnlyData = subset(aiOnlyData, opponent=="ppo")
vpgOnlyData = subset(aiOnlyData, opponent=="vpg")
dqnOnlyData = subset(aiOnlyData, opponent=="dqn")

ggplot(ppoOnlyData, aes(human_attack_freq_A)) + geom_histogram(aes(y=..density..), binwidth=1, color="black", fill="white") + stat_function(fun = dnorm, args = list(mean = mean(ppoOnlyData$human_attack_freq_A), sd = sd(ppoOnlyData$human_attack_freq_A)))
	qplot(sample = ppoOnlyData$human_attack_freq_A, stat="qq")

hist(aiOnlyData$human_attack_freq_A, col=rgb(1,0,0,0.5),xlim=c(0,10), ylim=c(0,100), main="First Game", xlab="Frequency of Human Attacks")
hist(aiOnlyData$human_attack_freq_B, col=rgb(0,0,1,0.5), xlim=c(0,10), ylim=c(0,100), main="Second Game", xlab="Frequency of Human Attacks")
hist(aiOnlyData$human_attack_freq_C, col=rgb(0,1,0.5,0.5), xlim=c(0,10), ylim=c(0,100), main="Third Game", xlab="Frequency of Human Attacks")

hist(aiOnlyData$AI_attack_freq_A, col=rgb(1,0,0,0.5),xlim=c(0,10), ylim=c(0,100), main="First Game", xlab="Frequency of AI Attacks")
hist(aiOnlyData$AI_attack_freq_B, col=rgb(0,0,1,0.5), xlim=c(0,10), ylim=c(0,100), main="Second Game", xlab="Frequency of AI Attacks")
hist(aiOnlyData$AI_attack_freq_C, col=rgb(0,1,0.5,0.5), xlim=c(0,10), ylim=c(0,100), main="Third Game", xlab="Frequency of AI Attacks")

hist(aiOnlyData$human_peace_freq_A, col=rgb(1,0,0,0.5),xlim=c(0,10), ylim=c(0,100), main="First Game", xlab="Frequency of Peaceful Human Moves")
hist(aiOnlyData$human_peace_freq_B, col=rgb(0,0,1,0.5), xlim=c(0,10), ylim=c(0,100), main="Second Game", xlab="Frequency of Peaceful Human Moves")
hist(aiOnlyData$human_peace_freq_C, col=rgb(0,1,0.5,0.5), xlim=c(0,10), ylim=c(0,100), main="Third Game", xlab="Frequency of Peaceful Human Moves")

hist(aiOnlyData$AI_peace_freq_A, col=rgb(1,0,0,0.5),xlim=c(0,10), ylim=c(0,100), main="First Game", xlab="Frequency of Peaceful AI Moves")
hist(aiOnlyData$AI_peace_freq_B, col=rgb(0,0,1,0.5), xlim=c(0,10), ylim=c(0,100), main="Second Game", xlab="Frequency of Peaceful AI Moves")
hist(aiOnlyData$AI_peace_freq_C, col=rgb(0,1,0.5,0.5), xlim=c(0,10), ylim=c(0,100), main="Third Game", xlab="Frequency of Peaceful AI Moves")


hist(ppoOnlyData$human_attack_freq_A, col=rgb(1,0,0,0.5),xlim=c(0,10), ylim=c(0,100), main="First Game with PPO", xlab="Frequency of Human Attacks")
hist(vpgOnlyData$human_attack_freq_A, col=rgb(0,0,1,0.5), xlim=c(0,10), ylim=c(0,100), main="First Game with VPG", xlab="Frequency of Human Attacks")
hist(dqnOnlyData$human_attack_freq_A, col=rgb(0,1,0.5,0.5), xlim=c(0,10), ylim=c(0,100), main="First Game with DQN", xlab="Frequency of Human Attacks")

ggplot(aiOnlyData,aes(opponent, human_attack_freq_A)) + stat_summary(fun.y=mean, geom="bar", fill="light blue", color="black") + stat_summary(fun.data=mean_cl_normal, geom="errorbar", width=0.2)

#filled desnity plot
p <- ggplot(aiOnlyData, aes(human_attack_freq_A, colour=opponent, fill=opponent))
p + geom_density(alpha=0.55)

#indepentn t-=test
justPPO <- subset(hawkdove, opponent="ppo")
result <- t.test(human_attack_average ~ condition, data = hawkdove)

#anova
ppo_v_vpg_and_dqn <- c(-2/3, 1/3, 1/3)
vpg_v_dqn <- c(0, -1/2, 1/2)
contrasts(aiOnlyData$opponent) <- cbind(ppo_v_vpg_and_dqn, vpg_v_dqn)

model1 <- aov(varY ~ varX, data = data)

summary(model1)

omega_aov <- function(model){
 MS<-summary(model)[[1]]$'Mean Sq'; #get the mean squares
 df<-summary(model)[[1]]$Df; #get the Dfs
 MSr<-MS[length(MS)]; #get MSr (the last one)
 N<-sum(df)+1; #get N (sum of df+1)
 MS<-MS[-c(length(MS))]; #remove MSr from MS
 df<-df[-c(length(df))]; #remove dfr from df
 var<-df*(MS-MSr)/N; #get the variances
 varTotal<-sum(var)+MSr; #get the total variance
 omega.squared<-var/varTotal; #get the omega-squareds
 omega<-sqrt(omega.squared); #get the omegas
 labels<-attr(model$terms,"term.labels"); #get labels
 return(cbind(labels,omega,omega.squared))
}

omega_aov(model1)

post <- glht(model1, linfct=mcp(varX = “Tukey”))
summary(post)
confint(post)


