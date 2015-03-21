modelString = "
data { 
  int < lower = 0 > N ;
  int y[ N] ; // y is a length-N vector of integers 
} 

parameters { 
  real < lower = 0, upper = 1 > theta ; 
} 

model { 
 theta ∼ beta( 1,1); 
  y ∼ bernoulli( theta); 
} " # close quote for modelString

library( rstan) 
stanDso = stan_model( model_code = modelString )

# Create some fictitious data: 
N = 50 ; z = 10 ; y = c( rep( 1, z), rep( 0, N-z))
dataList = list( y = y , N = N ) 
stanFit = sampling( object = stanDso , data = dataList , 
                    chains = 3 , iter = 1000 , warmup = 200 , thin = 1 )




