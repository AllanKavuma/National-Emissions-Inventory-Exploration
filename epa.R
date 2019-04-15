##Introduction

#import libraries required for  script
library(dplyr)
library(ggplot2)

#Read files
nei_data <- readRDS("summarySCC_PM25.rds")
scc_data <- readRDS("Source_Classification_Code.rds")

#question 1
png(filename = "plot1.png")
with(nei_data, boxplot(log10(Emissions) ~ year, 
                       main = "Box plot for Year Emissions", 
                       ylab = "log10(Emissions)", 
                       xlab = "Years"))
dev.off()

##Question 2
##Have total emissions from PM2.5 decreased in the 
##Baltimore City, Maryland (fips == "24510") from 1999 to 2008

###create balt_dt to store Baltimore, Maryland data
balt_dt <- nei_data %>% filter(fips == "24510")
##Box plot
png(filename = "plot2.png")
with(balt_dt, boxplot(log10(Emissions) ~ year, 
                       main = "Box plot for Baltimore, Maryland Year Emissions", 
                       ylab = "log10(Emissions)", 
                       xlab = "Years"))
dev.off()

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
#ggsave(file = "plot3.png")

##Question 4
##Across the United States, how have emissions from coal 
##combustion-related sources changed from 1999-2008?

##create indices for subsetting nei_data for only the 
##coal related observations
cl <- grepl("[Cc]oal", scc_data$Short.Name)
dcl <- scc_data[cl,]
dcl_u <- unique(dcl$SCC)

##subset the nei_data for coal related emmissions
coal_data <- nei_data %>% filter(SCC %in% dcl_u)
#coal_data <- nei_data[nei_data$SCC %in% dcl_u,]


##plot the graph for comparison over the years
png(filename = "plot4.png")
ggplot(data = coal_data, aes(year, Emissions)) + 
        geom_point(aes(color = year)) + 
        labs(title = "Emissions from coal combustion-related sources from 1999-2008")
dev.off()
ggsave(file = "plot4.png")

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


##Question 3
#Compare emissions from motor vehicle sources in Baltimore City 
#with emissions from motor vehicle sources in Los Angeles County, 
#California (\color{red}{\verb|fips == "06037"|}fips=="06037"). 
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
png(filename = "plot5.png")
par(mfrow = c(1, 2))
with(balt_vdt, plot(year, Emissions, main = "Baltimore Emissions"))
with(cal_vdt, plot(year, Emissions, main = "California Emissions"))
dev.off()

##+++++++++++++++++++++++++++++++++++++
## THE END




##Other Tests
##summarise emissions for two cities by year and average emissions
balt_vmn <- balt_vdt %>% group_by(year) %>% summarise(mn_e1 = mean(Emissions))
cal_vmn <- cal_vdt %>% group_by(year) %>% summarise(mn_e1 = mean(Emissions))

##merge the two tables for average emissions
vmn <- merge(balt_vmn, cal_vmn, by = "year")
names(vmn) <- c("year", "baltimorevmean", "californiavmean")

##plot the graph
with(vmn, plot(rep(1999,2), vmn[ ,2]))

##Question 3, solution 2
calbalt_dt <- nei_data %>% filter(fips %in% c("06037", "24510"))
calbalt_vdt<- calbalt_dt %>% filter(SCC %in% dvl_u)

