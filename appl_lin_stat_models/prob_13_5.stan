data {
  int<lower=0> N1;
  int<lower=0> N2;
  vector[N1] City1_Price;
  vector[N2] City2_Price;
  vector[N1] City1_Prop_Purch;
  vector[N2] City2_Prop_Purch;
}

parameters {
    vector[3] gamma;
    real<lower=0> sigma;
}

model {
  City1_Prop_Purch ~ normal(gamma[1] + gamma[3] * exp(-gamma[2]*City1_Price), sigma);
  City2_Prop_Purch ~ normal(gamma[1] + gamma[3] * exp(-gamma[2]*City2_Price), sigma);

}