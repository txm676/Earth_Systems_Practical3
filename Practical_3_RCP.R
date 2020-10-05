#---
# title: "R Practical 3 - exploring RCP scenarios"

# Tom Matthews (Original author: Tom Pugh)
# 29.09.20
#---

# Remember, these practicals are your record of the operations and calculations
# that you have made. In this way, you have a recipe of all the operations to recreate a
# particular plot or number. This means that you can very quickly rerun it at
# any time, and more importantly, change and/or correct it and rerun it with
# very little effort. It will save you a lot of time in the long run!

# The aims of this practical are twofold:

# 1) Cement the R skills you need for the rest of this module.

# 2) Explore the implications of different climate scenarios for important climate variables such as temperature.


## Exploring global temperature changes ---

# In Practical 1 you made line plots of global CO2 equivalent concentrations for
# different RCPs.In this week's practical folder there are data for lots of different Global Climate
# Models. Lets set the working directory to this week's folder.

setwd("/home/jovyan/Earth_Systems_Practical3")

#As a first step you are going to make similar plots to those in Practical 1 to
#assess how the predictions of a specific GCM (HadGEM2-ES) vary for different
#RCP scenarios.

#Plot all the RCPs for HadGEM2-ES
tas_rcp85_hadgem = read.table("global_tas_Amon_HadGEM2-ES_rcp85_ave_annual.txt",header=TRUE,skip=1)

#We plot the first set of data using the plot() function
plot(x=tas_rcp85_hadgem$Year, y=tas_rcp85_hadgem$Temp.K., xlab="Year", 
     ylab=expression("Annual mean temperature (K)"), type='l', lwd=2, col="darkgreen")

#And then we can add on the other data to this plot using the lines() function. This should be
#familiar to you from the previous practicals.
tas_rcp26_hadgem = read.table("global_tas_Amon_HadGEM2-ES_rcp26_ave_annual.txt",header=TRUE,skip=1)

lines(x=tas_rcp26_hadgem$Year, y=tas_rcp26_hadgem$Temp.K.,col="red", type='l', lwd=2)

tas_rcp45_hadgem = read.table("global_tas_Amon_HadGEM2-ES_rcp45_ave_annual.txt",header=TRUE,skip=1)

lines(x=tas_rcp45_hadgem$Year, y=tas_rcp45_hadgem$Temp.K.,col="blue", type='l', lwd=2)

tas_rcp60_hadgem = read.table("global_tas_Amon_HadGEM2-ES_rcp60_ave_annual.txt",header=TRUE,skip=1)

lines(x=tas_rcp60_hadgem$Year, y=tas_rcp60_hadgem$Temp.K.,col="orange", type='l', lwd=2)

#we will also add a legend - we can do this by using the legend() function. The first two arguments
#tell the function where we want the legend to be (in relation to the x and y axis) and the other arguments
#relate to what we want the legend to show.
#As with all functions, use ?legend to bring up a full list of the arguments for the function and what they
#all do etc.

?legend

#Play around with the first two arguments to try and move the legend to the top left corner

legend(1900, 291, legend=c("RCP85", "RCP26", "RCP45", "RCP60"), 
       col=c("darkgreen", "red", "blue", "orange"), lty = 1)

#QUESTION: How do the predictions vary in terms of temperature changes for the different RCPs? 


#We can then have a look at how the predictions of different GCMs differ for the same RCP

#hadgem2-es
plot(x=tas_rcp85_hadgem$Year, y=tas_rcp85_hadgem$Temp.K., xlab="Year", 
     ylab=expression("Annual mean temperature (K)"), type='l', lwd=2, col="darkgreen",ylim=c(285,294),xlim=c(1850,2100))

#GISS
tas_rcp85_giss = read.table("global_tas_Amon_GISS-E2-R_rcp85_r1i1p1_annual.txt",header=TRUE,skip=1)
lines(x=tas_rcp85_giss$Year, y=tas_rcp85_giss$Temp.K.,col="red", type='l', lwd=2)

#CCSM4
tas_rcp85_ccsm = read.table("global_tas_Amon_CCSM4_rcp85_ave_annual.txt",header=TRUE,skip=1)
lines(x=tas_rcp85_ccsm$Year, y=tas_rcp85_ccsm$Temp.K.,col="blue", type='l', lwd=2)

#CanESM
tas_rcp85_canesm = read.table("global_tas_Amon_CanESM2_rcp85_ave_annual.txt",header=TRUE,skip=1)
lines(x=tas_rcp85_canesm$Year, y=tas_rcp85_canesm$Temp.K.,col="orange", type='l', lwd=2)

#IPSL
tas_rcp85_ipsl = read.table("global_tas_Amon_IPSL-CM5A-LR_rcp85_ave_annual.txt",header=TRUE,skip=1)
lines(x=tas_rcp85_ipsl$Year, y=tas_rcp85_ipsl$Temp.K.,col="purple", type='l', lwd=2)

#lets also plot an average (mean) of the different RCPs as black line
tas_rcp85_mean = read.table("global_tas_Amon_modmean_rcp85_000_annual.txt",header=TRUE,skip=1)
lines(x=tas_rcp85_mean$Year, y=tas_rcp85_mean$Temp.K.,col="black", type='l', lwd=3)

##CODE IT YOURSELF: have a go at adding a legend for this plot, using the legend code above
#as a guide

legend()

#QUESTION: how would you interpret this plot if you were summarizing it for a policy maker?


#We can also make other plots that can help us understand how global climate may change
#under different future scenarios. For example,

#What is the relationship between CO2 concentration and temperature for RCP85 and a particular GCM?

co2_conc_rcp85 <- read.table("RCP85_MIDYR_CONC_CO2.txt",header=TRUE)

plot(x=co2_conc_rcp85$CO2.ppm., y=tas_rcp85_ccsm$Temp.K., xlab="CO2 mixing ratio", 
     ylab=expression("Annual mean temperature (K)"), type='p', lwd=2, col="darkgreen")

#What about the relationship of CO2 emissions to temperature?

co2_emiss_rcp85 = read.table("RCP85_EMISSIONS_FOSSILCO2.txt",header=TRUE)

plot(x=co2_emiss_rcp85$FOSSILCO2.GtC.yr., y=tas_rcp85_ccsm$Temp.K., xlab="CO2 emissions", 
     ylab=expression("Annual mean temperature (K)"), type='p', lwd=2, col="darkgreen")

## Spatial Variation in Climate Predictions
# It's now time to look at how these changes play out spatially. In the
# working directory you will find netcdf files containing
# outputs from the HadGEM2-ES GCM. We will first read in and
# plot a map of global temperature ("tas", see the data catalogue for a list of
# what the filenames mean) for 1970-1999.

#we will do this using the same code as from last week's practical, so make sure
#to go through that if you have not already done so. Also, if anything is not clear
#go back and check through the notes from last week to refresh.

#these package should all be installed from last week but if they are not, remember
#to use install.packages("name") to install each one individually

#install.packages("ncdf4")

library("ncdf4")

library("fields")

library("viridis")

library("maps")

file_tas_hadgem_1970_1999 <- nc_open('tas_HadGEM2-ES_historical_r1i1p1_ext1970-1999_ann_mean_1deg.nc')

lat_hadgem_1970_1999 <- ncvar_get(nc=file_tas_hadgem_1970_1999, varid='lat')

lon_hadgem_1970_1999 <- ncvar_get(nc=file_tas_hadgem_1970_1999,varid='lon')

tas_hadgem_1970_1999 <- ncvar_get(nc=file_tas_hadgem_1970_1999, varid='tas')

nc_close(file_tas_hadgem_1970_1999)

image.plot(tas_hadgem_1970_1999)

#as we saw last week, the data are all upside down so we need to flip them again.

tas_hadgem_1970_1999_flip <- tas_hadgem_1970_1999[,180:1]

lat_hadgem_1970_1999_flip <- lat_hadgem_1970_1999[180:1]


image.plot(lon_hadgem_1970_1999, lat_hadgem_1970_1999_flip, tas_hadgem_1970_1999_flip, 
           col=viridis(256), xlab="", ylab="", main="Mean surface temperature, HagGEM2-ES, 1970-1999", 
           legend.lab="K", legend.line=4, legend.mar=7)

map(database = 'world', add = T, lwd=1.5)

#This should look like what we would expect for spatial variation in temperature across the globe. 
#Now read in the predicted future temperature data in the same way for one of the RCP scenarios
# for the years 2070-2099.

file_tas_hadgem_rcp85_2070_2099 <- nc_open('tas_HadGEM2-ES_rcp85_r1i1p1_ext2070-2099_ann_mean_1deg.nc')

lat_hadgem_rcp85_2070_2099=ncvar_get(nc=file_tas_hadgem_rcp85_2070_2099, varid='lat')

lon_hadgem_rcp85_2070_2099=ncvar_get(nc=file_tas_hadgem_rcp85_2070_2099,varid='lon')

tas_hadgem_rcp85_2070_2099 = ncvar_get(nc=file_tas_hadgem_rcp85_2070_2099, varid='tas')

nc_close(file_tas_hadgem_rcp85_2070_2099)

#flip the data again
tas_hadgem_rcp85_2070_2099_flip <- tas_hadgem_rcp85_2070_2099[,180:1]

lat_hadgem_rcp85_2070_2099_flip <- lat_hadgem_rcp85_2070_2099[180:1]

image.plot(lon_hadgem_rcp85_2070_2099, lat_hadgem_rcp85_2070_2099_flip, 
           tas_hadgem_rcp85_2070_2099_flip, col=viridis(256), xlab="", 
           ylab="", main="Mean surface temperature, HagGEM2-ES, RCP 8.5, 2070-2099", 
           legend.lab="K", legend.line=4, legend.mar=7)

map(database = 'world', add = T, lwd=1.5)


# CODE IT YOURSELF: Using the skills you learnt last week, have a go at calculating, and then plotting a map of, 
# how temperature differs between these two timeslices, i.e. between future (tas_hadgem_rcp85_2070_2099_flip) 
# and current (tas_hadgem_1970_1999_flip) temperature. Call the object temp_diff.

temp_diff <- 

image.plot()

map(database = 'world', add = T, lwd=1.5)

# QUESTION: How does the difference in temperature between 1970-1999 and 2070-2099 differ
# across space? How does this compare to the current spatial distribution of temperature?
# Which areas are warming up more than others? Make some notes below as comments.


# As we saw last week, we can focus in on particular regions as well as looking at the whole
# world. Lets first choose a region of particularly large temperature change. Remember that,
# although the longitude (x-axis) and latitude (y-axis) values range from -180 to 180 and -90 to 90,
# respectively, the row (longitudes) and columns (latitudes) of the temp_diff matrix start at 0. So,
# if we want to select the left part of the world (i.e. where Canada is located), lets say longitude values
# between -180 and 80 (bottom left corner and across by 100), we need to select rows 0 to 100. And then the same
# logic applies for latitude and columns in our temp_diff matrix. Knowing this, we can select a rough region for North
# Canada.

north_canada <- temp_diff[0:100, 150:180]

image.plot(north_canada, col=viridis(256))

#beware the colour scale will re-scale for each plot, so the legend with a colour bar range is important

#We can then calculate the mean temperature across just this region.

mean(north_canada)

#CODE IT YOURSELF: seeing how you subsetted out north canada, have a go yourself
#but this time select a region (e.g. the tropics in Central / South America)
#which is predicted to experience lower temperature change. Then calculate the
#mean temperature change for this region. Compare the mean with that for north
#Canada - does the value make sense? If so, you now have hard numbers to support
#the visual inferences that you were making above.




# An alternative to looking at the difference between the historical and future
# is to look at the difference map between two different RCPs for the same time
# period. In this way you can see the consequences for local temperature of
# different levels of global temperature change.


#lets load in the predicted future temperature for RCP 8.5 from the HadGEM2-ES GCM.
file_tas_hadgem_rcp85_2070_2099 <- nc_open('tas_HadGEM2-ES_rcp85_r1i1p1_ext2070-2099_ann_mean_1deg.nc')

lat_hadgem_rcp85_2070_2099=ncvar_get(nc=file_tas_hadgem_rcp85_2070_2099, varid='lat')

lon_hadgem_rcp85_2070_2099=ncvar_get(nc=file_tas_hadgem_rcp85_2070_2099,varid='lon')

tas_hadgem_rcp85_2070_2099 = ncvar_get(nc=file_tas_hadgem_rcp85_2070_2099, varid='tas')

nc_close(file_tas_hadgem_rcp85_2070_2099)

#flip the data as before
tas_hadgem_rcp85_2070_2099_flip <- tas_hadgem_rcp85_2070_2099[,180:1]

lat_hadgem_rcp85_2070_2099_flip <- lat_hadgem_rcp85_2070_2099[180:1]

image.plot(lon_hadgem_rcp85_2070_2099, lat_hadgem_rcp85_2070_2099_flip, 
           tas_hadgem_rcp85_2070_2099_flip, col=viridis(256), xlab="", 
           ylab="", main="Mean surface temperature, HagGEM2-ES, RCP 8.5, 2070-2099", 
           legend.lab="K", legend.line=4, legend.mar=7)

map(database = 'world', add = T, lwd=1.5)

#We can then load in the predicted future temperature for the same time period but based on RCP 2.6.
file_tas_hadgem_rcp26_2070_2099 <- nc_open('tas_HadGEM2-ES_rcp26_r1i1p1_ext2070-2099_ann_mean_1deg.nc')

lat_hadgem_rcp26_2070_2099=ncvar_get(nc=file_tas_hadgem_rcp26_2070_2099, varid='lat')

lon_hadgem_rcp26_2070_2099=ncvar_get(nc=file_tas_hadgem_rcp26_2070_2099,varid='lon')

tas_hadgem_rcp26_2070_2099 = ncvar_get(nc=file_tas_hadgem_rcp26_2070_2099, varid='tas')

nc_close(file_tas_hadgem_rcp26_2070_2099)

#flip the data as before
tas_hadgem_rcp26_2070_2099_flip <- tas_hadgem_rcp26_2070_2099[,180:1]

lat_hadgem_rcp26_2070_2099_flip <- lat_hadgem_rcp26_2070_2099[180:1]

image.plot(lon_hadgem_rcp26_2070_2099, lat_hadgem_rcp26_2070_2099_flip, 
           tas_hadgem_rcp26_2070_2099_flip, col=viridis(256), xlab="", 
           ylab="", main="Mean surface temperature, HagGEM2-ES, RCP 2.6, 2070-2099", 
           legend.lab="K", legend.line=4, legend.mar=7)

map(database = 'world', add = T, lwd=1.5)


#CODE IT YOURSELF: now as a final step, calculate the difference between the two and
#then plot these differences. 

tas_hadgem_diff <- 
        
image.plot()

map(database = 'world', add = T, lwd=1.5)

#QUESTION: where are the biggest differences in predicted future temperature based on the two
#RCPs? How does this match up with what you saw earlier regarding the regions predicted to experience
#the greatest temperature increases?


### And we are finished! ---
#Well done! You can now hopefully see how you can use R to help you understand current
#climate patterns, and interpret the predictions of future change from different
#GCMs. We have focused primarily on temperature in today's practical, but the same concepts
#apply for other climate variables, such as precipitation. In fact, any spatial variable
#can be modeled and mapped in the same way!










