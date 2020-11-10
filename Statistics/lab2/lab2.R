library(scales)
set.seed(145455)
basicStats = function(r){
  print("Mean")
  print(mean(r1))
  print("Min")
  print(min(r))
  print("Max")
  print(max(r))
  print("Variability")
  print(var(r))
  print("Standard Deviation")
  print(sd(r))
  print("Variability Index")
  print(percent(sd(r)/mean(r)))
  print("Quartiles")
  print(quantile(r))
  print("Quantiles")
  print(quantile(r,c(0.1,0.3,0.6,0.9)))
}
r1 = rbinom(20, 10, 0.3)
r2 = rbinom(20, 10, 0.3)
#a
basicStats(r1)
basicStats(r2)

basicStats(c(r1,r2))


#Task 2
r21 = r1[1:8]
r22 = r2[1:8]
r23 = c('a','b','c','d','e','f','g','h')
m1 = cbind(r21,r22,r23)
m1
d1 = data.frame(r21,r22,r23)
basicStats(d1[,1])
basicStats(d1[,2])

#Task 3
r4 = c(1,2,3)
m1 = cbind(r1, r2, r4)
m1

#Task 4
data = read.csv("./flights.csv", sep=";")

class(data)

summary(data)

for (column in data){
  print(column)
  basicStats(column)
}
breaks = seq(200,700, length=6)
hist(data$X1955, xlim = c(200,400), xlab="Number of Passengers", breaks = breaks, main="Year 1955")

par(mfrow = c(2,3))
par(mfrow = c(1,1))

for(column in 1:6){
  hist(data[,column], xlim = c(200,700), xlab="Number of Passengers", breaks = breaks, main=paste("Year",names(data[column])), col=column+1, freq = FALSE)
}

boxplot(data)


data2 =read.csv("strawberries.csv", sep=";", dec = ',')
data2
summary(data2)
for (column in 1:2){
  print(paste("Column:::::::::::::::::", names(data2[column])))
  basicStats(na.omit(data2[,column]))
}

par(mfrow = c(1,2))
for(column in 1:2){
  hist(data2[,column], xlim = c(0,150), xlab="Crops", breaks = seq(0,150,length=7), main=paste("Year",names(data2[column])), col=column+1, freq = FALSE)
}
library(arm)

notes = read.csv("notes.csv", sep=";",head=TRUE, dec=",")
notes[,1]

par(mfrow=(c(2,2)))
for(i in 1:4){
  interval=seq(1,5,length=1)
  discrete.hist(notes[,i],main=paste("histogram of",names(notes)[i]))
}
