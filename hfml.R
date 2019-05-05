library(lme4)
library(plyr)
library(MASS)

narrowData <- subset(hfml, cooperation == 1 || cooperation == 4)

narrowData$cd <- hfml$cooperation == 1
narrowData$ncd <- hfml$cooperation == 4

#shared understanding 

narrowData$factorial_shared_understanding <- factor(narrowData$shared_understanding, c(0, -2, -1, 1, 2))

model1 <- polr(factor(cooperation) ~ factorial_shared_understanding, data = narrowData, Hess=T)
model1.null <- polr(factor(cooperation) ~ 1, data = narrowData, Hess=T)

ratio <- model1.null$deviance - model1$deviance
df <- model1.null$df.residual - model1$df.residual

1-pchisq(ratio, df)

exp(confint(model1))

exp(model1$coefficients)

#AI Optimism 

narrowData$factorial_AI_optimism <- factor(narrowData$AI_optimism, c(0, -2, -1, 1, 2))

model2 <- polr(factor(cooperation) ~ factorial_AI_optimism, data = narrowData, Hess=T)
model2.null <- polr(factor(cooperation) ~ 1, data = narrowData, Hess=T)

ratio <- model2.null$deviance - model2$deviance
df <- model2.null$df.residual - model2$df.residual

1-pchisq(ratio, df)

exp(confint(model2))

exp(model2$coefficients)

#human preference

narrowData$factorial_human_preference <- factor(narrowData$human_preference, c(0, -2, -1, 1, 2))

model3 <- polr(factor(cooperation) ~ factorial_human_preference, data = narrowData, Hess=T)
model3.null <- polr(factor(cooperation) ~ 1, data = narrowData, Hess=T)

ratio <- model3.null$deviance - model3$deviance
df <- model3.null$df.residual - model3$df.residual

1-pchisq(ratio, df)

exp(confint(model3))

exp(model3$coefficients)



