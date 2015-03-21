data {
  int<lower=0> n; 
  real<lower=0> y[n];
}
transformed data {

  real yr[n];
  for (t in 1:n) {
    yr[t] <- 1769 + t ;
  }
}
parameters {
  real theta; 
  real sigma;
  real c;
}
transformed parameters {
  real m_[n];
  m_[1] <- y[1] - m_[1];

  for (t in 2:n) {
    m_[t] <- c + theta*y[t-1];
 }
}


model {
  //real eps[n];
  //eps[1] ~ normal(0, 100) ;
  y ~ normal(m_, sigma); 
  //make 0 for debugging
  //y ~ normal(0, sigma);
  
  //  eps[t] <- y[t] - m_[t]; # AR(1) model
 
  theta ~ normal(0, 100);
  c ~ normal(0, 100); 
  sigma ~ uniform(0, 10);
}