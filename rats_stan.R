library(rstan)  
y <- read.table('rats.txt', header = TRUE)
x <- c(8, 15, 22, 29, 36)
rats_dat <- list(N = nrow(y), T = ncol(y), 
                 x = x, y = y, xbar = mean(x))
rats_fit <- stan(file = 'rats.stan', data = rats_dat, verbose = FALSE)


