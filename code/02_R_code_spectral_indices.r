

library(here)
here()
library(raster)
## Remote Sensing Toolbox  
library(RStoolbox)


library(rgdal)
library(rasterdiv)


# library(rasterdiv)

# setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac

# Exercise: import the first file -> defor1_.jpg -> give it the name l1992

l1992 <- brick(here("lab/data/defor1.jpg"))
l2006 <- brick(here("lab/data/defor2.jpg"))  

## This image has only 3 bands and they are:   

# layer1 = nir (Red channel of RGB) ~ for sure  
# layer2 = red
# layer3 = green 


plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

                 

# RStoolbox::spectralIndices ---------------------------------------------------------

## spectralIndices Documentation https://www.rdocumentation.org/packages/RStoolbox/versions/0.3.0/topics/spectralIndices 

## Indices  differences/sum  
## If I want to calculate the vegetation biomass without considering the impact of 
##the soil, I can remove the soil:  

## MSAV & MSAV2 

### Example:  In a wetland, REMOVE The effect of water.  

### Import the data from the lab folder defor1.jpg = 1992  & defor2.jpg = 2006






# Exercise: import the second file -> defor2_.jpg -> give it the name l2006
l2006 <- brick(here("physalia_ecol_rs_2022/data/defor2_.jpg"))

# l2006 <- brick("p224r63_2011.grd")
l2006

plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

# Exercise: plot in a multiframe the two images with one on top of the other
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")

##%######################################################%##
#                                                          #
####        Blue means the water is more clear.         ####
####             White mans there was a lot             ####
####             of solids in the water.                ####
####       ######  # Images at earth observatory        ####
#                                                          #
##%######################################################%##


# DVI Difference Vegetation Index  = NIR - RED  
# 0 to 255  an 8 bit image 

# 255 - 20  The value of the tropical vegetation  

# with no vegetation 100 - 50 
## The number of bits should be the same   
## Max values 255 

dvi1992 = l1992[[1]] - l1992[[2]]  ## NIR - RED  
# or:
# dvi1992 = l1992$defor1_.1 - l1992$defor1_.2
dvi1992 

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1992, col=cl)

# DVI Difference Vegetation Index
dvi2006 = l2006[[1]] - l2006[[2]]
dvi2006

plot(dvi2006, col=cl)


# DVI difference in time
dvi_dif = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(dvi_dif, col=cld)

#- day 2

# Range DVI (8 bit): -255 a 255
# Range NDVI (8 bit): -1 a 1

# Range DVI (16 bit): -65535 a 65535
# Range NDVI (16 bit): -1 a 1

# Hence, NDVI can be used to compare images with a different radiometric resolution

# NDVI 1992
dvi1992 = l1992[[1]] - l1992[[2]]
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
# or
ndvi1992 = (l1992[[1]] - l1992[[2]]) / (l1992[[1]] + l1992[[2]])

cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(ndvi1992, col=cl)

# multiframe con il plotRGB dell'immagine sopra
# e l'ndvi sotto

# Multiframe with plotRGB on top of the NDVI image
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
plot(ndvi1992, col=cl)

# 2006
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])

# Multiframe with NDVI1992 on top of the NDVI2006 image
par(mfrow=c(2,1))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# Automatic spectral indices by the spectralIndices function
si1992 <- spectralIndices(l1992, green=3, red=2, nir=1)
plot(si1992,col=cl)

si2006 <- spectralIndices(l2006, green=3, red=2, nir=1)
plot(si2006,col=cl)
 
### rasterdiv
# plot(copNDVI)

### End of Day 2 #### 
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme


si2006 <- spectralIndices(l2006, green=3, red = 2, nir=1)

pairs(si2006)


# Multitemporal analysis of remote sensing data:  greenland ice me --------



