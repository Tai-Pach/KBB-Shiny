library(shiny)
library(shiny.semantic)
library(semantic.dashboard)
library(leaflet)
library(data.table)
library(highcharter)
library(dplyr)
library(ggmap)
library(DT)

df <- fread('C:/Users/pache_000/Desktop/KBB_Shiny/KBB_Shiny/data/kbb.csv')
brand_count = df %>% select(., brand) %>% group_by(., brand) %>% summarise(., count = n())

#map <- leaflet(df$location) %>% addProviderTiles("Hydda.Full") %>% addMarkers()

# library(ggmap)
# AddressFrequency <- function(addresses){
#   tab <- table(addresses)
#   unique.points <- data.frame(address=names(tab), frequency = c(tab))
#   rownames(unique.points) <- NULL
#   unique.points
# }
# all.addresses <- c(df$location,df$location)
# freq <- AddressFrequency(all.addresses)
# freq <- cbind(freq, geocode(as.character(head(freq$address,2500))))
# 
# centre = c(mean(freq$lon, na.rm=TRUE), mean(freq$lat, na.rm=TRUE))
# map = get_map(location = centre, zoom=11, scale=2, source = "google", maptype="roadmap")
# # to use factos for frequencies
# # freq$frequency <- factor(freq$frequency)
# map.plot = ggmap(map)
# map.plot = map.plot + geom_point(data = freq, aes(x = lon, y = lat, colour = frequency), size=3)
# # to use color brewer gradient scale:
# # library(RColorBrewer)
# # map.plot = map.plot +  scale_colour_gradientn(colours=rainbow(4))
# print(map.plot)
# 
# 
# library(dplyr)
# 
# df2 = df %>% dplyr::select(., location) %>% group_by(., location) %>% summarise(., count = n())
