### Visualizing with ggplot2 - Graduated Symbols & Heatmaps
library(ggplot2)
library(ggmap)
library(gridExtra)

#Load trap data
dc_traps <- read.csv(file = "~/272A_Week5_Toolkit/dc_trap_sites.csv", header = TRUE)
class(dc_traps) #data frame needed to work well with ggplot

dc_map <- get_stamenmap(bbox = c(left = -77.13, bottom = 38.81, right = -76.92, top = 39.0), maptype = "terrain", zoom = 12)
ggmap(dc_map) #loading and prepping DC map

colnames(dc_traps)

ggmap(dc_map) + geom_point(data = dc_traps, aes(x = LONGITUDE, y = LATITUDE), col = "red")

#Map colored by trap type
ggmap(dc_map) + geom_point(data = dc_traps, aes(x = LONGITUDE, y = LATITUDE, col = TRAPTYPE)) + theme_bw() #+
#scale_color_discrete(name = "Trap Type") + ggtitle("Mosquito Trap Types in DC")

#Male mosquitoes map
ggmap(dc_map) + geom_point(data = dc_traps, aes(x = LONGITUDE, y = LATITUDE, size = MALESCOLLE), col = "blue") + theme_bw() +
  guides(size = guide_legend(title = "# of Males Collected")) + ggtitle("Male Mosquito Collections in DC") + theme(plot.title = element_text(hjust = 0.5))

#Female mosquitoes map
ggmap(dc_map) + geom_point(data = dc_traps, aes(x = LONGITUDE, y = LATITUDE, size = FEMALESCOL), col = "red") + theme_bw() +
  guides(size = guide_legend(title = "# of Males Collected")) + ggtitle("Female Mosquito Collections in DC") + theme(plot.title = element_text(hjust = 0.5))

male_map <- ggmap(dc_map) + geom_point(data = dc_traps, aes(x = LONGITUDE, y = LATITUDE, size = MALESCOLLE), col = "blue") + theme_bw() +
  guides(size = guide_legend(title = "# of Males Collected")) + ggtitle("Male Mosquito Collections in DC") + theme(plot.title = element_text(hjust = 0.5))

female_map <- ggmap(dc_map) + geom_point(data = dc_traps, aes(x = LONGITUDE, y = LATITUDE, size = FEMALESCOL), col = "red") + theme_bw() +
  guides(size = guide_legend(title = "# of Males Collected")) + ggtitle("Female Mosquito Collections in DC") + theme(plot.title = element_text(hjust = 0.5))

grid.arrange(female_map, male_map, ncol = 2)

#Heatmap

ggmap(dc_map) + stat_density_2d(geom = "polygon", data = dc_traps, aes(x = LONGITUDE, y = LATITUDE, fill = stat(level))) +
  scale_fill_viridis_c()

#Increase Alpha
ggmap(dc_map) + stat_density_2d(geom = "polygon", data = dc_traps, aes(x = LONGITUDE, y = LATITUDE, fill = stat(level)), alpha = 0.5) +
  scale_fill_viridis_c()
