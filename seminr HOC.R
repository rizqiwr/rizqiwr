setwd("D:/OneDrive - UGM 365/Thesis/Data")
library("seminr")
tesis1 <- read.csv(file = "data.CSV", header = TRUE)
head(tesis1)
View(tesis1)

#Create measurement model
tesis1_mm <- constructs(
  composite("innovativeness",        multi_items("INN", 1:4)),
  composite("cognitive",        multi_items("COG", 1:3)),
  composite("affective",        multi_items("AFF", 1:4)),
  composite("active",          multi_items("ACT", 1:3)),
  higher_composite("engagement", dimensions = c("cognitive","affective", "active")),
  composite("participation",      multi_items("CPB", 1:5)),
  composite("citizenship",   multi_items("CCB", 1:4))
)

plot(tesis1_mm)
#Create structural model
tesis1_sm <- relationships(
  paths(from = c("innovativeness"),  to = c("participation","citizenship")),
  paths(from = c("innovativeness"), to = c("engagement")),
  paths(from = c("engagement"), to = c("participation", "citizenship"))
)
plot(tesis1_sm)
#Estimate the model
tesis1_model <- estimate_pls(data = tesis1,
                            measurement_model = tesis1_mm,
                            structural_model = tesis1_sm,
)

# Plot the model
plot(tesis1_model)
summary(tesis1_model)

summary_tesis1_model <- summary(tesis1_model)
summary_tesis1_model$paths #direct effect
summary_tesis1_model$reliability
summary_tesis1_model$meta
summary_tesis1_model$iterations
summary_tesis1_model$total_effects
summary_tesis1_model$total_indirect_effects #mediasi (inspect the total indirect effect)
summary_tesis1_model$loadings
summary_tesis1_model$weights
summary_tesis1_model$validity
summary_tesis1_model$vif_antecedents
summary_tesis1_model$fSquare
summary_tesis1_model$descriptives
summary_tesis1_model$validity$htmt
plot(summary_tesis1_model$reliability)

write.csv(x = summary_tesis1_model$vif_antecedents,
          file = "vif.csv")

#HTMT criterion
summary_tesis1_model$validity$htmt
sum_htmt <- summary(boot_tesis1_model, alpha = 0.10)
sum_htmt$bootstrapped_HTMT

write.csv(x = sum_htmt$bootstrapped_HTMT,
         file = "bootsrappedHTMT.csv")

#STRUCTURAL MODEL ASSESMENT
# Bootstrap the model
boot_tesis1_model <- bootstrap_model(tesis1_model, nboot = 1000, cores = NULL, seed = 123)

#summarize the bootsrapped model
sum_boot_tesis1 <- summary(boot_tesis1_model,
                          alpha = 0.05)
#inspect the SM Colinearity VIF
summary_tesis1_model$vif_antecedents

#inspect the structural paths
sum_boot_tesis1$bootstrapped_paths
#inspect the total effects
sum_boot_tesis1$bootstrapped_total_paths
#inspect the model Rsquares
summary_tesis1_model$paths
#inspect effect size
summary_tesis1_model$fSquare

write.csv(x = summary_tesis1_model$paths,
          file = "total direct effect.csv")


#MEDIASI
#mediasi (inspect the total indirect effect)
summary_tesis1_model$total_indirect_effects

#Inspect indirect effects
specific_effect_significance(boot_tesis1_model,
                             from = "innovativeness",
                             through = "engagement",
                             to = "participation",
                             alpha = 0.05)
specific_effect_significance(boot_tesis1_model,
                             from = "innovativeness",
                             through = "engagement",
                             to = "citizenship",
                             alpha = 0.05)
#inspect the direct effects
summary_tesis1_model$paths
#inspect the confidence intervals for direct effects
sum_boot_tesis1$bootstrapped_paths
#calculate the sign of p1*p2*p3
#Innovativeness --> Participation
summary_tesis1_model$paths ["innovativeness", "participation"] *
  summary_tesis1_model$paths ["innovativeness", "engagement"] *
  summary_tesis1_model$paths ["engagement", "participation"]

#Innovativeness --> Citizenship
summary_tesis1_model$paths ["innovativeness", "citizenship"] *
  summary_tesis1_model$paths ["innovativeness", "engagement"] *
  summary_tesis1_model$paths ["engagement", "citizenship"]

# Pot the bootstrapped model
plot(boot_tesis1_model, title = "Botsrapped Model")

install.packages("knitr")
library(knitr)
knitr::stitch_rhtml('seminr HOC.r')

