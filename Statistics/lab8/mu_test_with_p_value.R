#For case when distribution is onknown we just need to pass sd(data) to sig variable
mutest_p_value = function(avg,m0,sig,n,alpha, type, IS_NORMAL, IS_TRUE_SIGMA){
  if(IS_NORMAL & !IS_TRUE_SIGMA ){
    t = (avg-m0)/(sig/sqrt(n))
    kw = qt(1-alpha, n-1)
    kw2 = qt(1-alpha/2,n-1)
    
    if(type=="l"){
      print(paste("p value:", round(pt(t,n-1),3)))
      if( t < -kw){
        print("Reject H0")
      }else{
        print("No reason for H0 rejection")
      }
    }else if(type =="g"){
      print(paste("p value:", round(1-pt(t,n-1),3)))
      if( t > kw){
        print("Reject H0")
      }else{
        print("No reason for H0 rejection")
      }
    }else if(type =="e"){
      print(paste("p value:", round(2*pt(-abs(t),n-1),3)))
      if( (t > kw2)| t < - kw2){
        print("Reject H0")
      }else{
        print("No reason for H0 rejection")
      }
    }
  }else{
    z = (avg-m0)/(sig/sqrt(n))
    kw = qnorm(1-alpha)
    kw2 = qnorm(1-alpha/2)
    
    if(type=="l"){
      print(paste("p value:", round(pnorm(z),3)))
      if( z < -kw){
        print("Reject H0")
      }else{
        print("No reason for H0 rejection")
      }
    }else if(type =="g"){
      print(paste("p value:", round(1-pnorm(t),3)))
      if( z > kw){
        print("Reject H0")
      }else{
        print("No reason for H0 rejection")
      }
    }else if(type == "e"){
      print(paste("p value:", round(2*pnorm(-abs(t)),3)))
      if( (z > kw2)| z < - kw2){
        print("Reject H0")
      }else{
        print("No reason for H0 rejection")
      }
    }
  }
}