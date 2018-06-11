# japan-population-chropleth
🇯🇵🗾 with some 🚉train station data against 2016 population data.

## The reason for experiment

I wanted to figure out how to use Shapefile with ggplot. 
ggplot2 now has function called geom_sf, so I wanted to try figuring out how I can utilze this function! 


### Shapefile for Japan 
I've downloaded shapefile from Esri site. https://www.esrij.com/products/japan-shp/
This shapefile had population data from 2016. So I've used this data to colour each section of map. 

### Train Station Data from Ekidata
I wanted to figure out if I can overlay location data on top of chropleth map, so I've decided to use train station location to overlay.  http://www.ekidata.jp/


## Chropleth Map of Japan (coloured with population data from 2016 Jan 1st)

![Japan Chropleth Population Map](https://github.com/chichacha/japan-population-chropleth/blob/master/PNGs/JapanChropleth.png "Japan")


### Tokyo 
Tokyo excluding islands.  
x is where train stations are located. Train station with more than 3 transfers are labeled.  (Little too crowded for Tokyo, probably need to adjust later.)

![Tokyo](https://github.com/chichacha/japan-population-chropleth/blob/master/PNGs/Tokyo.png "Japan")
Here's another variation of map with name of area displayed.
![Tokyo Named](https://github.com/chichacha/japan-population-chropleth/blob/master/PNGs/Tokyo_Labeled.png "Japan")

### Kanagawa Prefecture
x is where train stations are located. 
![Kanagawa](https://github.com/chichacha/japan-population-chropleth/blob/master/PNGs/Kanagawa.png "Japan")

Here's another version with names of area. 
![Kanagawa CityNames](https://github.com/chichacha/japan-population-chropleth/blob/master/PNGs/Kanagawa_CityLabel.png "Japan")

