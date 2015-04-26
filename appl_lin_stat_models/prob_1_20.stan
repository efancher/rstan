data {
  int<lower=0> N;
  vector[N] num_copiers;
  vector[N] mins_repair;
}

parameters {
    vector[2] beta;
    real<lower=0> sigma;
}

model {
  mins_repair ~ normal(beta[1] + beta[2] * num_copiers, sigma);

}