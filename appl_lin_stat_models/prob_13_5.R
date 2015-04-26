library(rstan)
library(ggplot2)

### Data

data_df <- read.table("appl_lin_stat_models/CH13PR05.txt", header=TRUE, quote="\"")
City = data_df$City
#standardize price
data_df$Price = scale(data_df$Price)
City1_Price = data_df$Price[City==1]
City1_Prop_Purch = data_df$Prop_Purch[City==1]
City2_Price = data_df$Price[City==2]
City2_Prop_Purch = data_df$Prop_Purch[City==2]
N1=length(City[City==1])
N2=length(City[City==2])
data.list <- c("N1", "N2", "City1_Price", "City1_Prop_Purch", "City2_Price", "City2_Prop_Purch")

library(snow)
B_array = 1:4
run_remote_stan = function(i, data.list=data.list, City1_Price, City1_Prop_Purch, City2_Price, City2_Prop_Purch, N1, N2){
  library(rstan)
  
  return(stan(file='D:/Google Drive/R/rstan/appl_lin_stat_models/prob_13_5.stan', data=data.list, iter=10000, chains=1))
  #return(stan(file='/Users/edwa6643/Google Drive/R/rstan/appl_lin_stat_models/prob_13_5.stan', data=data.list, iter=10000, chains=1))
}
cl <- makeSOCKcluster(c("localhost","localhost","localhost","localhost"))

stan_chains = clusterApply(cl, B_array, run_remote_stan, 
                           data.list=data.list, 
                           City1_Price=City1_Price, 
                           City1_Prop_Purch=City1_Prop_Purch,
                           City2_Price=City2_Price,
                           City2_Prop_Purch=City2_Prop_Purch,
                           N1=N1,
                           N2=N2)
stopCluster(cl)
stan_model_post =  sflist2stanfit(stan_chains)
#print(copier_minutes_st, pars = c("gamma", "sigma"))
#beta.post <- extract(copier_minutes_st, "gamma")$gamma
#beta.mean = colMeans(gamma.post)
#Y_hat
library(shinyStan)
launch_shinystan(stan_model_post)

#1537949388
#.. .. ..$ gamma: num [1:3(1d)] -0.244 0.176 1.756
#.. .. ..$ sigma: num 0.558
#1687766192
