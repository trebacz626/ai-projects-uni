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



elements = c(1,2,3,4)

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
