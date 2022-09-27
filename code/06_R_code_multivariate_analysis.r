# R_code_multivariate_analysis.r  

### https://rdrr.io/cran/RStoolbox/man/rasterPCA.html  
### Presentation #6:  Species Distrib;ution Modeling  
library(raster)
library(RStoolbox)
library(here)

library(ggplot2)
library(patchwork)
# install.packages("gridExtra")
library(gridExtra) # for grid.arrange plotting

## Colorblind friendly  
library(viridis)


# setwd("~/lab/") # Linux
# setwd("C:/lab/") # Windows
# setwd("/Users/name/Desktop/lab/") # Mac 

p224r63_2011 <- brick(here("lab/data_book/raster_data/final/p224r63_2011_masked.grd"))

## Plot all 7 bands:  
plot(p224r63_2011)

### Pairs shows us how the different variables are correlated
### Pairwise correlation:  
p224r63_2011

plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=19, cex=2)
plot(p224r63_2011$B2_sre, p224r63_2011$B1_sre, col="red", pch=19, cex=2)

### Pairs shows us how the different variables are correlated
### Pairwise correlation:  

pairs(p224r63_2011)

# aggregate cells: resampling (ricampionamento)
# -res "resampling" 
# iNCREASING BY A FACTOR OF 10  (FOR DIDACTIC REASONS)


p224r63_2011res <- aggregate(p224r63_2011, fact=10)

#### compare the two  
p224r63_2011res
p224r63_2011  




par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")

# rasterPCA from RStoolbox ------------------------------------------------



p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

p224r63_2011res_pca
p224r63_2011res_pca$call
p224r63_2011res_pca$model
p224r63_2011res_pca$map  # raster brick with all of hte 7 components

summary(p224r63_2011res_pca$model)
 ## pROPORTION OF VARIANCE 
## THERMAL BAND HAS A WIDE RANGE.  
## CAN SEE THEM GRAPHICALLY  

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) 

plot(p224r63_2011res_pca$map, col=clsd)
## 1:45
# dev.off()
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")

### THE FIRST ONE HAS THE HIGHEST VARIATION

### Plot without clsd 
plot(p224r63_2011res_pca$map)


#### make rgb plot

ggRGB(p224r63_2011res_pca$map, 1, 2, 3)

## Since this is a PCA, the colors have no meaning  
plot(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")
        
# sd3   Use the first PCA to calculate the SD  with the focal() function

### 2:00

sdp3 <- focal(p224r63_2011res_pca$map$PC1, matrix(1/9, 3, 3), fun=sd)



# -------------------------------------------------------------------------

### Use the first component of the PCA = PC1
### Then calculate the SD in the 3/3 window  
sdp3 <- focal(p224r63_2011res_pca$map$PC1, matrix(1/9, 3, 3), fun=sd)

ggplot() + 
  geom_raster(sdp3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis(option = "magma") +
  ggtitle("Standard deviation by viridis package - magma palette")

ggplot() + 
  geom_raster(sdp3, mapping =aes(x=x, y=y, fill=layer)) + 
  scale_fill_viridis(option = "cividis") +
  ggtitle("Standard deviation by viridis package - cividis palette")
### compare the original 30x30 
### this will show you where the breaks are  to see ... 
### here, you just concentrate on the big variations  - all the trees are similar
### Review:  Spectral Species in Living Color:  https://agupubs.onlinelibrary.wiley.com/doi/epdf/10.1029/2022JG007026 



### Use a low resolution image to see the "big" variations 



  
# -------------------------------------------------------------------------

# g1 <- ggRGB(p224r63_2011, 4, 3, 2)
# g2 ,- 
# 




