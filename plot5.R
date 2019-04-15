#import libraries required for  script
library(dplyr)
library(ggplot2)

#Read files
nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

##How have emissions from motor vehicle sources changed 
##from 1999-2008 in Baltimore City?
vl <- grep("[Vv]ehicle", scc_data$Short.Name)
dvl <- scc_data[vl, ]
dvl_u <- unique(dvl$SCC)

##Create dataframe balt_dt to hold data from Baltimore City
balt_dt <- nei_data %>% filter(fips == "24510")
##Filter out only observations with Vehicle emissions
balt_vdt <- balt_dt %>% filter(SCC %in% dvl_u)

##Plot the graph showing the vehicle emissions
png(filename = "plot5.png")
ggplot(data = balt_vdt, aes(year, Emissions)) + 
        geom_point(aes(color = year)) + 
        labs(title = "Baltmore City Motor Vehicle Emissions from 1999 to 2008")
dev.off()
ggsave("plot5.png")

##Emissions have decrease.
##No spikes in 2008