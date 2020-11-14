toeplitzMatrix = function(firstRow){
  rows = c(firstRow)
  lastRaw = c(firstRow)
  for(i in 1:(length(firstRow)-1)){
    print(i)
    lastRaw = c(lastRaw[length(lastRaw)],lastRaw[1:length(lastRaw)-1])
    rows = c(rows,lastRaw)
    print(rows)
  }
  print(rows)
  print(length((firstRow)))
  matrix(rows, ncol=length(firstRow), byrow=TRUE)
}

toeplitzMatrix(c(0,1,2,3,4,5))
