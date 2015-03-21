library(rstan)
schools_dat <- list(J = 8, 
                    y = c(28,  8, -3,  7, -1,  1, 18, 12),
                    sigma = c(15, 10, 16, 11,  9, 11, 10, 18))

fit1 <- stan(file = '8schools.stan', data = schools_dat, 
            iter = 1000, chains = 4)
fit2 <- stan(fit = fit1, data = schools_dat, iter = 10000, chains = 4)

print(fit2)
plot(fit2)

la <- extract(fit2, permuted = TRUE) # return a list of arrays 
mu <- la$mu 

### return an array of three dimensions: iterations, chains, parameters 
a <- extract(fit2, permuted = FALSE) 

### use S3 functions as.array (or as.matrix) on stanfit objects
a2 <- as.array(fit2)
m <- as.matrix(fit2)
print(fit, digits = 1)