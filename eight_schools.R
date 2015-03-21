# from http://rstudio-pubs-static.s3.amazonaws.com/15236_9bc0cd0966924b139c5162d7d61a2436.html


require(igraph)

gr<-graph.formula("N(0,0.01)"-+"mu",
                  "mu"-+"N(0,1/tau)", 
                  "N(0,1/tau)"-+"m1", 
                  "N(0,1/tau)"-+"m2", 
                  "N(0,1/tau)"-+"m8",
                  "m1"-+"N(0,1/sigma21)", 
                  "m2"-+"N(0,1/sigma22)",
                  "m8"-+"N(0,1/sigma28)", 
                  "N(0,1/sigma21)"-+"y1",
                  "N(0,1/sigma22)"-+"y2",  
                  "N(0,1/sigma28)"-+"y8")


lo<-data.frame(x=c(2,2,2,1,2,3,1,2,3,1,2,3),y=c(6,5,4,3,3,3,2,2,2,1,1,1))
plot(gr, 
     layout=layout.reingold.tilford(gr), 
     edge.arrow.size=.25
)

sigma     <- c(15,10,16,11, 9,11,10,18)
schoolobs <- c(28,8, -3, 7,-1, 1,18,12)
inits <- function() { list(mu = rnorm(0,.1))}
model.sat.text<-"
  model {
    for(i in 1:N) {
    schoolmean[i] ~ dnorm(mu,itau)
    thes[i] <- 1/pow(sigma[i],2)
    schoolobs[i] ~ dnorm(schoolmean[i],thes[i])
    }
 
  mu ~ dnorm(0,alpha)
  alpha <- .01
  itau   ~ dgamma(1e-3,pow(15,2)*1e-3)
  tau <- pow(1/itau,1/2)
}
"

model.sat.spec<-textConnection(model.sat.text)

sat.jags <- jags.model(model.sat.spec,
                       inits=inits,
                       n.chains=5,
                       data=list('sigma'=sigma,
                                 'schoolobs'=schoolobs,
                                 'N'=length(schoolobs)
                       ),
                       n.adapt = 1000)

#same thing but return a coda MCMC object
samps.coda <- coda.samples(sat.jags,
                           c('mu','tau', 'schoolmean'),
                           n.iter=10000,
                           thin=10
)

head(samps.coda)

summary(samps.coda)

plot(samps.coda[[1]][,c("mu","tau")])

plot(samps.coda[[1]][,2:5])