library(arm)
library(TeachingDemos)
library(BSDA)
library(PairedData)
library()
#EX FROM TABLE
table = data.frame(c(0:3),c(16*15*14/20/19/18, 16*15*4/20/19/18*3, 16*4*3/20/19/18*3,4*3*2/20/19/18))
print(table)
eX = sum(table[,1]*table[,2])
eX2 = sum(table[,1]^2*table[,2])


#Plotting
par(mfrow = c(2,3))
par(mfrow = c(1,1))
#Histogram all data
for(column in 1:2){
  hist(data2[,column], xlim = c(0,150), xlab="Crops", breaks = seq(0,150,length=7), main=paste("Year",names(data2[column])), col=column+1, freq = FALSE)
}

#pie
pie(table(data))

discrete.hist(data, , xlim=c(0,n))
plot(x, dbinom(x,n,p), type="h", xlim=c(0,n))
plot(x, dpois(x,n*p), type="h", xlim=c(0,n))

plot(x,dbinom(x,n,p), col = "red", xlim=c(0,n))
curve(dnorm(x,n*p,sqrt(n*p*(1-p))), xlim=c(0,n), add=TRUE)
hist(data, freq=FALSE, add = TRUE, xlim=c(0,n))


hist(means,freq=FALSE, xlim=c(lambda-5*sd,lambda+5*sd))
curve(dnorm(x,lambda,sd), add=TRUE, xlim = c(lambda-5*sd,lambda+5*sd))

#Tests- own functions
#normal not known sd
conf_int = function(M,S,n, alpha){
  c(M-qt(1-alpha/2, n-1)*S/sqrt(n), M +qt(1-alpha/2,n-1)*S/sqrt(n))
}
#normal known sd
myInterval = function(n,M,S,alpha){
  span = qnorm(1-alpha/2)*S/sqrt(n)
  c(M-span,M+span)
}

#not normal large sample
myInterval = function(n,M,S,alpha){
  span = qnorm(1-alpha/2)*S/sqrt(n)
  c(M-span,M+span)
}

#variance
varianceInterval = function(n,M,S,alpha){
  left = (n-1)*S^2/qchisq(1-alpha/2,n-1)
  right = (n-1)*S^2/qchisq(alpha/2,n-1)
  c(left,right)
}


#Tests built in

#normal not known sd
t.test(milk, conf.level = 1-alpha)$conf.int

#normal known sd
z.test(cigarettes, sigma.x = 0.7, conf.level = 1-alpha)$conf.int

#not normal
zsum.test(M,S,n, conf.level = 1-alpha)$conf.int

#sigma
interval = sigma.test(diamonds, conf.level =1-alpha)$conf.int
#variance
print(c(sqrt(interval[1]),sqrt(interval[2])))

#prob
prop.test(no. of successes, sample size,
          conf.level=1-
          , correct=FALSE)
binom.test(T, n, conf.level = 0.99)
#################
#size of sample to be 1-alpha percent sure if error (sd) is equal ...
#n>=...
S = 5
alpha = 0.05
error = 1
(qnorm(1-alpha/2)*S/error)^2

#for probability
alpha =0.02
total_length=0.05
p = 0.5

(qnorm(1-alpha/2)*sqrt((1-p)*p)/ total_length)^2

p=0.3
(qnorm(1-alpha/2)*sqrt((1-p)*p)/ total_length)^2

#variability index

v =  s/M· 100%

0 – 20% – weak variability of the data
20 – 40% – medium variability of the data
40 – 60% – strong variability of the data
over 60% – very strong variability of the data


#Hypothesis testing

#mean
#normal not known sd
t.test(cur_data,alternative = "greater"|"less"|"two.sided", mu= mu0)
#normal known sd
z.test(cur_data,sigma.x = 0.7, alternative = "greater"|"less"|"two.sided", mu= mu0)
#not normal
zsum.test(mean(cur_data), sd(cur_data),length(cur_data), alternative=alternative, mu = mu0,conf.level=1-alpha)

#sigma test
sigma.test(cur_data, sigma =sig, alternative = alternative)

#TWO POPULATIONS
v1 = na.omit(data$cellulose1)
v2 = na.omit(data$cellulose2)

res = var.test(v1, v2);

#var equals
t.test(v1, v2, var.equal = TRUE, alternative = "greater"|"less"|"two.sided")
#confidence interval t.test(v1, v2, var.equal = TRUE, conf.level = 1-a)

#var different
t.test(v1, v2, var.equal = FALSE, alternative = "greater"|"less"|"two.sided")


#VARIANCE TEST
var.test(player1, player2, alternative = "less")

#PROPORTION 
prop.test(c(polishT, usaT), c(polishN,usaN), conf.level = 1- 0.1)
prop.test(c(polishT, usaT), c(polishN,usaN),alternative = "less")

# ONE POPULATION 2D
difference = pH100 - pH15
t.test(difference, mu = 0, alternative = "two.sided")

#ANOVA TABLE
samples = 5

names(data)
treatments = rep(names(data), each=6)

results = c(na.omit(data$NonSmokers),na.omit(data$LightSmokers), na.omit(data$MediumSmokers), na.omit(data$HeavySmokers))

#ehuality of variance
bartlett.test(results~treatments)

model=lm(results~treatments) 
anova(model)

TukeyHSD(aov(results~treatments), ordered=TRUE, conf.level = 1-alpha)

#LINEAR MODELS
X = data$X
Y = data$Y

cov(X,Y)
#b
cor(X,Y)

#c
plot(X,Y)

#d
linear_model = lm(Y~X)

b0 = linear_model$coefficients[1]
b1 = linear_model$coefficients[2]

#fg
predict(linear_model,data.frame(X=c(15,20)))

#R=
cor(X,Y)^2

summary(linear_model)

anova(linear_model)

#MORE COMPLEX
lm(Y~X+I(X^2)+I(X^3)+I(log(X)))

predict(square_model, data.frame(X=5.5))# OR X=c(5,4,3)

#CHI2 distribution comparison

expected = c(0.38, 0.32, 0.23, 0.07)
observed = c(122, 85, 76, 17)

alpha = 0.1

#H0 observed values have distribution as expected
#H1 not

chisq.test(observed, p=expected)

forit = c(96,96,90,36)
against = c(201, 189, 195, 234)
noknow = c(3, 15, 15, 30)

dataFrame = data.frame(forit, against, noknow)


# H0 opinion does not depent on age/data independent
# H1 opinion depends on age

alpha = 0.05

chisq.test(dataFrame)
#p_value < alpha so we can reject H0
# On significance level 5% data confirms that opinion depends on age 