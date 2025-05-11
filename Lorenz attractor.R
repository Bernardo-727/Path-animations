install.packages("rgl")
library(rgl)

colors <- c("#ffba00","#fd558f","#fb0044","#0070c3")

lorenz <- function(x_0,y_0,z_0,t_length,dt,ro=28,sigma=10,beta=8/3,cut=200)
{
  time = seq(from=0,to = t_length,by=dt)
  
  x_pos <- vector(length = length(time)) 
  y_pos <- vector(length = length(time)) 
  z_pos <- vector(length = length(time))
  
  x_pos[1] <- x_0
  y_pos[1] <- y_0
  z_pos[1] <- z_0
  
  for(i in seq_along(time)[-1])
  {
    x_pos[i] <- x_pos[i-1] + dt*(sigma*(y_pos[i-1]-x_pos[i-1]))
    y_pos[i] <- y_pos[i-1] + dt*(x_pos[i-1]*(ro-z_pos[i-1]) - y_pos[i-1])
    z_pos[i] <- z_pos[i-1] + dt*(x_pos[i-1]*y_pos[i-1] - beta*z_pos[i-1])
  }
  results <- data.frame(x=x_pos,y=y_pos,z=z_pos,row.names = time)
  
  return(results[(seq(from=1,to=dim(results)[1],by=200)),])
}

source("Path_drawing.R")

points1 <- lorenz(8,5,3,70,0.0001)

points2 <- lorenz(3,4,3,70,0.0001)

points3 <- lorenz(5,6,2,70,0.0001)

points4 <- lorenz(6,4,3,70,0.0001)

animation <- function(s,...)
{
    plot3d(-100,xlab="",xlim=c(-28,28),ylim=c(-28,28),zlim=c(-3,53))
    bbox3d(col="#aaaaaa")
    
    drawpath(seconds=s,points1,pathcolor=colors[1],...)
    
    drawpath(seconds=s,points2,pathcolor=colors[2],...)
    
    drawpath(seconds=s,points3,pathcolor=colors[3],...)
    
    drawpath(seconds=s,points4,pathcolor=colors[4],...)
    
    return(returneveryframe())
}

open3d()
movie3d(animation,fps=25,total_lines = 1000,number_lines = 200,length=15,duration=15,type="gif",movie="slow",dir = getwd(),webshot = F)
