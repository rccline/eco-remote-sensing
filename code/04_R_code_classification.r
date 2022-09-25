library(raster)
library(RStoolbox)
library(here)
##%######################################################%##
#                                                          #
####         Unsupervised clustering of Raster          ####
####            data using kmeans clustering            ####
####                 RStoolbox 0.3.0                    ####
####     unsuperClass:  Unsupervised classification     ####
#                                                          #
##%######################################################%##

### https://www.rdocumentation.org/packages/RStoolbox/versions/0.3.0  


# setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

# data import
so <- brick(here("lab/data/Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")) 

### Black = low energy; yellow = high energy 

so

plotRGB(so, 1, 2, 3, stretch="lin")
plotRGB(so, 1, 2, 3, stretch="hist")

# Classifying the solar data 
soc <- unsuperClass(so, nClasses=3)

soc

soc$map

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soc$map, col=cl)

# set.seed can be used for repeating the experiment in the same manner for N times
# http://rfunction.com/archives/62 

#### 

# day 2 Grand Canyon

gc <- brick("lab/data/dolansprings_oli_2013088_canyon_lrg.jpg")
gc

# rosso = 1
# verde = 2
# blu = 3

plotRGB(gc, r=1, g=2, b=3, stretch="lin")

# change the stretch to histogram stretching
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# classification
gcclass2 <- unsuperClass(gc, nClasses=2)
gcclass2

plot(gcclass2$map)
dev.off()

set.seed(17)

plot(gcclass2$map)



# classifiy with 4 classes ->  add 4 classes to the colorRampPalet --------


# Exercise: classify the map with 4 classes
set.seed(17)
gcclass4 <- unsuperClass(gc, nClasses=4)
gcclass4



clc <- colorRampPalette(c('yellow','red','blue','black'))(100)
plot(gcclass4$map, col=clc)

# compare the classified map with the original set
par(mfrow=c(2,1))
plot(gcclass4$map, col=clc)
plotRGB(gc, r=1, g=2, b=3, stretch="hist")



# Supervised Classification for classification and regression mode  --------
# Points and polygons  

## https://rdrr.io/cran/RStoolbox/man/superClass.html
## https://www.rdocumentation.org/packages/RStoolbox/versions/0.3.0

## You can choose the training set
## Use random forest  that makes heirarchy 

## https://www.r-bloggers.com/2021/04/random-forest-in-r/ n

## Random Forest is more stable than maximum likelihood  



