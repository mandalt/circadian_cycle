library(MASS)
df2<- read.csv('nrld_m7x.csv')

time_points <- 16
size_param <- rep(NA, time_points)
mu_param <- rep(NA, time_points)
coeff_var <- rep(NA, time_points)

for (i in 1:time_points){
  ser <- df2[i,2:length(df2[i,])]
  ser <- as.numeric(ser)
  hist(ser, breaks=20, probability = T, main = c('bmal at', 3*i, 'hour'))
  ff <- fitdistr(ser, "Negative Binomial")
  size_param[i] <- ff$estimate[1]
  mu_param[i] <- ff$estimate[2]
  coeff_var[i] <- sd(ser)/mu_param[i]
  lines(seq(0,1500,1), y = dnbinom(seq(0,1500,1), size =  ff$estimate[1],mu = ff$estimate[2]), col = 'red')
}
t<- 1:16*3
plot(t,mu_param, type = 'o', main = 'mean of nbiom of Bmal1 mRNA')
coeff_var
mu_param
#at_0_bmal <- df2[29,2:length(df2[29,])]
#at_29_nrld <- as.numeric(at_29_nrld)
#hist(at_29_nrld, breaks = 20, probability = TRUE)
#lines(density(anton))

# NBd_LLL <- function(x,par) {
#   return(-sum(log(dnbinom(x,size = par[0], prob = par[1]))))
# }
# q1c = optim(par = c(0.85,0.35), NBd_LLL, x = anton, method = "L-BFGS-B", lower = c(0.1,0.1), upper = c(1,1))

#ff <- fitdistr(at_17_nrld, "Negative Binomial")
#ff$estimate[1]
#ff$estimate[2]

#lines(seq(5,100,1), y = dnbinom(seq(5,100,1), size =  ff$estimate[1],mu = ff$estimate[2]))
