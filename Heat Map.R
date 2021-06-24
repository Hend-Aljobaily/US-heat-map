## Required Packages
install.packages("ggplot2")
install.packages("maps")

library(ggplot2)
library(maps)

#Read data
data<-read.csv(file="data.csv", header=TRUE)
data$region <- tolower(data$State) #Rename the State coulmn in your data to region to match the "state" dataset in R

states <- map_data("state")
map.df <- merge(states,data, by="region", all.x=T) #Merge the "state" dataset and your dataset by region (State)
map.df <- map.df[order(map.df$order),] #Order states alphabetically 

## Plot the Heat Map ##
## Spending By 100,000 Population ##
ggplot(map.df, aes(x=long,y=lat,group=group))+
  geom_polygon(aes(fill=Spending.100.000))+
  geom_path()+ 
  scale_fill_gradientn(colours=rev(heat.colors(20)),na.value="grey90",
                       name="$Spending\nPer 100,000\nPopulation")+
  coord_map()+theme_bw()+
  theme(axis.line=element_blank(),axis.text.x=element_blank(),
        axis.text.y=element_blank(),axis.ticks=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_blank(),
        panel.background=element_blank(),panel.border=element_blank(),panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),plot.background=element_blank())

