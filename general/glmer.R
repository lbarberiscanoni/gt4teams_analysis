library(lme4)
library(plyr)
library(MASS)

pd$cd <- pd$cooperation == 1
pd$ncd <- pd$cooperation == 4

aiOnlyData = subset(pd, condition == "ai")

model1 <- glmer(formula = cd ~ opponent + turn + (1 | humanID), data = aiOnlyData, family="binomial")
summary(model1)

model2 <- glmer(formula = cd ~ condition + turn + (1 | humanID), data = pd, family="binomial")
summary(model2)

model3 <- glmer(formula = cd ~ condition + opponent + turn + (1 | humanID), data = pd, family="binomial")
summary(model3)

#---------------------------------------------#

bos$cd <- bos$cooperation == 1
bos$ncd <- bos$cooperation == 2

aiOnlyData = subset(bos, condition == "ai")

model1 <- glmer(formula = cd ~ opponent + turn + (1 | humanID), data = aiOnlyData, family="binomial")
summary(model1)

model2 <- glmer(formula = cd ~ condition + turn + (1 | humanID), data = bos, family="binomial")
summary(model2)

model3 <- glmer(formula = cd ~ condition + opponent + turn + (1 | humanID), data = bos, family="binomial")
summary(model3)

#---------------------------------------------#

hd$cd <- hd$cooperation == 1
hd$ncd <- hd$cooperation == 4

aiOnlyData = subset(hd, condition == "ai")

model1 <- glmer(formula = cd ~ opponent + turn + (1 | humanID), data = aiOnlyData, family="binomial")
summary(model1)

model2 <- glmer(formula = ncd ~ opponent + turn + (1 | humanID), data = aiOnlyData, family="binomial")
summary(model2)

model3 <- glmer(formula = cd ~ condition + turn + (1 | humanID), data = hd, family="binomial")
summary(model3)

model4 <- glmer(formula = ncd ~ condition + turn + (1 | humanID), data = hd, family="binomial")
summary(model4)

#------------------------------------------------#


