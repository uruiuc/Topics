


#------------------------------------------------
# Measure of model fit:  ROC Curves
#------------------------------------------------
# Model2, using height as a predictor, looked pretty good at predicting sex.
# Let's see the fitted probabilities:
p <- qplot(fitted(model2)) + xlab("Fitted p.hat")
p

# What "threshold" on the probabilities do we use to declare someone is female?
# How about 50%?
threshold <- 0.5
p + geom_vline(xintercept=threshold, col="red", size=2)

# Using this threshold, we make an explicit prediction of whether the individual
# was female or not, if the fitted probability exceeds the threshold
predictions <-
  select(profiles, is.female) %>%
  mutate(phat=fitted(model2)) %>%
  mutate(predicted.female=ifelse(phat > threshold, 1, 0))
predictions

# We now compare our predictions with the truth:  the is.female variable.  We see
# we make two kinds of errors:
# -Predicting someone is female when they're not
# -Prediction someone is not female when the are
count(predictions, is.female, predicted.female)

# We use the table() command to view this in a contigency table
performance <- table(truth=predictions$is.female, predicted=predictions$predicted.female)
performance
mosaicplot(performance, main="Truth vs Predicted")

# We see we had a
# -False Postive Rate = 559/(559+3028) = 15.6%
# -True Postive Rate = 1932/(1932+476) = 80.2%
FPR <- 559/(559+3028)
TPR <- 1932/(1932+476)