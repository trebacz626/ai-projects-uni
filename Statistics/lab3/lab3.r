#Task 1
table =data.frame(c(-5,-2,0,1,3,8), c(0.1,0.2,0.1,0.2,0.3,0.1))
table

cdf = function(tab, e){
  s=0
  for( i in 1:length(tab[,2])){
    if(tab[,1][i] <= e){
      s = s + tab[,2][i]
    }
  }
  s
}

cdf(table, 2)

sum(table[,1]*table[,2])
sqrt(sum(table[,1]^2*table[,2]) - sum(table[,1]*table[,2])^2)


#Task 2
probs = function(n,p){
  elements = 1:n
  v=c()
  for(i in 1:n-1){
    v=c(v,(p)*(1-p)^(elements[i]-1))
  }
  v = c(v,v[n-1]*(1-p)/p)
  rbind(elements,v)
}
table2= probs(4, 1/4)
table2
sum(table2[2,])

sum(table2[1,]*table2[2,])
sqrt(sum(table2[1,]^2*table2[2,]) - sum(table2[1,]*table2[2,])^2)


sum(dbinom(0:5, size=5, p=0.3))

pbinom(3,5,0.3)-pbinom(2.999,5,0.3)

#Task 3
D = choose(120,2)
table3 = data.frame(c(0,1,2), c(choose(110,2)/D, 110*10/D, choose(10,2)/D))
table3
sum(table3[,2])
sum(table3[,1]*table3[,2])
sqrt(sum(table3[,1]^2*table3[,2]) - sum(table3[,1]*table3[,2])^2)

probEandSD = function(localTable){
  print(sum(localTable[,2]))
  print(sum(localTable[,1]*localTable[,2]))
  print(sqrt(sum(localTable[,1]^2*localTable[,2]) - sum(localTable[,1]*localTable[,2])^2))
}
#Task 4
dbinom(3,5,0.3)
1 - pbinom(2,5,0.3)
pbinom(2,5,0.3)

#Task 5
task5 = function(){
  print(dbinom(8,8,0.9))
  print(dbinom(7,8,0.9))
  print(1 -pbinom(5,8,0.9))
  v=c()
  for(i in 0:8){
    v=c(v,dbinom(i,8,0.9))
  }
  table = data.frame(c(0:8),v)
  probEandSD(table)
}
task5()


#Task 6
task6 = function(n,p = 0.1){
  print(paste("n:",n,"p:",p))
  elements = c(0:n)
  #a binomial
  print(paste("Binom:",pbinom(3,n,0.1)))
  print(paste("Poison", ppois(3, n*p)))
}
task6(10)
for(i in c(20,30,40,100)){
  task6(i)
}
for(p in seq(0.1,0.9,by=0.1)){
  task6(40,p)
}
#the difference increases

#Task 7
task7 = function(){
  n=100
  p=0.05
  print(1 -pbinom(2,n,p))
  print(1 - ppois(2,n*p))
}
task7()


#Task 8
task8 = function(){
  n = 3
  p = 0.2
  table = data.frame(c(0:3),c(16*15*14/20/19/18, 16*15*4/20/19/18*3, 16*4*3/20/19/18*3,4*3*2/20/19/18))
  print(table)
  eX = sum(table[,1]*table[,2])
  eX2 = sum(table[,1]^2*table[,2])
  #C = E(3X^2 + X)
  print(3*eX2 + eX)
}
task8()
