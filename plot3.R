#import libraries required for  script
library(dplyr)
library(ggplot2)

#Read files
nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

###create balt_dt to store Baltimore, Maryland data
balt_dt <- nei_data %>% filter(fips == "24510")


#Question 3
##Of the four types of sources indicated by the 
##type(point, nonpoint, onroad, nonroad) variable, which of these
##four sources have seen decreases/increases in emissions from 
##1999-2008 for Baltimore City

png(filename = "plot3.png", width = 480, height = 480)
ggplot(data = balt_dt, aes(year, log10(Emissions))) + 
        geom_boxplot(aes(color = type)) + 
        facet_grid(.~year) + 
        theme(axis.title.x.top = element_blank(), axis.text.x=element_blank(), axis.ticks.x = element_blank()) + 
        labs(title = "Emissions for the Types of Emission Sources")
dev.off()
ggsave(file = "plot3.png")


##Non-road decreases
##On-road decreases till 2005, slightly increases in 2008
##Point decreases 
##Nonpoint increases
