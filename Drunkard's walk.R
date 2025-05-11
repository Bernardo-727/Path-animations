library(rgl)

source("Path_drawing.R")

rademacher <- function()
{
  #rademacher distribution, 50% it's -1, 50% it's 1
  return(sample(c(-1,1),size=1))
}

walk <- function(d,df,time)
{
  #d is the number of dimensions
  #df is the dataframe
  #time is "the present" when we are making the walk
  
  #randomly chooses one of the "d" dimensions to walk.
  axis <- sample(1:d,replace = T,size=1)
  # walks one step in the positive or one in the negatives
  direction <- rademacher()
  df[time+1,-axis] <- df[time,-axis]
  df[time+1,axis] <- df[time,axis] + direction
  return(df)
}
drunkard <- function(n,dim)
{
  # n is the number of iterations of the walk that he will do
  # dim is the number of dimensions
  position <- data.frame(x=numeric(n),y=numeric(n),z=numeric(n))
  # the vector length somehow applies to y and z too,
  # making them repeating 0 "n" times 
  for(k in 1:(n-1))
   position <- walk(d=dim,df=position,time=k)
  
  return(position)
}

set.seed(727)
random3dwalk <- drunkard(200,3)

animation2 <- function(s,...)
{
  plot3d(-100,xlab="",xlim=c(-2,18),ylim=c(-3,12),zlim=c(-12,2))
  bbox3d(col="#dddddd")
  
  drawpath(seconds=s,random3dwalk,pathcolor="#ac3331",...)
  
  return(returneveryframe())
}

open3d()
movie3d(animation2,fps=10,total_lines = 200,number_lines = 10,length=15,duration=15,type="gif",movie="Random walk",dir = getwd(),webshot = F)

