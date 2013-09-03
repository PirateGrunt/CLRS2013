

options(width=40)



## library(MRMR)
## ?MRMR



library(MRMR)



aDate = mdy("06-30-2012")
day(aDate) = 6
aDate + years(1)
myPeriod = months(6)
myPeriod / months(1)



aDate =mdy("1-15-2010")
someDates = aDate + months(0:11)
someDates



AccidentYear = c(2002, 2002, 2002 
               , 2003, 2003
               , 2004)

Month = c(12, 24, 36
        , 12, 24
        , 12)

Paid = c(2318,  7932, 13822
       , 1743,  6240
       , 2221)

EP = c( 61183,  61183,  61183
     ,  69175,  69175
     ,  99322)

df = data.frame(AccidentYear = AccidentYear, Month = Month, Paid = Paid, EP = EP)
head(df)



myTriangle = newTriangle(TriangleData = df
                         , OriginPeriods = AccidentYear
                         , DevelopmentLags = Month
                         , Cumulative = TRUE
                         , StochasticMeasures = c("Paid")
                         , StaticMeasures = c("EP")
                         , Verbose = FALSE)



slotNames(myTriangle)



names(myTriangle@TriangleData)



plotTriangle(myTriangle, Predictor = "DevInteger", Response = "CumulativePaid")



data(Friedland)
plotTriangle(Friedland, Predictor = "DevInteger", Response = "CumulativePaid")



plotTriangle(Friedland, Predictor = "DevInteger", Response = "IncrementalPaid")



plotTriangle(Friedland, Predictor = "EvaluationDate", Response = "IncrementalPaid")



plotTriangle(Friedland, Predictor = "PriorPaid", Response ="IncrementalPaid", Group = "DevInteger", Lines = FALSE)



plotTriangle(Friedland, Predictor = "PriorPaid", Response ="IncrementalPaid", Group = "DevInteger", Lines = FALSE, FitLines = TRUE)



plotTriangle(Friedland, Response ="IncrementalPaid", Predictor = "EP", Group = "DevInteger", Lines = FALSE, FitLines=TRUE)



PaidAM = newTriangleModel(Triangle = Friedland, Response = "IncrementalPaid", Predictor = "EP", FitCategory = "DevInteger", Tail = 6)



## plotTriangle(Friedland, Response ="IncrementalPaid", Predictor = "EP", Group = "DevInteger", Lines = FALSE, FitLines=TRUE)
## PaidAM = newTriangleModel(Friedland, Response ="IncrementalPaid", Predictor = "EP", FitCategory = "DevInteger", Tail = 6)



set.seed(1234)
N = 100
e = rnorm(N, mean = 0, sd = 1)
B0 = 5
B1 = 1.5

X1 = rep(seq(1,10),10)
Y = B0 + B1 * X1 + e

df = data.frame(Y=Y, X1=X1, e=e)



myFit = lm(Y ~ X1, data=df)



summary(myFit)



## #The 1 is not necessary
## lm(Y ~ 1 + X1, data=df)
## 
## #This is the same as above
## lm(Y ~ X1, data=df)
## 
## lm(Y ~ 0 + X1, data=df)   #No intercept
## 
## lm(Y ~ X1 + X2, data=df)  #Two predictors
## 
## #Two predictors and an interaction
## lm(Y ~ X1 + X2 + X1:X2, data=df)
## 
## #Use the operators normally
## lm(Y ~ I(X1 / X2), data=df)



## plot(df$X1, df$Y, pch=19)
## 
## # To plot the fit line we can type either this:
## abline(myFit$coefficients[[1]], myFit$coefficients[[2]])
## 
## # Or this:
## lines(df$X1, predict(myFit))



plot(df$X1, df$Y, pch=19)
abline(myFit$coefficients[[1]], myFit$coefficients[[2]])



B2 = -3.0
df$X2 = rep(seq(-20, -11), 10)
df$Y = with(df, B0 + B1 * X1 + B2 * X2)
myFit2 = lm(Y ~ X1 + X2, data=df)



df$spurious = runif(N, min=-5, max=5)
myFit3 = lm(Y ~ X1 + spurious, data=df)



dfCoef = summary(myFit)$coefficients
dfCoef



spuriousFit = lm(Y ~ spurious, data=df)
dfCoef = summary(spuriousFit)$coefficients
dfCoef



PaidCL = newTriangleModel(Friedland, Response ="IncrementalPaid", Predictor = "PriorPaid", FitCategory = "DevInteger", Tail = 6)
PaidAM = newTriangleModel(Triangle = Friedland, Response = "IncrementalPaid", Predictor = "EP", FitCategory = "DevInteger", Tail = 6)



summary(PaidCL@Fit)$coefficients[,1:2]



PlotModelFactors(PaidCL)



PlotModelFactors(PaidAM)



summary(myFit)$r.squared
summary(myFit)$fstatistic



PlotModelGoF(PaidAM)



PlotResiduals(PaidAM)



head(df)



shapiro.test(e)



## qqnorm(e)
## qqline(e)



qqnorm(e)
qqline(e)



lstFitResults = plotSerialCorrelation(PaidAM)



summary(lstFitResults$fit)$coefficients



df = Friedland@TriangleData
cy = (year(df$EvaluationDate) == 2008)
df$IncrementalPaid[cy] = df$IncrementalPaid[cy] * (2/3)

myTriangle = newTriangle(df, OriginPeriods = OriginPeriod, DevelopmentLags = DevelopmentLag
                         , StaticMeasures = "EP"
                         , StochasticMeasures = "IncrementalPaid"
                         , Cumulative = FALSE)

myModel = newTriangleModel(myTriangle, "IncrementalPaid", "EP", "DevInteger")



lstResult = FitSerialCorrelation(myModel)
summary(lstResult$fit)$coefficients



set.seed(1234)
N = 100
e = rnorm(N, mean = 0, sd = 1)
B1 = 1.5
X1 = rep(seq(1,10),10)
Y = B1 * X1 + sqrt(X1) * e

bpFit = lm(Y ~ 0 + X1)
bptest(bpFit)
coef(bpFit)



## plot(X1, residuals(bpFit), pch=19)



plot(X1, residuals(bpFit), pch=19)



alpha = seq(-10, 10,by=.05)
slope = sapply(alpha, function(x){
  w = X1 ^ x
  fit = lm(Y ~ 0 + X1, weight = w)
  coef(fit)
})
max(Y / X1)
min(Y / X1)
max(slope)
min(slope)



## plot(alpha, slope, pch = 19)



plot(alpha, slope, pch = 19)



## plot(X1, Y, pch=19)
## abline(0, min(slope), col="blue")
## abline(0, max(slope), col="blue")
## abline(0, B1, col="red")



plot(X1, Y, pch=19)
abline(0, min(slope), col="blue")
abline(0, max(slope), col="blue")
abline(0, B1, col="red")



## PaidAM0 = newTriangleModel(Friedland, Response = "IncrementalPaid", Predictor = "EP", FitCategory="DevInteger", Tail=6, Alpha=1)
## PaidAM0 = newTriangleModel(Friedland, Response = "IncrementalPaid", Predictor = "EP", FitCategory="DevInteger", Tail=6, Alpha=2)



x1 = c(10.0, 8.00, 13.00, 9.00, 11.00, 14.00, 6.00, 4.00, 12.00, 7.00, 5.00)
x3 = x2 = x1
x4 = c(8.00, 8.00, 8.00, 8.00, 8.00, 8.00, 8.00, 19.00, 8.00, 8.00, 8.00)
y1 = c(8.04, 6.95,  7.58, 8.81,  8.33,  9.96, 7.24, 4.26, 10.84, 4.82, 5.68)
y2 = c(9.14, 8.14,  8.74, 8.77,  9.26,  8.10, 6.13, 3.10,  9.13, 7.26, 4.74)
y3 = c(7.46, 6.77, 12.74, 7.11, 7.81, 8.84, 6.08, 5.39, 8.15, 6.42, 5.73)
y4 = c(6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.50, 5.56, 7.91, 6.89)



View(data.frame(x1 = x1, y1 = y1, x2=x2, y2=y2, x3=x3, y3=y3, x4=x4, y4=y4))



fit1 = lm(y1 ~ x1)
fit2 = lm(y2 ~ x2)
fit3 = lm(y3 ~ x3)
fit4 = lm(y4 ~ x4)



summary(fit1)$r.squared
summary(fit2)$r.squared
summary(fit3)$r.squared
summary(fit4)$r.squared



## op = par(mfrow = c(2,2))
## plot(y1 ~ x1, pch=19)
## abline(fit1$coefficients[[1]], fit1$coefficients[[2]])
## 
## plot(y2 ~ x2, pch=19)
## abline(fit1$coefficients[[1]], fit1$coefficients[[2]])
## 
## plot(y3 ~ x3, pch=19)
## abline(fit1$coefficients[[1]], fit1$coefficients[[2]])
## 
## plot(y4 ~ x4, pch=19)
## abline(fit1$coefficients[[1]], fit1$coefficients[[2]])
## 
## par(op)



op = par(mfrow = c(2,2))
plot(y1 ~ x1, pch=19)
abline(fit1$coefficients[[1]], fit1$coefficients[[2]])
plot(y2 ~ x2, pch=19)
abline(fit1$coefficients[[1]], fit1$coefficients[[2]])
plot(y3 ~ x3, pch=19)
abline(fit1$coefficients[[1]], fit1$coefficients[[2]])
plot(y4 ~ x4, pch=19)
abline(fit1$coefficients[[1]], fit1$coefficients[[2]])
par(op)



PlotResiduals(PaidAM)



PlotResiduals(PaidCL)



PaidAM_Projection = TriangleProjection(PaidAM, ProjectToDev = FALSE, AsOfDate = mdy("12/31/2010"))
df = PaidAM_Projection@ProjectionData



PaidAM_Projection = TriangleProjection(PaidAM, ProjectToDev = TRUE, MaxDev = 10)
df = PaidAM_Projection@ProjectionData



set.seed(1234)
N = 100
e = rnorm(N, mean = 0, sd = 1)
 
lnLike = function(x, mu, sigma)
{
  n = length(x)
  lnLike = -n / 2 * log(2*pi)
  lnLike = lnLike - n/2 * log(sigma ^2)
  lnLike = lnLike - 1/(2*sigma^2)*sum((x - mu)^2)
  lnLike
}



testMu = seq(-0.5, 0.5, length.out=100)
likelihood = sapply(testMu, lnLike, x = e, sigma = 1)
testMu[likelihood == max(likelihood)]



plot(likelihood ~ testMu, pch = 19)
abline(v = 0)
abline(v = testMu[likelihood == max(likelihood)])



testSigma = seq(.5, 1.5, length.out=100)
likelihood = sapply(testSigma, lnLike, x = e, mu = 0)
testSigma[likelihood == max(likelihood)]



plot(likelihood ~ testSigma, pch = 19)
abline(v = 1)
abline(v = testSigma[likelihood == max(likelihood)])



params = expand.grid(mu = testMu, sigma = testSigma)
params$Likelihood = mapply(lnLike, params$mu, params$sigma, MoreArgs = list(x = e))
z = matrix(params$Likelihood, length(testMu), length(testSigma))



## filled.contour(x=testMu, y=testSigma, z=z, color.palette = heat.colors, xlab = "mu", ylab = "sigma")



filled.contour(x=testMu, y=testSigma, z=z, color.palette = heat.colors, xlab = "mu", ylab = "sigma")



lnLike2 = function(x, par)
{
  mu = par[1]
  sigma = par[2]
  
  lnLike(x, mu, sigma)
}
 
optimFit = optim(par = c(-1,4), fn = lnLike2, control = list(fnscale = -1), x = e)
optimFit$par



B0 = 5
Y = B0 + e



optimFit = optim(par = c(-1,4), fn = lnLike2, control = list(fnscale = -1), x = Y)
optimFit$par[[1]]
 
lmFit = lm(Y ~ 1)
lmFit$coefficients[[1]]



X = as.double(1:length(e))
B1 = 1.5
Y = B0 + B1 * X + e
 
lnLike3 = function(par, Y, X)
{
  B0 = par[1]
  B1 = par[2]
  sigma = par[3]
  
  x = Y - B0 - B1 * X
  mu = 0
  
  lnLike(x, mu, sigma) 
}



optimFit = optim(par = c(4, 1, 1), fn = lnLike3, control = list(fnscale = -1), Y = Y, X = X)
optimFit$par[1:2]

lmFit = lm(Y ~ 1 + X)
lmFit$coefficients


