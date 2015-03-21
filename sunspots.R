library(rjags)
model.text<-"model {
  # AR(1):
# prior for epsilon 1
  eps[1] ~ dnorm(0, 0.0001) 
#definition for starting point.
  m_[1] <- y[1] - eps[1] 
  for (t in 1:n) {
    y[t] ~ dnorm(m_[t], tau)
    yr[t] <- 1769 + t # baseline
  }
  for (t in 2:n) {
    m_[t] <- ct + theta*y[t-1]
    eps[t] <- y[t] - m_[t] # AR(1) model
  }
  theta ~ dnorm(0, 0.0001)
  ct ~ dnorm(0, 0.0001) # ct is c in her notes, the intercept
  tau <- 1/pow(sigma, 2)
  sigma ~ dunif(0, 100) # typical to put prior on sigma, since it's in terms of the data and is easier to think about.
}"

  init = function(){list(ct = 50, theta = 0, sigma = 10)}
y = c(100.8, 81.6, 66.5, 34.8, 30.6, 7, 19.8, 92.5,
      154.4, 125.9, 84.8, 68.1, 38.5, 22.8, 10.2, 24.1, 82.9,
      132, 130.9, 118.1, 89.9, 66.6, 60, 46.9, 41, 21.3, 16,
      6.4, 4.1, 6.8, 14.5, 34, 45, 43.1, 47.5, 42.2, 28.1, 10.1,
      8.1, 2.5, 0, 1.4, 5, 12.2, 13.9, 35.4, 45.8, 41.1, 30.4,
      23.9, 15.7, 6.6, 4, 1.8, 8.5, 16.6, 36.3, 49.7, 62.5, 67,
      71, 47.8, 27.5, 8.5, 13.2, 56.9, 121.5, 138.3, 103.2,
      85.8, 63.2, 36.8, 24.2, 10.7, 15, 40.1, 61.5, 98.5, 124.3,
      95.9, 66.5, 64.5, 54.2, 39, 20.6, 6.7, 4.3, 22.8, 54.8,
      93.8, 95.7, 77.2, 59.1, 44, 47, 30.5, 16.3, 7.3, 37.3,
      73.9)
  data <- list(n = 100, y = y)
j_model = textConnection( model.text)

jagsModel = jags.model( 
  file =j_model, 
  data = data, 
  n.adapt = 500,
  n.chains=1)

#ARMA(2,1)
model.2.text<-"model {
  # ARMA(2,1):
  for (t in 1:n) {
    y[t] ~ dnorm(m[t], tau)
    yr[t] <- 1769 + t
  }
  for (t in 3:n) {
    m[t] <- c + theta[1]*y[t-1] + theta[2]*y[t-2] # now 2 terms for AR
    + phi*eps[t-1] # 1 term for MA
    eps[t] <- y[t] - m[t]
  }
  model fit: m
  1750.0 1775.0 1800.0 1825.0 1850.0
  0.0
  50.0
  100.0
  150.0
  200.0
  m[1] <- y[1] - eps[1]
  m[2] <- y[2] - eps[2]
  eps[1] ~ dnorm(0, 0.0001)
  eps[2] ~ dnorm(0, 0.0001)
  for (i in 1:2) {
    theta[i] ~ dnorm(0, 0.0001)
  }
  phi ~ dnorm(0, 0.0001)
  c ~ dnorm(0, 0.0001)
  tau <- 1/pow(sigma, 2)
  sigma ~ dunif(0, 100)
}"