library(gstat)
data("meuse.all");data("meuse.grid")
coordinates(meuse.all) <- ~ x+y
coordinates(meuse.grid) <- ~ x+y
meuse.all$lead.i <- meuse.all$lead > 100

vi   <- variogram(lead.i ~ 1, location = meuse.all, cutoff = 1300)
vimf <- fit.variogram(vi, vgm(0.12, "Sph", 1300, 0))

preditos_kgi <- krige(lead.i ~ 1, loc=meuse.all,  newdata=meuse.grid, model=vimf)
head(preditos_kgi)