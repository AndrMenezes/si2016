library(gstat)

data("meuse.all")
data("meuse.all")
coordinates(meuse.all)  <- ~ x + y
coordinates(meuse.grid) <- ~ x + y

mu <- mean(meuse.all@data$zinc)
preditos_kgs <- krige(lead ~ 1, meuse.all, meuse.grid, model=vfit, beta=mu)
head(preditos_kgs)