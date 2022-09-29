# Species Distribution Modelling

# install.packages("sdm")
# install.packages("rgdal", dependencies=T)
# High-performance and Parellel Computing with R by Dirk Eddelbuettel 2022-06-09  
# cran Highperformancecomputing  



library(sdm)
library(raster) # predictors
library(rgdal) # species
library(knitr)
library(here)

# rgdal.org

file <- system.file("external/species.shp", package="sdm") 
species <- shapefile(file)


# shapefile() -------------------------------------------------------------
# raster package 



# looking at the set
file ## Path to shp

species  ## UTM zone 30  https://www.dmap.co.uk/utmworld.htm 

# plot
plot(species)

## pch in R https://r-lang.com/pch-in-r/#:~:text=The%20pch%20in%20R%20defines,in%20symbols%20(or%20shapes). 

plot(species, pch = 19, cex = 0.7)

# looking at the occurrences
species$Occurrence

pres <- species[species$Occurrence == 1,] 
abse <- species[species$Occurrence == 0,]

# copy and then write:
plot(species[species$Occurrence == 1,],col='blue',pch=16)
points(species[species$Occurrence == 0,],col='red',pch=16)


# predictors --------------------------------------------------------------



# predictors: look at the path

# system.file function https://www.rdocumentation.org/packages/devtools/versions/1.13.6/topics/system.file 
path <- system.file("external", package="sdm") 


# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) #
lst

# stack
preds <- stack(lst)

# plot preds
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# plot predictors and occurrences
plot(preds$elevation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$temperature, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$precipitation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

plot(preds$vegetation, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# model

# set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)

# model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")

# make the raster output layer
p1 <- predict(m1, newdata=preds) 

# plot the output
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# add to the stack
s1 <- stack(preds,p1)
plot(s1, col=cl)

# Do you want to change names in the plot of the stack?
# Here your are!:
# choose a vector of names for the stack, looking at the previous graph, qhich are:
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
# and then replot!:
plot(s1, col=cl)
# you are done, with one line of code (as usual!)

s1$model
