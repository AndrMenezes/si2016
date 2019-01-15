library(gstat)

data("meuse.all")
data("meuse.grid")
coordinates(meuse.all)  <- ~ x + y
coordinates(meuse.grid) <- ~ x + y

preditos_kgo <- krige(lead ~ 1, meuse.all, meuse.grid, model=vfit)
head(preditos_kgo)
