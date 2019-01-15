library(gstat)
data("meuse.all");data("meuse.grid")
coordinates(meuse.all) <- ~ x+y
coordinates(meuse.grid) <- ~ x+y

vi   <- variogram(lead.i ~ x + y, location = meuse.all, cutoff = 1300)
vimf <- fit.variogram(vi, model = vgm(c("Exp", "Sph", "Gau"))) 

preditos_kgu <- krige(lead ~ x + y, loc=meuse.all,  newdata=meuse.grid, model=vimf)
head(preditos_kgu)