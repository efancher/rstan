data {
  int<lower=0> N;
  vector[N] hours;
  vector[N] cases;
  vector[N] costs_labor;
  vector[N] holiday_ind;
}

parameters {
    vector[4] beta;
    real<lower=0> sigma;
}

model {
  hours ~ normal(beta[1] + beta[2] * cases + beta[3] * costs_labor + beta[4] * holiday_ind, sigma);
}