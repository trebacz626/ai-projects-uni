library(arm)
library(TeachingDemos)
library(BSDA)

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