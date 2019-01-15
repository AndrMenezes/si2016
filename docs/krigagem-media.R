bib <- c("gstat", "sp", "geoR")
sapply(bib, require, character.only = TRUE)

krigagem.media <- function(data, coords, model, pars, nug = 0){
  nr <- nrow(coords)
  cov.mat <- varcov.spatial(coords=coords, cov.model=model, cov.pars=pars, nugget = nug)$varcov
  c <- c(rep(-1,l=nr),0)
  l <- c(rep(1,l=nr))
  cov.mat <- rbind(cov.mat,l)
  cov.mat <- cbind(cov.mat,c)
  R <- matrix(c(rep(0,l=nr),1))
  wi <- (solve(cov.mat)%*%R)[-(nr+1)]
  mean.krige <- sum(data*wi)
  return(mean.krige)
}

data("meuse.all")
coordinates(meuse.all) <- ~x+y
vemp <- variogram(lead ~ 1, data=meuse.all, cressie = T)
vfit <- fit.variogram(vemp, model = vgm("Sph"), fit.method = 1)

krigagem.media(data = meuse.all$lead, coords = meuse.all@coords, model = "sph",
               pars = c(vfit$psill[2], vfit$range[2]), nug = vfit$psill[1])
mean(meuse.all$lead)
