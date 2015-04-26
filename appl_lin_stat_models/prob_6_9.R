library(rstan)
library(ggplot2)

### Data

data_df <- read.table("appl_lin_stat_models/CH06PR09.txt", header=TRUE, quote="\"")
   
hours = data_df$hours
cases = data_df$cases
costs_labor = data_df$costs_labor
holiday_ind = data_df$holiday_ind
N=length(hours)
data.list <- c("N", "hours", "cases", "costs_labor", "holiday_ind")
posterior_st = stan(file='appl_lin_stat_models/prob_6_9.stan', data=data.list, warmup=1000, iter=10000, chains=4)
print(posterior_st, pars = c("beta", "sigma"))
beta.post <- extract(posterior_st, "beta")$beta
beta.mean = colMeans(beta.post)
#Y_hat
#beta.mean[1] + beta.mean[2] * 5
library(shinyStan)
launch_shinystan(posterior_st)
