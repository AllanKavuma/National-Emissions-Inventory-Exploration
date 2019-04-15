#import libraries required for  script
library(dplyr)
library(ggplot2)

#Read files
nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

##Question 6
#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, 
#California (fips=="06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

##data for Califonia stored in bc_dt
cal_dt <- nei_data %>% filter(fips == c("06037"))
##data for Baltimore
balt_dt <- nei_data %>% filter(fips == "24510")
vl <- grep("[Vv]ehicle", scc_data$Short.Name)
dvl <- scc_data[vl, ]
dvl_u <- unique(dvl$SCC)


##Filter out only observations with Vehicle emissions
##balt_vdt and cal_vdt have vehicle data for baltimore and California
balt_vdt <- balt_dt %>% filter(SCC %in% dvl_u)
cal_vdt <- cal_dt %>% filter(SCC %in% dvl_u)

##plot the graphs for Baltimore and California
png(filename = "plot6.png")
par(mfrow = c(1, 2))
with(balt_vdt, plot(year, Emissions, col = "green", main = "Baltimore Emissions"))
with(cal_vdt, plot(year, Emissions, col = "red",main = "California Emissions"))
dev.off()

##California has had greater changes over time in Vehicle emmisions than
##Baltimore