data {
  int<lower=0> N; 
  real t[N];
  int<lower=0> x[N];
}
parameters {
  real<lower=0> alpha; 
  real<lower=0> beta;
  real<lower=0> theta[N];
}


model {
   alpha ~ exponential(1);
   beta ~ gamma(0.1,1.0);
   for (n in 1:N)
   {
       //print("t then theta")
       //print(t[n])
       //print(theta[n])
       //print(theta[n] * t[n])
       theta[n] ~ gamma(alpha, beta);
       x[n] ~ poisson(theta[n] * t[n]);
   }
}