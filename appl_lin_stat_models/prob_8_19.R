library(rstan)
library(ggplot2)

### Data

data_1_20 <- read.table("appl_lin_stat_models/data_1_20.txt", header=TRUE, quote="\"")
mins_repair = data_1_20$mins_repair
num_copiers = data_1_20$num_copiers
N=length(mins_repair)
data.list <- c("N", "mins_repair", "num_copiers")
copier_minutes_st = stan(file='appl_lin_stat_models/prob_1_20.stan', data=data.list, iter=10000, chains=4)
print(copier_minutes_st, pars = c("beta", "sigma"))
beta.post <- extract(copier_minutes_st, "beta")$beta
beta.mean = colMeans(beta.post)
#Y_hat
beta.mean[1] + beta.mean[2] * 5
library(shinyStan)
launch_shinystan(copier_minutes_st)
