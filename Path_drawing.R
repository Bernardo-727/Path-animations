returneveryframe <- function()
{
  return(list(viewport=c(0,0,600,600),windowRect=c(800,300,1400,800),userMatrix=rotate3d(par3d()$userMatrix,0.02,0,0,1)))
}

drawpath <- function(seconds,pos_df,pathcolor,number_lines,total_lines,length)
{
  i <- seconds*total_lines/length
  interval <- c(max(1,i-number_lines):i)
  
  lines3d(x=pos_df$x[interval],y=pos_df$y[interval],z=pos_df$z[interval],col=pathcolor,lwd=2,alpha=c(1:(number_lines-1))/(number_lines-1))
  points3d(x=pos_df$x[i],y=pos_df$y[i],z=pos_df$z[i],col="white",size=6)
}