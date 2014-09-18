library(datasets)
library(lattice)
airquality
airquality = transform(airquality, Month=factor(Month))
names(airquality)
p=xyplot(Ozone ~ Wind|Month, airquality, layout = c(5,1))
print(p)

#Lattice panel function
xyplot(y~x|f, panel=function(x,y){
  panel.xyplot(x, y)
  panel.abline(h=median(y), lty = 2)
  panel.lmline(x,y,col="red") #generate a linear regression line
})

install.packages("ggplot2")
library(ggplot2)
str(mpg)

qplot(displ, hwy, data=mpg, col=drv, geom=c("point","smooth"))
qplot(hwy, data=mpg, fill=drv)
qplot(displ, hwy, data=mpg, facets=.~drv) #separate into cols
qplot(displ, hwy, data=mpg, facets=drv~.) #separate into rows

?geom_point
?geom_smooth


library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)

?text
?llines
?splom
?trellis.par.set

library(ggplot2)
g <- ggplot(movies, aes(votes, rating))
print(g)
?aes
qplot(votes, rating, data = movies) + geom_smooth(se=FALSE)
