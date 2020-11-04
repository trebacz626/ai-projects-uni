#Task 1
print(sin(2*pi))
print(cos(3/4))
print(tan(pi))
log(15, base=exp(1))
log(exp(4), base =exp(1))
#Task 2



#Task 3
x = seq(2,20, length=10)
#a)
print(x*x)

print(x^2)
#b
print(rev(x))
print(sort(x, decreasing = TRUE))
#c
print(sum(x))
#d
print(norm(x,type="2"))
print(sqrt(sum(x^2)))
#Task 4
y = seq(5,10,length=13)
norm(y,type="2")
#Task 5
z1 = rep (c(1,2), times=5)
z2 = rep(c(1,2),each=5)
z1
z2
#Task 6
a=c(1,3,6,2,7,4)
min(a)
match(min(a),a)
which(a<=4)
sum(a)
sum(a^2)
norm(a, type="2")
a[3]
a+4
b = a[-4]
b
c=a+b
d= a[a>=4]
d
#Task 7
x = c(2,1,-1)
y = c(3,2,1)
z = c(0,1,1)
A = matrix(c(x,y,z), nrow = 3)
A
det(A)
