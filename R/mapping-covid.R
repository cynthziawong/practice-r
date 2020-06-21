install.packages("htmltools")
install.packages("maps")
install.packages("mapproj")
install.packages("mapdata")
install.packages("ggmap")
install.packages("tidyverse")
install.packages("leaflet")
install.packages("leaflet.extras")

library(htmltools)
library(maps)
library(mapproj)
library(mapdata)
library(tidyverse)
library(ggmap)
library(leaflet)
library(leaflet.extras)

#plot map of US
usa<-ggplot2::map_data( "state") 
ggplot(usa, aes(x=long, y=lat, fill=region))+
    geom_polygon(color='black')+
    coord_map()+
    guides(fill=FALSE)+
    theme_void()+
    ggtitle("USA")

#extracting covid data for USA
usa_d<-read.csv("/Users/cynthiaw/Documents/R-Docs/Input-CSV-files/US_MAP_DATA.csv")
usa_covid<-usa_d%>%filter(date=="2020-06-12")%>%
                  arrange(desc(cases))

#merge US map with US COVID Data
data<-merge(usa, usa_covid,
            by.x='region',
            by.y='state')

#plotting the covid data on the US map
ggplot(data, aes(x=long, y=lat, group=group, fill=cases))+
    geom_polygon(color='black')+
    coord_map()+
    ggtitle("USA COVID CASES")+
    scale_fill_gradient2(high='red')


