# R code for ecosystem monitoring by remote sensing
# First of all, we need to install additional packages
# raster package to manage image data
# https://cran.r-project.org/web/packages/raster/index.html


##%######################################################%##
#                                                          #
####          spectral vegetation index (NIR −          ####
####                    SWIR)/(NIR +                    ####
####                       SWIR)                        ####
####     https://www.tandfonline.com/doi/abs/10.10      ####
####     80/01431161.2010.510811?journalCode=tres20     ####
####                        The                         ####
####         spectral vegetation index (ρNIR −          ####
####         ρSWIR)/(ρNIR + ρSWIR),  where ρNIR         ####
####          and ρSWIR are the near-infrared           ####
#### (NIR) and  shortwave-infrared (SWIR) reflectances, ####
####           respectively,  has been widely           ####
####  used to indicate vegetation moisture condition.   ####
#                                                          #
##%######################################################%##

#b1 = blue
#b2 = green
#b3 = red 
#b4 = nir
#b5 = swir 
#b6 = thermal ir  (resolution is 60 m)
#b7 = swir.  



### Directory 
### l1988 <- brick(here("lab/data_book/raster_data/final/p224r63_1988.grd"))
### l1988




# install.packages("raster")
library(here)
library(raster)

# Set the working directory
#  setwd("~/lab/") # Linux 
# setwd("C:/lab/")  # windows
# setwd("/Users/name/lab/") # mac

# setwd("e:/physalaia-eco-remote-sensing/lab/data_book/final/") 


# path to raster data  ----------------------------------------------------


# E:\physalia-eco-remote-sensing\lab\data_book\raster_data\final

# We are going to import satellite data
# objects cannot be numbers
l2011 <- brick(here("lab/data_book/raster_data/final/p224r63_2011.grd"))

l2011
summary(l2011)

plot(l2011)
# Trivia ------------------------------------------------------------------


## The UTM was create by Gauss.  But world did not want it named after a German scientist after WWII.


# -------------------------------------------------------------------------


# plot the raster ---------------------------------------------------------


# plot(l2011)

# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band


# change the color for all of the bands -----------------------------------

l2011$B1_sre
l2011[[1]]

 

cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011, col=cl)

# Plot a single band  ----------------------
plot(l2011$B1_sre)

plot(l2011$B1_sre, col=cl)

plot(l2011[[1]], col=cl)

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")

#----------------- day 2

# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band
# B4 is the reflectance in the NIR band

# let's plot the green band
plot(l2011$B2_sre)

cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011$B2_sre, col=cl)

# change the colorRampPalette with dark green, green, and light green, e.g. clg 
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# do the same for the blue band using "dark blue", "blue", and "light blue"
# B1
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)


par(mfrow = c(2,2)) 
plot(l2011[[1]], col=cl)
plot(l2011[[2]], col=cl)
plot(l2011[[3]], col=cl)
plot(l2011[[4]], col=cl)

# plot both images in just one multiframe graph
par(mfrow=c(1,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# plot both images in just one multiframe graph with two rows and just one column
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)


### dev.off() to remove the multiframe  

#--- day 3  Multiplots and patchwork library  ###  

plot(l2011$B1_sre)



# Create true color image  RGB --------------------------------------------  
## b3 = red, b1 = blue, b3 = greeen  
## pubt band number 1 in the blue
## band number 2 in the green shannel
## band number 3 in the red channel  

## Identify the bands Use Linear stretching  
plotRGB(l2011, r=3, g=2, b=1, stretch = "Lin")  ##NATURAL colORS  
## natural color image.  Strecthed to take the min and max value from 0 reference
## to 255.   All the values are stretched between 0 and 255



#EE Stretching:  
## Notr all of the potential values are in the bands 
## We stretch it by 




# plot the blue band using a blue colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

# multiframe
par(mfrow=c(1,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

# plot the blue and the green besides, with different colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# Exercirse: put the plots one on top of the other
# invert the number of rows and the number of columns
  
par(mfrow=c(2,1)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

# plot the blue and the green besides, with different colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# Exercise: plot the first four bands with two rows and two columns
par(mfrow=c(2,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(l2011$B3_sre, col=clr)
  
clnir <- colorRampPalette(c("red","orange","yellow"))(100)
plot(l2011$B4_sre, col= clnir)


# plot from class ---------------------------------------------------------


par(mfrow=c(2,2)) 
plot(l2022[[1]], col=cl)
plot(l2022[[2]], col=cl)
plot(l2022[[3]], col=cl)
plot(l2022[[4]], col=cl)
  
# dev.off()
## Produces error:  
### Error in dev.off() : cannot shut down device 1 (the null device)

#### NIR is the most important band #### 
#### PUT THE RED IN THE RED CHANNEL  

# tHE sPECTRAL SPECIES CONCEPT IN LIVING COLOR = ARTICLE -----------------
# sEPT 2022 

## Looking at images from a different perspective using stretch="Lin"

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")  # natural colours
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")  # false colours



# Change the reflective values in different RGB channels **** -------------


par(mfrow=c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")  # natural colours
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  # false colours - NIR in red channel 
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")  # false colours - NIR in the green channel 
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")  # false colours - NIR in the blue channel to show bare soil (yellow catches the eye)
  
# final day on this tropical forest reserve

# Histogram stretching ----------------------------------------------------
## Using NIR and Histogram streching, you can see what the eye cannot see.  

plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist") ### Histogram 

### Use NIR to see parts of the spectrum that is not visible to human eye


  library(here)
# Importing past data
setwd("~/lab/") # in case you are on a new R session
l1988 <- brick(here("lab/data_book/raster_data/final/p224r63_1988.grd"))
l1988
  
# 4 = NIR
# 3 = red 
# 2 = green  
par(mfrow=c(2,2))
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  
plotRGB(l1988, r=4, g=3, b=2, stretch="Hist")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")  


# Put the NIR in the blue channel
plotRGB(l1988, r=2, g=3, b=4, stretch="Lin")  
plotRGB(l2011, r=2, g=3, b=4, stretch="Lin")  

  
  
  
  
  ### Spectral species concept in living color (2022, Aug 13 \ https://doi.org/10.1029/2022jg007026)
  
  # https://agupubs.onlinelibrary.wiley.com/doi/10.1029/2022JG007026  
# The Spectral Species Concept in Living Color
# Duccio Rocchini,Maria J. Santos,Susan L. Ustin,Jean-Baptiste Féret,
#Gregory P. Asner,Carl Beierkuhnlein,Michele Dalponte,Hannes Feilhauer,Giles M. Foody … See all authors 
  
  
  















