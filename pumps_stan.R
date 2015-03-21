library(rstan)  
pumps_dat <- list(t = c(94.3, 15.7, 62.9, 126, 5.24, 31.4, 1.05, 1.05, 2.1, 10.5),
                  x = c(5,1,5,14,3,19,1,1,4,22), N = 10)
pumps_fit <- stan(file = 'pumps.stan', data = pumps_dat)


plot(pumps_fit)
