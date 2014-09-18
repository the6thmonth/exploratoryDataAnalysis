load("face.rda")
?t
?load

t(faceData)[,nrow(faceData):1]
?data.matrix

image(t(faceData)[,nrow(faceData):1])
?scale

svd1=svd(scale(faceData))
svd1$d
plot(svd1$d^2/sum(svd1$d^2), pch = 19, xlab = "Singular Vector", ylab = "Variance Explained")

?diag
##note that %*% is matrix multiplication

#Here svd1$d[1] is a constant
approx1=svd1$u[,1] %*% t(svd1$v[,1]) * svd1$d[1]
#In these approximation we need to make a diagonal matrix out of d
approx5=svd1$u[,1:5] %*% diag(svd1$d[1:5]) %*% t(svd1$v[,1:5])
approx10=svd1$u[,1:10] %*% diag(svd1$d[1:10]) %*% t(svd1$v[,1:10])

par(mfrow = c(1,4))

image(t(approx1)[, nrow(approx1):1], main="(a)")
image(t(approx5)[, nrow(approx5):1], main="(b)")
image(t(approx10)[, nrow(approx10):1], main="(c)")
image(t(faceData)[,nrow(faceData):1],main="original")

library(grDevices)
colors()
pal=colorRamp(c("red","blue"))
pal(0)
pal(0.5)
pal(seq(0,1,len=10))

pal=colorRampPalette(c("red","blue"))
pal(2)
pal(10)
