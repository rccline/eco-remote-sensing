
### (1) Multitemporal and (2) using {colorist} to view all of the spectra together.  


library(here)
library(raster)
library(rasterVis) 
library(rgdal)
library(RStoolbox)
# install.packages("spatstat")
library(ncdf4)
library(spatstat) # for random points
library(maptools) # to convert rasters to im.  

library(colorist)


## raster() is for importing single layers  
lst2000 <- raster(here("lab/greenland/lst_2000.tif")) 
lst2005 <- raster(here("lab/greenland/lst_2005.tif")) 
lst2010 <- raster(here("lab/greenland/lst_2010.tif")) 
lst2015 <- raster(here("lab/greenland/lst_2015.tif")) 

plot(lst2000) 

lst2000
# values are from 0 to 655535 
#  16 bit  2^16
# Not all of the values are present; only those from 13000 to 15000 

# Import multiple objects at the same time. -----------------------------


# build a list 
# use lapply() 

# 1. Build a list of the files:  
# 2. Apply the raster function to the whole list using lapply()  
# lapply  apply a function over a list  

## lapply() 
import <- lapply(rlist, raster)


rlist <- list.files("lab/greenland/", pattern="lst")
rlist2 <- list.files(pattern = "lst", path = "lab/greenland/")

gpath <- paste0("lab/greenland/", rlist)

import <- lapply(gpath, raster)
import


# stack images  -----------------------------------------------------------


TGr <- stack(import)
TGr

plot(TGr)

plotRGB(TGr, 1, 2, 3, stretch = "Lin") # First layer in the red is 2000, second is 2005 etc  
plotRGB(TGr, 2, 3, 4, stretch = "Lin")
plotRGB(TGr, 4, 3, 2, stretch = "Lin") # The highest separator is blue  (2015) 

#  levelplot(TGr) ---------------------------------------------------------

# levelplot(TGr, col.regions = cl, names.attr="July 2000", "July 2005", "July 2010", "July 2015")) 


cl <- colorRampPalette(c("blue", "light blue", "pink", "red")) (100)

plot(TGr, col = cl) 
# Blue is related to lower values.  
# Blue is becoming light blue  


## Not  colorblind friendly  

## rasterdiv = An information Theory tailored R pacxkage for measuring ecosystem heterogeniety from space: To the origin and back
## Ducio Rocchini (13 December 2020)  Methods in Ecology and Evolution  



# Measure the difference between images -----------------------------------
# 


###########################################################################
# nitrogen sensors  EUROPEAN NITROGEN (EN) EXAMPLE -------------------------------------------------------

# When the nitrogen was declining in European countries over a 13 month period   
# Check NDVI ## Colorblind plot is available in github account  
###########################################################################



en01 <- raster("lab/EN/EN_0001.png")
en01

### In drive:  EN.zip  European Nitrogen   

cl <- colorRampPalette(c('red', 'orange', 'yellow'))(100) #
plot(en01, col=cl)


rlist_en <- list.files("lab/EN/", pattern="EN_")


en_path <- paste0("lab/EN/", rlist_en)

import_en <- lapply(en_path, raster)
import_en 

en <- stack(import_en)

plot(en, col=cl) 

plotRGB(en, 1, 3, 13, stretch="Lin")
plotRGB(en, 1, 3, 13, stretch="Hist") 



# Colorist package --------------------------------------------------------



library(colorist)
##%######################################################%##
#                                                          #
####   Color and visualize wildlife distributions in    ####
####         space-time using raster data.  In          ####
####     addition to enabling display of sequential     ####
####      change in distributions through the use       ####
#### of small multiples, 'colorist' provides functions  ####
####    for extracting several features of interest     ####
####        from a sequence of distributions and        ####
####      for visualizing those features using HCL      ####
#### (hue-chroma-luminance) color palettes.   Resulting ####
####      maps allow for "fair" visual comparison       ####
####      of intensity values  (e.g., occurrence,       ####
####    abundance, or density) across space and time    ####
####                 and can be used to                 ####
####       address questions about where,  when,        ####
####       and how consistently a species, group,       ####
####        or individual is likely to be found.        ####
#                                                          #
##%######################################################%##

library(colorist)

# Color each month a different color, then add all months to your map. 

####

# The stretch -------------------------------------------------------------

## Not all of the values are present; so you can use linear stetching to spread 
## Values across your spectrum

## Hist stretching:  When there are large jumps in values you get a sigmoid
## curve.  You cannot see the jump with linear stretching, so you use hist stretching  



# plot the whole stack 'en'  ----------------------------------------------


plot(en, col=cl)


# plot EN01 beside EN!3 ---------------------------------------------------
# EN01 is January
# EN13 is March  

par(mfrow=c(1,2))
plot(en[[1]], col=cl)
plot(en[[13]], col=cl)

# or

en113 <- stack(en[[1]], en[[13]])
plot(en113, col=cl)


# plot the difference between en[[1]] and en[[13]] ------------------------


difen <- en[[1]] - en[[13]] 
cldif <- colorRamp(c('blue', 'white', 'red'))(100) #
plot(difen, col=cldif)

### RED is a greater difference  
### In the two examples above, the RGB is showing all of the variations 
###    instead of one or two of the variables.  
 





