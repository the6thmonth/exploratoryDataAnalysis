getwd()
?par
?transform

x=rnorm(100)
hist(x)
y=rnorm(100)
plot(x,y)
par(mar=c(2,2,2,2))
plot(x,y)
par(mar = c(4,4,4,2))
plot(x,y)
plot(x,y,pch = 20)
title("Scatter plot")
text(-2,-2,"Label")
legend("topleft", legend = "Data")
legend("topleft", legend = "Data", pch = 20)
fit=lm(y~x)
abline(fit)
abline(fit, lwd=3)
abline(fit, lwd=3, col="blue")
?gl

library(datasets)
with(faithful, plot(faithful$eruptions, faithful$waiting))
title(main = "Faithful Geyser Data")
